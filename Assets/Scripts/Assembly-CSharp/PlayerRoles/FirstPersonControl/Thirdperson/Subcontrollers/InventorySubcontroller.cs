using System;
using System.Collections.Generic;
using AnimatorLayerManagement;
using GameObjectPools;
using InventorySystem;
using InventorySystem.Disarming;
using InventorySystem.Items;
using InventorySystem.Items.Thirdperson;
using UnityEngine;

namespace PlayerRoles.FirstPersonControl.Thirdperson.Subcontrollers
{
	public class InventorySubcontroller : SubcontrollerBehaviour, IPoolResettable, ILookatModifier, IHandPoseModifier
	{
		[Serializable]
		private struct DefaultAnimatorOverrides
		{
			public AnimationClip Original;

			public AnimationClip Override;
		}

		private enum TransitionStatus
		{
			RetractingPrevious = 0,
			EquippingNew = 1,
			Done = 2
		}

		public static Action<ThirdpersonItemBase> OnSwapThirdpersonItem;

		private const float DefaultTransitionTime = 0.5f;

		private ItemIdentifier _prevItem;

		private Dictionary<AnimationClip, AnimationClip> _dictionarizedDefaultOverrides;

		private float _weightAdjustSpeed;

		private TransitionStatus _transitionStatus;

		private bool _hasThirdpersonInstance;

		private ThirdpersonItemBase _lastThirdpersonInstance;

		private int _regularIdleLayerIndex;

		private int _itemIdleLayerIndex;

		private int? _cuffedOverrideLayerIndex;

		private int _movementOverrideLayerIndex;

		private float _transitionWeight;

		private float _prevCuffWeight;

		[SerializeField]
		private ItemLayerLink[] _itemLayers;

		[SerializeField]
		private DefaultAnimatorOverrides[] _defaultAnimatorOverrides;

		[SerializeField]
		private LayerRefId _regularIdleLayer;

		[SerializeField]
		private LayerRefId _itemIdleLayer;

		[SerializeField]
		private LayerRefId _movementOverrideLayer;

		[SerializeField]
		private LayerRefId _cuffedOverrideLayer;

		[SerializeField]
		private float _cuffedAdjustSpeed;

		public bool PoolHeldItem;

		public Transform ItemSpawnpoint { get; private set; }

		public float TransitionWeight
		{
			get
			{
				return _transitionWeight;
			}
			private set
			{
				_transitionWeight = Mathf.Clamp01(value);
			}
		}

		public event Action OnHeldItemUpdated;

		private void OnAnimatorIK(int layerIndex)
		{
			if (!base.Culled && TryGetCurrentInstance(out var instance))
			{
				instance.OnAnimIK(layerIndex, TransitionWeight);
			}
		}

		private void OnFadeChanged()
		{
			if (TryGetCurrentInstance(out var instance))
			{
				instance.OnFadeChanged(base.Model.Fade);
			}
		}

		private void OnVisibilityChanged()
		{
			if (!TryGetCurrentInstance(out var instance))
			{
				return;
			}
			bool isVisible = base.Model.IsVisible;
			foreach (Renderer renderer in instance.GetComponentsInChildren<Renderer>(includeInactive: true))
			{
				renderer.enabled = isVisible;
			}
		}

		private void ResetThirdpersonItem()
		{
			if (_dictionarizedDefaultOverrides == null)
			{
				_dictionarizedDefaultOverrides = new Dictionary<AnimationClip, AnimationClip>(_defaultAnimatorOverrides.Length);
				DefaultAnimatorOverrides[] defaultAnimatorOverrides = _defaultAnimatorOverrides;
				for (int i = 0; i < defaultAnimatorOverrides.Length; i++)
				{
					DefaultAnimatorOverrides defaultAnimatorOverrides2 = defaultAnimatorOverrides[i];
					_dictionarizedDefaultOverrides.Add(defaultAnimatorOverrides2.Original, defaultAnimatorOverrides2.Override);
				}
			}
			ThirdpersonItemAnimationManager.ResetOverrides(base.Model, _dictionarizedDefaultOverrides);
		}

		private void SwapThirdpersonItem(ItemIdentifier itemId)
		{
			ResetThirdpersonItem();
			if (TryGetCurrentInstance(out var instance))
			{
				instance.ReturnToPool();
				_hasThirdpersonInstance = false;
			}
			_transitionStatus = TransitionStatus.EquippingNew;
			_hasThirdpersonInstance = ThirdpersonItemPoolManager.TryGet(this, itemId, out _lastThirdpersonInstance, PoolHeldItem);
			OnSwapThirdpersonItem?.Invoke(_lastThirdpersonInstance);
		}

		private float GetTransitionTime(ItemIdentifier itemId)
		{
			if (itemId.TypeId.TryGetTemplate<ItemBase>(out var item))
			{
				ThirdpersonItemBase thirdpersonModel = item.ThirdpersonModel;
				if (thirdpersonModel != null)
				{
					return Mathf.Max(thirdpersonModel.GetTransitionTime(itemId), Time.deltaTime);
				}
			}
			return 0.5f;
		}

