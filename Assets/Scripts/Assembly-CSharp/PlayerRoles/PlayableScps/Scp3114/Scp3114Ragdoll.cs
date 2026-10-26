using System.Collections.Generic;
using System.Runtime.InteropServices;
using Mirror;
using NorthwoodLib.Pools;
using PlayerRoles.Ragdolls;
using PlayerStatsSystem;
using UnityEngine;

namespace PlayerRoles.PlayableScps.Scp3114
{
	public class Scp3114Ragdoll : DynamicRagdoll
	{
		[SyncVar]
		private RoleTypeId _disguiseRole;

		[SerializeField]
		private float _revealDelay;

		[SerializeField]
		private float _revealDuration;

		[SerializeField]
		private Renderer _ownRenderer;

		private bool _playingAnimation;

		private float _revealElapsed;

		private Transform[] _trackedBones;

		private Material[] _humanMaterials;

		private Transform _humanRagdollRoot;

		private static readonly int ProgressHash = Shader.PropertyToID("_Progress");

		private static readonly int FadeHash = Shader.PropertyToID("_Fade");

		public RoleTypeId Network_disguiseRole
		{
			get
			{
				return _disguiseRole;
			}
			[param: In]
			set
			{
				GeneratedSyncVarSetter(value, ref _disguiseRole, 2uL, null);
			}
		}

		protected override void Start()
		{
			base.Start();
			if (Info.Handler is DisruptorDamageHandler || !_disguiseRole.TryGetRoleTemplate<HumanRole>(out var result) || !(result.Ragdoll.ServerInstantiateSelf(Info.OwnerHub, _disguiseRole) is DynamicRagdoll dynamicRagdoll))
			{
				return;
			}
			_ownRenderer.sharedMaterial = new Material(_ownRenderer.sharedMaterial);
			_trackedBones = dynamicRagdoll.LinkedRigidbodiesTransforms;
			_playingAnimation = true;
			_humanRagdollRoot = dynamicRagdoll.transform;
			_humanRagdollRoot.ResetTransform();
			List<SkinnedMeshRenderer> list = ListPool<SkinnedMeshRenderer>.Shared.Rent();
			dynamicRagdoll.GetComponentsInChildren(includeInactive: true, list);
			_humanMaterials = new Material[list.Count];
			for (int i = 0; i < _humanMaterials.Length; i++)
			{
				SkinnedMeshRenderer skinnedMeshRenderer = list[i];
				Material material = (skinnedMeshRenderer.sharedMaterial = new Material(Scp3114MaterialTemplates.GetVariantTemplate(skinnedMeshRenderer.sharedMaterial, Scp3114MaterialType.Reveal)));
				material.SetFloat(ProgressHash, 0f);
				_humanMaterials[i] = material;
				skinnedMeshRenderer.sharedMaterial = material;
			}
			ListPool<SkinnedMeshRenderer>.Shared.Return(list);
			dynamicRagdoll.FreezeRagdoll();
			dynamicRagdoll.gameObject.ForEachComponentInChildren((Component comp) =>
			{
				if (!(comp is Transform) && !(comp is Renderer))
				{
					Object.Destroy(comp);
				}
			}, includeInactive: true);
		}

		protected override void Update()
		{
			base.Update();
			if (!_playingAnimation)
			{
				return;
			}
			for (int i = 0; i < _trackedBones.Length; i++)
			{
				Transform transform = LinkedRigidbodiesTransforms[i];
				_trackedBones[i].SetPositionAndRotation(transform.position, transform.rotation);
			}
			if (_revealDelay > 0f)
			{
				_revealDelay -= Time.deltaTime;
				return;
			}
			if (_revealElapsed > _revealDuration)
			{
				_playingAnimation = false;
				Object.Destroy(_humanRagdollRoot.gameObject);
				return;
			}
			_revealElapsed += Time.deltaTime;
			float progress = Mathf.Clamp01(_revealElapsed / _revealDuration);
			_ownRenderer.sharedMaterial.SetFloat(FadeHash, progress);
			_humanMaterials.ForEach((Material x) =>
			{
				x.SetFloat(ProgressHash, progress);
			});
		}

		[RuntimeInitializeOnLoadMethod]
		private static void Init()
		{
			RagdollManager.ServerOnRagdollCreated += ServerOnRagdollCreated;
		}

		private static void ServerOnRagdollCreated(ReferenceHub owner, BasicRagdoll ragdoll)
		{
			if (ragdoll is Scp3114Ragdoll scp3114Ragdoll)
			{
				scp3114Ragdoll.Network_disguiseRole = RoleTypeId.None;
				if (!(owner == null) && owner.roleManager.CurrentRole is Scp3114Role { Disguised: not false } scp3114Role)
				{
					scp3114Ragdoll.Network_disguiseRole = scp3114Role.CurIdentity.StolenRole;
				}
			}
		}

		public override bool Weaved()
		{
			return true;
		}

		protected override void SerializeSyncVars(NetworkWriter writer, bool forceAll)
		{
			base.SerializeSyncVars(writer, forceAll);
			if (forceAll)
			{
				writer.WriteRoleType(_disguiseRole);
				return;
			}
			writer.WriteULong(base.syncVarDirtyBits);
			if ((base.syncVarDirtyBits & 2L) != 0L)
			{
				writer.WriteRoleType(_disguiseRole);
			}
		}

		protected override void DeserializeSyncVars(NetworkReader reader, bool initialState)
		{
			base.DeserializeSyncVars(reader, initialState);
			if (initialState)
			{
				GeneratedSyncVarDeserialize(ref _disguiseRole, null, reader.ReadRoleType());
				return;
			}
			long num = (long)reader.ReadULong();
			if ((num & 2L) != 0L)
			{
				GeneratedSyncVarDeserialize(ref _disguiseRole, null, reader.ReadRoleType());
			}
		}
	}
}
