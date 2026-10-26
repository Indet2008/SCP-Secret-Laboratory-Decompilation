using System;
using System.Collections.Generic;
using GameObjectPools;
using InventorySystem.Items;
using PlayerRoles.FirstPersonControl.Thirdperson;
using PlayerRoles.FirstPersonControl.Thirdperson.Subcontrollers;
using PlayerRoles.Subroutines;
using UnityEngine;
using Utils.NonAllocLINQ;

namespace PlayerRoles.PlayableScps.Scp3114
{
	[DefaultExecutionOrder(1)]
	public class Scp3114FakeModelManager : StandardSubroutine<Scp3114Role>, ISubcontrollerRpcRedirector
	{
		[Serializable]
		private class MaterialAnimation
		{
			public float ProgressSpeed;

			public AnimationCurve FadeOverProgress;
		}

		private struct MappedBone
		{
			public Transform Original;

			public Transform Tracked;
		}

		private static readonly int ProgressHash = Shader.PropertyToID("_Progress");

		private readonly Dictionary<Material, Material> _materialInstances = new Dictionary<Material, Material>();

		private readonly Dictionary<GameObject, AnimatedCharacterModel> _disguiseModelInstances = new Dictionary<GameObject, AnimatedCharacterModel>();

		private readonly Dictionary<AnimatedCharacterModel, List<MappedBone>> _mappedBones = new Dictionary<AnimatedCharacterModel, List<MappedBone>>();

		private readonly List<Material> _materialsInUse = new List<Material>();

		private Scp3114Identity.DisguiseStatus _lastActiveStatus;

		private Scp3114MaterialType _lastMaterialType;

		private AnimatedCharacterModel _lastDisguiseModel;

		private Scp3114Model _skeletonModel;

		private float _animProgress;

		private bool _trackBones;

		private bool _wasTeammatePerpsective;

		[SerializeField]
		private AnimationCurve _boneTrackingOverDisguiseProgress;

		[SerializeField]
		private float _teammateProgressMultiplier;

		[SerializeField]
		private MaterialAnimation _disguiseAnimation;

		[SerializeField]
		private MaterialAnimation _revealAnimation;

		[field: SerializeField]
		public Material DisguiseMaterialTemplate { get; private set; }

		[field: SerializeField]
		public Material RevealMaterialTemplate { get; private set; }

		public AnimatedCharacterModel RpcTarget
		{
			get
			{
				if (!(_lastDisguiseModel != null))
				{
					return _skeletonModel;
				}
				return _lastDisguiseModel;
			}
		}

		private float AnimProgress
		{
			get
			{
				return _animProgress;
			}
			set
			{
				float num = Mathf.Clamp01(value);
				if (num != _animProgress)
				{
					_animProgress = num;
					UpdateModelMaterials();
				}
			}
		}

		private bool TeammatePerspective
		{
			get
			{
				if (ReferenceHub.TryGetPovHub(out var hub))
				{
					return hub.IsSCP();
				}
				return false;
			}
		}

		public void OnPlayerMove()
		{
			if (_lastDisguiseModel != null)
			{
				_lastDisguiseModel.OnPlayerMove();
			}
		}

		public override void SpawnObject()
		{
			base.SpawnObject();
			base.CastRole.CurIdentity.OnStatusChanged += OnIdentityChanged;
			_skeletonModel = base.CastRole.FpcModule.CharacterModelInstance as Scp3114Model;
			_skeletonModel.OnVisibilityChanged += UpdateVisibilityAll;
			UpdateModelMaterials();
		}

		public override void ResetObject()
		{
			base.ResetObject();
			if (_skeletonModel != null)
			{
				_skeletonModel.OnVisibilityChanged -= UpdateVisibilityAll;
			}
			base.CastRole.CurIdentity.OnStatusChanged -= OnIdentityChanged;
			TrySetDisguiseModel(RoleTypeId.None, Scp3114MaterialType.Original);
			_lastDisguiseModel = null;
			_animProgress = 0f;
			_trackBones = false;
			_lastActiveStatus = Scp3114Identity.DisguiseStatus.None;
			_lastMaterialType = Scp3114MaterialType.Original;
		}