		private void UpdateLayerWeights()
		{
			float num = Mathf.SmoothStep(0f, 1f, TransitionWeight);
			float num2 = (_hasThirdpersonInstance ? num : 0f);
			float walkLayerWeight = base.Model.WalkLayerWeight;
			ItemLayerLink[] itemLayers = _itemLayers;
			foreach (ItemLayerLink itemLayerLink in itemLayers)
			{
				float num3 = num;
				if (TryGetCurrentInstance(out var instance))
				{
					num3 *= instance.GetWeightForLayer(itemLayerLink.Layer3p).Weight;
				}
				int layerIndex = itemLayerLink.GetLayerIndex(base.Model);
				base.Animator.SetLayerWeight(layerIndex, num3);
			}
			base.Animator.SetLayerWeight(_movementOverrideLayerIndex, walkLayerWeight * num2);
			base.Animator.SetLayerWeight(_itemIdleLayerIndex, num2);
			base.Animator.SetLayerWeight(_regularIdleLayerIndex, 1f - num2);
		}

		private void UpdateCuffWeight()
		{
			if (_cuffedOverrideLayerIndex.HasValue)
			{
				float target = (base.OwnerHub.inventory.IsDisarmed() ? 1 : 0);
				float maxDelta = Time.deltaTime * _cuffedAdjustSpeed;
				float num = Mathf.MoveTowards(_prevCuffWeight, target, maxDelta);
				if (num != _prevCuffWeight)
				{
					base.Animator.SetLayerWeight(_cuffedOverrideLayerIndex.Value, num);
					_prevCuffWeight = num;
				}
			}
		}

		public override void Init(AnimatedCharacterModel model, int index)
		{
			base.Init(model, index);
			Transform boneTransform = model.Animator.GetBoneTransform(HumanBodyBones.RightHand);
			ItemSpawnpoint = new GameObject().transform;
			ItemSpawnpoint.SetParent(boneTransform, worldPositionStays: true);
			ItemSpawnpoint.ResetLocalPose();
			_weightAdjustSpeed = 1f;
			model.OnFadeChanged += OnFadeChanged;
			model.OnVisibilityChanged += OnVisibilityChanged;
			CacheLayerIndexes();
		}

		private void CacheLayerIndexes()
		{
			AnimatorLayerManager layerManager = base.Model.LayerManager;
			_itemIdleLayerIndex = layerManager.GetLayerIndex(_itemIdleLayer);
			_regularIdleLayerIndex = layerManager.GetLayerIndex(_regularIdleLayer);
			_movementOverrideLayerIndex = layerManager.GetLayerIndex(_movementOverrideLayer);
			_cuffedOverrideLayerIndex = ((_cuffedAdjustSpeed > 0f) ? new int?(layerManager.GetLayerIndex(_cuffedOverrideLayer)) : ((int?)null));
		}

		private void Update()
		{
			if (!base.Model.Pooled && !base.OwnerHub.isLocalPlayer)
			{
				UpdateHeldItem(base.OwnerHub.inventory.CurItem);
				UpdateCuffWeight();
			}
		}

		public bool TryGetCurrentInstance(out ThirdpersonItemBase instance)
		{
			instance = _lastThirdpersonInstance;
			return _hasThirdpersonInstance;
		}

		public bool TryGetCurrentInstance<T>(out T instance)
		{
			if (TryGetCurrentInstance(out var instance2) && instance2 is T val)
			{
				instance = val;
				return true;
			}
			instance = default;
			return false;
		}

		public void ResetObject()
		{
			_prevItem = ItemIdentifier.None;
			_prevCuffWeight = 0f;
			ResetThirdpersonItem();
			if (TryGetCurrentInstance(out var instance))
			{
				instance.ReturnToPool();
				_hasThirdpersonInstance = false;
			}
		}

		public void UpdateHeldItem(ItemIdentifier itemId, bool instant = false)
		{
			if (_prevItem != itemId)
			{
				_prevItem = itemId;
				_transitionStatus = TransitionStatus.RetractingPrevious;
				_weightAdjustSpeed = 2f / GetTransitionTime(itemId);
				if (instant)
				{
					SwapThirdpersonItem(itemId);
					TransitionWeight = 1f;
					return;
				}
			}
			switch (_transitionStatus)
			{
			case TransitionStatus.RetractingPrevious:
				TransitionWeight -= Time.deltaTime * _weightAdjustSpeed;
				if (TransitionWeight <= 0f)
				{
					SwapThirdpersonItem(itemId);
				}
				break;
			case TransitionStatus.EquippingNew:
				TransitionWeight += Time.deltaTime * _weightAdjustSpeed;
				if (TransitionWeight >= 1f)
				{
					_transitionStatus = TransitionStatus.Done;
				}
				break;
			}
			UpdateLayerWeights();
			OnHeldItemUpdated?.Invoke();
		}

		public LookatData ProcessLookat(LookatData original)
		{
			if (!TryGetCurrentInstance(out ILookatModifier instance))
			{
				return original;
			}
			LookatData target = instance.ProcessLookat(original);
			return original.LerpTo(target, TransitionWeight);
		}

		public HandPoseData ProcessHandPose(HandPoseData original)
		{
			if (!TryGetCurrentInstance(out IHandPoseModifier instance))
			{
				return original;
			}
			HandPoseData target = instance.ProcessHandPose(original);
			return original.LerpTo(target, TransitionWeight);
		}
	}
}
