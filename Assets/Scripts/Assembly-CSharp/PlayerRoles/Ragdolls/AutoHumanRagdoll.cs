using System;
using System.Collections.Generic;
using DeathAnimations;
using Mirror;
using PlayerRoles.FirstPersonControl;
using ProgressiveCulling;
using UnityEngine;
using UnityEngine.SceneManagement;

namespace PlayerRoles.Ragdolls
{
	public class AutoHumanRagdoll : DynamicRagdoll
	{
		[Serializable]
		private struct TrackedBone
		{
			public Transform OriginalTransform;

			public Rigidbody OriginalRigidbody;

			public List<Transform> Targets;
		}

		[SerializeField]
		[HideInInspector]
		private List<TrackedBone> _trackedBones;

		[SerializeField]
		private string _finderTempBoneName;

		[SerializeField]
		private Rigidbody _rootRigidbody;

		private bool _hasCuller;

		private CullableRig _culler;

		private readonly Dictionary<GameObject, AutoHumanRagdoll> _templates = new Dictionary<GameObject, AutoHumanRagdoll>();

		private static Transform _templateParent;

		private static Transform TemplateParent
		{
			get
			{
				if (_templateParent == null)
				{
					GameObject obj = new GameObject("AutoHumanRagdoll Template Parent");
					obj.SetActive(value: false);
					UnityEngine.Object.DontDestroyOnLoad(obj);
					_templateParent = obj.transform;
				}
				return _templateParent;
			}
		}

		public bool PauseBoneMatching { get; set; }

		protected override void Start()
		{
			base.Start();
			if (TryGetComponent<CullableRig>(out _culler))
			{
				_hasCuller = true;
				_culler.OnVisibleAgain += MatchBones;
			}
		}

		public override GameObject ClientHandleSpawn(SpawnMessage msg)
		{
			using NetworkReaderPooled networkReaderPooled = NetworkReaderPool.Get(msg.payload);
			Compression.DecompressVarUInt(networkReaderPooled);
			networkReaderPooled.ReadByte();
			if (!((RoleTypeId)networkReaderPooled.ReadSByte()).TryGetRoleTemplate<IFpcRole>(out var result))
			{
				throw new InvalidOperationException("Serialization error in AutoHumanRagdoll. The component is not the first NetworkBehaviour in hierarchy or RoleId is not the first syncvar.");
			}
			return UnityEngine.Object.Instantiate(GetOrAddTemplate(result.FpcModule.CharacterModelTemplate).gameObject, msg.position, msg.rotation);
		}

		public override BasicRagdoll ServerInstantiateSelf(ReferenceHub owner, RoleTypeId targetRole)
		{
			if (!targetRole.TryGetRoleTemplate<IFpcRole>(out var result))
			{
				throw new InvalidOperationException("AutoHumanRagdoll is only available for FPC roles.");
			}
			GameObject characterModelTemplate = result.FpcModule.CharacterModelTemplate;
			AutoHumanRagdoll autoHumanRagdoll = UnityEngine.Object.Instantiate(GetOrAddTemplate(characterModelTemplate));
			SceneManager.MoveGameObjectToScene(autoHumanRagdoll.gameObject, SceneManager.GetActiveScene());
			return autoHumanRagdoll;
		}

		private AutoHumanRagdoll GetOrAddTemplate(GameObject sourceModel)
		{
			return _templates.GetOrAdd(sourceModel, () => CreateNewTemplate(sourceModel));
		}

		private AutoHumanRagdoll CreateNewTemplate(GameObject sourceModel)
		{
			AutoHumanRagdoll autoHumanRagdoll = UnityEngine.Object.Instantiate(this, TemplateParent);
			autoHumanRagdoll.CreateNewFromSourceModel(sourceModel);
			return autoHumanRagdoll;
		}

		private void LateUpdate()
		{
			if (!base.Frozen && !_rootRigidbody.IsSleeping() && (!_hasCuller || !_culler.IsCulled))
			{
				MatchBones();
			}
		}

		private void MatchBones()
		{
			if (PauseBoneMatching)
			{
				return;
			}
			foreach (TrackedBone trackedBone in _trackedBones)
			{
				trackedBone.OriginalTransform.GetPositionAndRotation(out var position, out var rotation);
				foreach (Transform target in trackedBone.Targets)
				{
					target.SetPositionAndRotation(position, rotation);
				}
			}
		}

		private void CreateNewFromSourceModel(GameObject source)
		{
			FindTrackedBoneOriginals();
			GameObject obj = UnityEngine.Object.Instantiate(source);
			Transform transform = obj.transform;
			transform.SetParent(base.transform, worldPositionStays: false);
			transform.ResetLocalPose();
			Component[] componentsInChildren = obj.GetComponentsInChildren<Component>();
			foreach (Component component in componentsInChildren)
			{
				if (!(component is Transform) && !(component is Renderer) && !(component is LODGroup) && !(component is MeshFilter))
				{
					UnityEngine.Object.Destroy(component);
				}
			}
			PostprocessModel(transform);
			MatchBones();
		}

		private void FindTrackedBoneOriginals()
		{
			_trackedBones.Clear();
			Rigidbody[] linkedRigidbodies = LinkedRigidbodies;
			foreach (Rigidbody rigidbody in linkedRigidbodies)
			{
				_trackedBones.Add(new TrackedBone
				{
					OriginalRigidbody = rigidbody,
					OriginalTransform = rigidbody.transform,
					Targets = new List<Transform>()
				});
			}
		}

		private void PostprocessModel(Transform root)
		{
			AllDeathAnimations = GetComponentsInChildren<DeathAnimation>(includeInactive: true);
			if (TryGetComponent<CullableRig>(out var component))
			{
				component.SetTargetRenderers(new GameObject[1] { root.gameObject });
			}
			string text = base.name;
			base.name = _finderTempBoneName;
			int layer = root.gameObject.layer;
			Transform[] componentsInChildren = root.GetComponentsInChildren<Transform>();
			foreach (Transform transform in componentsInChildren)
			{
				transform.gameObject.layer = layer;
				foreach (TrackedBone trackedBone in _trackedBones)
				{
					if (!(trackedBone.OriginalTransform.name != transform.name))
					{
						trackedBone.Targets.Add(transform);
					}
				}
			}
			base.name = text;
		}

		[RuntimeInitializeOnLoadMethod]
		private static void Init()
		{
			PlayerRoleLoader.OnLoaded += OnRolesLoaded;
		}

		private static void OnRolesLoaded()
		{
			foreach (KeyValuePair<RoleTypeId, PlayerRoleBase> allRole in PlayerRoleLoader.AllRoles)
			{
				if (allRole.Value is IRagdollRole { Ragdoll: AutoHumanRagdoll ragdoll } && allRole.Value is IFpcRole fpcRole)
				{
					GameObject characterModelTemplate = fpcRole.FpcModule.CharacterModelTemplate;
					ragdoll.GetOrAddTemplate(characterModelTemplate);
				}
			}
		}

		public override bool Weaved()
		{
			return true;
		}
	}
}