		private void UpdateModelMaterials()
		{
			CharacterModel characterModelInstance = base.CastRole.FpcModule.CharacterModelInstance;
			float progress = AnimProgress;
			switch (_lastMaterialType)
			{
			case Scp3114MaterialType.Reveal:
				characterModelInstance.Fade = _revealAnimation.FadeOverProgress.Evaluate(progress);
				break;
			case Scp3114MaterialType.Original:
			case Scp3114MaterialType.Disguise:
				if (TeammatePerspective)
				{
					progress *= _teammateProgressMultiplier;
				}
				characterModelInstance.Fade = _disguiseAnimation.FadeOverProgress.Evaluate(progress);
				break;
			}
			_materialsInUse.ForEach((Material x) =>
			{
				x.SetFloat(ProgressHash, progress);
			});
		}

		private void OnIdentityChanged()
		{
			Scp3114Identity.StolenIdentity curIdentity = base.CastRole.CurIdentity;
			switch (curIdentity.Status)
			{
			case Scp3114Identity.DisguiseStatus.Active:
				TrySetDisguiseModel(curIdentity.StolenRole, Scp3114MaterialType.Original);
				AnimProgress = 1f;
				_trackBones = TeammatePerspective;
				_lastActiveStatus = Scp3114Identity.DisguiseStatus.Active;
				break;
			case Scp3114Identity.DisguiseStatus.Equipping:
				TrySetDisguiseModel(curIdentity.StolenRole, Scp3114MaterialType.Disguise);
				AnimProgress = 0f;
				_trackBones = true;
				_lastActiveStatus = Scp3114Identity.DisguiseStatus.Equipping;
				break;
			case Scp3114Identity.DisguiseStatus.None:
				if (_lastActiveStatus == Scp3114Identity.DisguiseStatus.Active)
				{
					TrySetDisguiseModel(curIdentity.StolenRole, Scp3114MaterialType.Reveal);
					_trackBones = true;
					AnimProgress = 0f;
				}
				break;
			}
			_wasTeammatePerpsective = TeammatePerspective;
		}

		private void UpdatePerspective()
		{
			if (TeammatePerspective != _wasTeammatePerpsective)
			{
				float animProgress = AnimProgress;
				OnIdentityChanged();
				if (animProgress == AnimProgress)
				{
					UpdateModelMaterials();
				}
				else
				{
					AnimProgress = animProgress;
				}
				_wasTeammatePerpsective = TeammatePerspective;
			}
		}

		private void UpdateVisibilityAll()
		{
			_disguiseModelInstances.ForEachValue((AnimatedCharacterModel x) =>
			{
				x.SetVisibility(_skeletonModel.IsVisible);
			});
		}

		protected override void LateUpdate()
		{
			base.LateUpdate();
			if (_trackBones)
			{
				_trackBones &= TryTrackBones();
			}
			UpdatePerspective();
			switch (base.CastRole.CurIdentity.Status)
			{
			case Scp3114Identity.DisguiseStatus.Equipping:
				AnimProgress += Time.deltaTime * _disguiseAnimation.ProgressSpeed;
				break;
			case Scp3114Identity.DisguiseStatus.None:
				if (_lastActiveStatus == Scp3114Identity.DisguiseStatus.Active && AnimProgress < 1f)
				{
					AnimProgress += Time.deltaTime * _revealAnimation.ProgressSpeed;
					if (AnimProgress == 1f)
					{
						TrySetDisguiseModel(RoleTypeId.None, Scp3114MaterialType.Original);
					}
				}
				else if (_lastActiveStatus == Scp3114Identity.DisguiseStatus.Equipping && AnimProgress > 0f)
				{
					AnimProgress -= Time.deltaTime * _disguiseAnimation.ProgressSpeed;
					if (AnimProgress == 0f)
					{
						TrySetDisguiseModel(RoleTypeId.None, Scp3114MaterialType.Original);
					}
				}
				break;
			}
		}

		private bool TryTrackBones()
		{
			if (_lastDisguiseModel == null || !_lastDisguiseModel.gameObject.activeSelf)
			{
				return false;
			}
			if (!_mappedBones.TryGetValue(_lastDisguiseModel, out var value))
			{
				return false;
			}
			bool flag = base.CastRole.CurIdentity.Status == Scp3114Identity.DisguiseStatus.Equipping;
			float t = (flag ? _boneTrackingOverDisguiseProgress.Evaluate(AnimProgress) : 1f);
			foreach (MappedBone item in value)
			{
				item.Original.GetPositionAndRotation(out var position, out var rotation);
				if (flag)
				{
					item.Tracked.GetPositionAndRotation(out var position2, out var rotation2);
					item.Tracked.SetPositionAndRotation(Vector3.Lerp(position2, position, t), Quaternion.Lerp(rotation2, rotation, t));
				}
				else
				{
					item.Tracked.SetPositionAndRotation(position, rotation);
				}
			}
			if (_lastDisguiseModel.TryGetSubcontroller<SecondaryRigsSubcontroller>(out var subcontroller))
			{
				subcontroller.MatchAll();
			}
			return true;
		}

