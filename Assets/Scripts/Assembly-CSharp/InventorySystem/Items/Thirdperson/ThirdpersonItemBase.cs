using GameObjectPools;
using PlayerRoles.FirstPersonControl.Thirdperson;
using PlayerRoles.FirstPersonControl.Thirdperson.Subcontrollers;
using UnityEngine;

namespace InventorySystem.Items.Thirdperson
{
	public abstract class ThirdpersonItemBase : PoolObject, IPoolResettable, IIdentifierProvider
	{
		private static readonly int HashOverrideBlend = Animator.StringToHash("ItemOverrideBlend");

		private static readonly int HashTriggerOverrideInstant = Animator.StringToHash("ItemOverrideTriggerInstant");

		private static readonly int HashTriggerOverrideSoft = Animator.StringToHash("ItemOverrideTriggerSoft");

		private static readonly int HashAdditiveBlend = Animator.StringToHash("ItemAdditiveBlend");

		private static readonly int HashTriggerAdditiveInstant = Animator.StringToHash("ItemAdditiveTriggerInstant");

		private static readonly int HashTriggerAdditiveSoft = Animator.StringToHash("ItemAdditiveTriggerSoft");

		private Transform _tr;

		protected float OverrideBlend
		{
			get
			{
				return Animator.GetFloat(HashOverrideBlend);
			}
			set
			{
				Animator.SetFloat(HashOverrideBlend, value);
			}
		}

		protected float AdditiveBlend
		{
			get
			{
				return Animator.GetFloat(HashAdditiveBlend);
			}
			set
			{
				Animator.SetFloat(HashAdditiveBlend, value);
			}
		}

		public ItemIdentifier ItemId { get; private set; }

		public AnimatedCharacterModel TargetModel { get; private set; }

		public InventorySubcontroller TargetSubcontroller { get; private set; }

		public Animator Animator => TargetModel.Animator;

		public ReferenceHub OwnerHub => TargetModel.OwnerHub;

		public virtual void ResetObject()
		{
		}

		public virtual float GetTransitionTime(ItemIdentifier iid)
		{
			return 0.5f;
		}

		public abstract ThirdpersonLayerWeight GetWeightForLayer(AnimItemLayer3p layer);

		internal virtual void OnFadeChanged(float newFade)
		{
			_tr.localScale = Vector3.one * newFade;
		}

		internal virtual void OnAnimIK(int layerIndex, float ikScale)
		{
		}

		internal virtual void Initialize(InventorySubcontroller subcontroller, ItemIdentifier id)
		{
			ItemId = id;
			TargetModel = subcontroller.Model;
			TargetSubcontroller = subcontroller;
			_tr = base.transform;
			_tr.parent = subcontroller.ItemSpawnpoint;
			_tr.ResetTransform();
			OverrideBlend = 0f;
			AdditiveBlend = 0f;
			OnFadeChanged(subcontroller.Model.Fade);
		}

		protected void SetAnim(AnimState3p anim, AnimationClip clip)
		{
			ThirdpersonItemAnimationManager.SetAnimation(TargetModel, anim, clip);
		}

		protected void SetAnim(AnimOverrideState3pPair pair)
		{
			ThirdpersonItemAnimationManager.SetAnimation(TargetModel, pair);
		}

		protected void ReplayOverrideBlend(bool soft)
		{
			Animator.SetTrigger(soft ? HashTriggerOverrideSoft : HashTriggerOverrideInstant);
		}

		protected void ReplayAdditiveBlend(bool soft)
		{
			Animator.SetTrigger(soft ? HashTriggerAdditiveSoft : HashTriggerAdditiveInstant);
		}

		protected virtual void Update()
		{
		}
	}
}
