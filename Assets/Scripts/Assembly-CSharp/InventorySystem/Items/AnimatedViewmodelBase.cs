using System;
using InventorySystem.Items.Firearms.Modules.Misc;
using InventorySystem.Items.SwayControllers;
using UnityEngine;

namespace InventorySystem.Items
{
	public abstract class AnimatedViewmodelBase : ItemViewmodelBase
	{
		[SerializeField]
		private Animator _animator;

		public bool DisableSharedHands;

		private const float MaxSkipEquipTime = 7.5f;

		public Avatar AnimatorAvatar => _animator.avatar;

		public RuntimeAnimatorController AnimatorRuntimeController => _animator.runtimeAnimatorController;

		public Transform AnimatorTransform => _animator.transform;

		public bool IsFastForwarding { get; private set; }

		public abstract IItemSwayController SwayController { get; }

		protected float SkipEquipTime => Mathf.Min(7.5f, base.Hub.inventory.LastItemSwitch);

		public static event Action OnSwayUpdated;

		protected virtual void LateUpdate()
		{
			SwayController?.UpdateSway();
			OnSwayUpdated?.Invoke();
		}

		public override void InitAny()
		{
			base.InitAny();
			_animator.cullingMode = AnimatorCullingMode.AlwaysAnimate;
			AnimatorForceUpdate();
		}

		public virtual AnimatorStateInfo AnimatorStateInfo(int layer)
		{
			return _animator.GetCurrentAnimatorStateInfo(layer);
		}

		public virtual bool AnimatorInTransition(int layer)
		{
			return _animator.IsInTransition(layer);
		}

		public virtual void AnimatorForceUpdate()
		{
			AnimatorForceUpdate(Time.deltaTime);
		}

		public virtual void AnimatorForceUpdate(float deltaTime, bool fastMode = true)
		{
			if (fastMode)
			{
				IsFastForwarding = true;
				_animator.Update(deltaTime);
				SharedHandsController.Singleton.Hands.Update(deltaTime);
				IsFastForwarding = false;
			}
			else
			{
				while (deltaTime > 0f)
				{
					AnimatorForceUpdate(Mathf.Min(deltaTime, 0.07f));
					deltaTime -= 0.07f;
				}
			}
		}

		public virtual void AnimatorSetBool(int hash, bool val)
		{
			_animator.SetBool(hash, val);
			SharedHandsController.Singleton.Hands.SetBool(hash, val);
		}

		public virtual void AnimatorSetFloat(int hash, float val)
		{
			_animator.SetFloat(hash, val);
			SharedHandsController.Singleton.Hands.SetFloat(hash, val);
		}

		public virtual void AnimatorSetInt(int hash, int val)
		{
			_animator.SetInteger(hash, val);
			SharedHandsController.Singleton.Hands.SetInteger(hash, val);
		}

		public virtual void AnimatorSetTrigger(int hash)
		{
			_animator.SetTrigger(hash);
			SharedHandsController.Singleton.Hands.SetTrigger(hash);
		}

		public virtual void AnimatorSetLayerWeight(int layer, float val)
		{
			_animator.SetLayerWeight(layer, val);
			SharedHandsController.Singleton.Hands.SetLayerWeight(layer, val);
		}

		public virtual void AnimatorSetLayerWeight(AnimatorLayerMask mask, float val)
		{
			int[] layers = mask.Layers;
			foreach (int layer in layers)
			{
				AnimatorSetLayerWeight(layer, val);
			}
		}

		public virtual float AnimatorGetLayerWeight(int layer)
		{
			return _animator.GetLayerWeight(layer);
		}

		public virtual string AnimatorGetLayerName(int layer)
		{
			return _animator.GetLayerName(layer);
		}

		public virtual void AnimatorPlay(int hash, int layer, float time)
		{
			_animator.Play(hash, layer, time);
			SharedHandsController.Singleton.Hands.Play(hash, layer, time);
		}

		public int AnimatorGetLayerCount()
		{
			return _animator.layerCount;
		}

		public void AnimatorRebind()
		{
			_animator.Rebind();
			SharedHandsController.Singleton.Hands.Rebind();
		}
	}
}