		private bool TrySetDisguiseModel(RoleTypeId role, Scp3114MaterialType variant)
		{
			if (!role.TryGetRoleTemplate<HumanRole>(out var result))
			{
				DisableDisguiseModel();
				return false;
			}
			GameObject characterModelTemplate = result.FpcModule.CharacterModelTemplate;
			if (!_disguiseModelInstances.TryGetValue(characterModelTemplate, out var value))
			{
				if (!TryCreateDisguiseModel(characterModelTemplate, out value))
				{
					return false;
				}
				_disguiseModelInstances.Add(characterModelTemplate, value);
			}
			else if (_lastDisguiseModel != value)
			{
				DisableDisguiseModel();
			}
			_lastDisguiseModel = value;
			if (value.Pooled)
			{
				characterModelTemplate.transform.GetPositionAndRotation(out var position, out var rotation);
				value.gameObject.SetActive(value: true);
				value.SetupPoolObject();
				value.RestoreOriginalMaterials();
				value.Setup(base.Owner, base.CastRole, position, rotation);
			}
			value.SetVisibility(_skeletonModel.IsVisible);
			if (_skeletonModel.IsTracked)
			{
				SharedHandsController.SetRoleGloves(role);
			}
			SetDisguiseModelMaterials(value, variant);
			_lastMaterialType = variant;
			return true;
		}

		private bool TryCreateDisguiseModel(GameObject template, out AnimatedCharacterModel model)
		{
			model = null;
			if (!PoolManager.Singleton.TryGetPoolObject(template, base.transform, out var poolObject))
			{
				return false;
			}
			if (!(poolObject is AnimatedCharacterModel animatedCharacterModel))
			{
				return false;
			}
			model = animatedCharacterModel;
			Transform transform = template.transform;
			Transform obj = model.transform;
			transform.GetPositionAndRotation(out var position, out var rotation);
			obj.SetLocalPositionAndRotation(position, rotation);
			obj.localScale = transform.localScale;
			model.SetVisibility(_skeletonModel.IsVisible);
			model.SetOriginalMaterials();
			model.Pooled = true;
			model.DetachedFromPool = true;
			List<MappedBone> orAddNew = _mappedBones.GetOrAddNew(model);
			Scp3114Model.HumanoidBone[] humanoidBones = _skeletonModel.HumanoidBones;
			for (int i = 0; i < humanoidBones.Length; i++)
			{
				Scp3114Model.HumanoidBone humanoidBone = humanoidBones[i];
				Transform boneTransform = model.Animator.GetBoneTransform(humanoidBone.BoneType);
				if (!(boneTransform == null))
				{
					orAddNew.Add(new MappedBone
					{
						Original = humanoidBone.Transform,
						Tracked = boneTransform
					});
				}
			}
			return true;
		}

		private void SetDisguiseModelMaterials(AnimatedCharacterModel model, Scp3114MaterialType matType)
		{
			model.RestoreOriginalMaterials();
			_materialsInUse.Clear();
			if (matType == Scp3114MaterialType.Original)
			{
				if (!TeammatePerspective)
				{
					return;
				}
				matType = Scp3114MaterialType.Disguise;
			}
			model.ReplaceOriginalMaterials((Material original) =>
			{
				Material template = Scp3114MaterialTemplates.GetVariantTemplate(original, matType);
				Material orAdd = _materialInstances.GetOrAdd(template, () => new Material(template));
				_materialsInUse.Add(orAdd);
				return orAdd;
			});
		}

		private void DisableDisguiseModel()
		{
			if (!(_lastDisguiseModel == null))
			{
				_lastDisguiseModel.ResetPoolObject();
				_lastDisguiseModel.Pooled = true;
				_lastDisguiseModel.gameObject.SetActive(value: false);
				_lastDisguiseModel = null;
			}
		}
	}
}
