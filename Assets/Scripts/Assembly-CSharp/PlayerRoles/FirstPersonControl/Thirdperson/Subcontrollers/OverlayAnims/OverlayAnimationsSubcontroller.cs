using System;
using GameObjectPools;
using InventorySystem.Items.Thirdperson;
using Mirror;
using UnityEngine;

namespace PlayerRoles.FirstPersonControl.Thirdperson.Subcontrollers.OverlayAnims
{
	public class OverlayAnimationsSubcontroller : SubcontrollerBehaviour, IPoolResettable
	{
		private const float RegularAdjustSpeed = 6.5f;

		private const float DisableOldAdjustSpeed = 11.5f;

		private readonly OverlayAnimationsBase[] _overlayAnimations = new OverlayAnimationsBase[2]
		{
			new FlashedAnimation(),
			new SearchCompleteAnimation()
		};

		private OverlayAnimationsBase _lastActive;

		private InventorySubcontroller _inventory;

		private float _leftIkScale;

		private float _rightIkScale;

		[SerializeField]
		private ItemLayerLink[] _layers;

		[SerializeField]
		private AnimationClip _animationToReplace;

		public AnimationClip SearchCompleteClip;

		public AnimationClip FlashedLoopClip;

		public override void OnReassigned()
		{
			base.OnReassigned();
			OverlayAnimationsBase[] overlayAnimations = _overlayAnimations;
			for (int i = 0; i < overlayAnimations.Length; i++)
			{
				overlayAnimations[i].OnReassigned();
			}
		}

		public void ResetObject()
		{
			_lastActive?.OnStopped();
			_lastActive = null;
			OverlayAnimationsBase[] overlayAnimations = _overlayAnimations;
			for (int i = 0; i < overlayAnimations.Length; i++)
			{
				overlayAnimations[i].OnReset();
			}
		}

		public override void Init(AnimatedCharacterModel model, int index)
		{
			base.Init(model, index);
			if (!model.TryGetSubcontroller<InventorySubcontroller>(out _inventory))
			{
				throw new InvalidOperationException("Unable to setup OverlayAnimationsSubcontroller - missing dependency: InventorySubcontroller.");
			}
			_inventory.OnHeldItemUpdated += UpdateAll;
			for (int i = 0; i < _overlayAnimations.Length; i++)
			{
				_overlayAnimations[i].Init(this, i);
			}
		}

		public override void ProcessRpc(NetworkReader reader)
		{
			base.ProcessRpc(reader);
			int index = reader.ReadByte();
			if (_overlayAnimations.TryGet(index, out var element))
			{
				element.ProcessRpc(reader);
			}
		}

		private void OnAnimatorIK(int layerIndex)
		{
			ScaleIk(AvatarIKGoal.LeftHand, _leftIkScale);
			ScaleIk(AvatarIKGoal.RightHand, _rightIkScale);
		}

		private void UpdateAll()
		{
			OverlayAnimationsBase overlayAnimationsBase = null;
			OverlayAnimationsBase[] overlayAnimations = _overlayAnimations;
			foreach (OverlayAnimationsBase overlayAnimationsBase2 in overlayAnimations)
			{
				if (overlayAnimationsBase2.WantsToPlay)
				{
					if (!overlayAnimationsBase2.Bypassable)
					{
						overlayAnimationsBase = overlayAnimationsBase2;
						break;
					}
					if (overlayAnimationsBase == null)
					{
						overlayAnimationsBase = overlayAnimationsBase2;
					}
				}
			}
			if (overlayAnimationsBase == _lastActive)
			{
				UpdateActive();
			}
			else
			{
				UpdateSwitch(overlayAnimationsBase);
			}
			if (_lastActive != null)
			{
				base.Model.AnimatorOverride[_animationToReplace] = _lastActive.Clip;
			}
		}

		private void UpdateSwitch(OverlayAnimationsBase newMatch)
		{
			bool flag = false;
			float speedMultiplier = ((newMatch == null) ? 6.5f : 11.5f);
			ItemLayerLink[] layers = _layers;
			foreach (ItemLayerLink layer in layers)
			{
				if (AdjustLayerWeight(layer, 0f, speedMultiplier) > 0f)
				{
					flag = true;
				}
			}
			if (!flag)
			{
				OverlayAnimationsBase lastActive = _lastActive;
				_lastActive = newMatch;
				lastActive?.OnStopped();
				newMatch?.OnStarted();
				if (lastActive != null)
				{
					UpdateActive();
				}
			}
		}

		private void UpdateActive()
		{
			_lastActive?.UpdateActive();
			ItemLayerLink[] layers = _layers;
			foreach (ItemLayerLink itemLayerLink in layers)
			{
				float num = Mathf.Clamp01(_lastActive?.GetLayerWeight(itemLayerLink.Layer3p) ?? 0f);
				if (num > 0f && _inventory.TryGetCurrentInstance(out var instance))
				{
					ThirdpersonLayerWeight weightForLayer = instance.GetWeightForLayer(itemLayerLink.Layer3p);
					if (!weightForLayer.AllowOther)
					{
						num -= weightForLayer.Weight;
					}
				}
				AdjustLayerWeight(itemLayerLink, num, 6.5f);
			}
		}

		private float AdjustLayerWeight(ItemLayerLink layer, float target, float speedMultiplier)
		{
			int layerIndex = layer.GetLayerIndex(base.Model);
			float num = Mathf.MoveTowards(base.Animator.GetLayerWeight(layerIndex), target, speedMultiplier * Time.deltaTime);
			base.Animator.SetLayerWeight(layerIndex, num);
			switch (layer.Layer3p)
			{
			case AnimItemLayer3p.Left:
				_leftIkScale = Mathf.Clamp01(1f - num);
				break;
			case AnimItemLayer3p.Right:
				_rightIkScale = Mathf.Clamp01(1f - num);
				break;
			}
			return num;
		}

		private void ScaleIk(AvatarIKGoal goal, float multiplier)
		{
			if (!(multiplier >= 1f))
			{
				if (multiplier <= 0f)
				{
					base.Animator.SetIKPositionWeight(goal, 0f);
					base.Animator.SetIKRotationWeight(goal, 0f);
				}
				else
				{
					base.Animator.SetIKPositionWeight(goal, multiplier * base.Animator.GetIKPositionWeight(goal));
					base.Animator.SetIKRotationWeight(goal, multiplier * base.Animator.GetIKRotationWeight(goal));
				}
			}
		}
	}
}
