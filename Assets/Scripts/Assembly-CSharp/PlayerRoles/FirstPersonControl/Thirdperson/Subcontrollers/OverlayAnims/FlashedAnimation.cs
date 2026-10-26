using CustomPlayerEffects;
using InventorySystem.Disarming;
using InventorySystem.Items.Thirdperson;
using UnityEngine;

namespace PlayerRoles.FirstPersonControl.Thirdperson.Subcontrollers.OverlayAnims
{
	public class FlashedAnimation : OverlayAnimationsBase
	{
		private const float DecayDuration = 1.7f;

		private bool _hasEffect;

		private float _remainingSustain;

		private Flashed _effect;

		private bool EffectEnabled
		{
			get
			{
				if (_hasEffect)
				{
					return _effect.IsEnabled;
				}
				return false;
			}
		}

		public override bool WantsToPlay
		{
			get
			{
				if (!(_remainingSustain > 0f))
				{
					return EffectEnabled;
				}
				return true;
			}
		}

		public override bool Bypassable => !EffectEnabled;

		public override AnimationClip Clip => base.Controller.FlashedLoopClip;

		public override float GetLayerWeight(AnimItemLayer3p layer)
		{
			return Mathf.Clamp01(_remainingSustain / 1.7f);
		}

		public override void UpdateActive()
		{
			base.UpdateActive();
			if (base.Model.OwnerHub.inventory.IsDisarmed())
			{
				_remainingSustain = 0f;
			}
			else if (EffectEnabled)
			{
				_remainingSustain = 1.7f;
			}
			else
			{
				_remainingSustain -= Time.deltaTime;
			}
		}

		public override void OnStopped()
		{
			base.OnStopped();
			_remainingSustain = 0f;
		}

		public override void OnReassigned()
		{
			base.OnReassigned();
			_hasEffect = base.Model.OwnerHub.playerEffectsController.TryGetEffect<Flashed>(out _effect);
		}

		public override void OnReset()
		{
			base.OnReset();
			_hasEffect = false;
			_remainingSustain = 0f;
		}
	}
}
