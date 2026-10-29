using RemoteAdmin.Interfaces;
using UnityEngine;
using UnityEngine.Rendering;
using UnityEngine.Rendering.HighDefinition;

namespace CustomPlayerEffects
{
	public class Blindness : StatusEffectBase, ICustomDisplayName, ICustomHealableEffect, IHealableEffect, IConflictableEffect
	{
		private const float LerpingSpeed = 10f;

		private const byte MaxHealableIntensity = 100;

		private const byte MinIntensity = 15;

		public override EffectClassification Classification => EffectClassification.Negative;

		public override bool AllowEnabling => !SpawnProtected.CheckPlayer(base.Hub);

		public string DisplayName => "Blindness";

		public bool CanBeDisplayed => true;

		// Client-only in the original (stripped from the server build): darkens the screen through the
		// effect volume's colour filter, lerping towards the intensity (100 = fully black).
		private ColorAdjustments _colorAdjustments;

		private float _curBlindness;

		private bool _lerpActive;

		protected override void Awake()
		{
			base.Awake();
			if (TryGetComponent<Volume>(out var volume) && volume.profile != null)
			{
				volume.profile.TryGet<ColorAdjustments>(out _colorAdjustments);
			}
		}

		protected override void Enabled()
		{
			_curBlindness = base.Intensity;
			UpdateOpacity();
		}

		protected override void IntensityChanged(byte prevState, byte newState)
		{
			if (newState <= MaxHealableIntensity)
			{
				_lerpActive = true;
			}
			_curBlindness = newState;
			UpdateOpacity();
		}

		protected override void OnEffectUpdate()
		{
			if (!_lerpActive)
			{
				return;
			}
			if (Mathf.Approximately(base.Intensity, _curBlindness))
			{
				_lerpActive = false;
				return;
			}
			_curBlindness += Time.deltaTime * ((float)(int)base.Intensity - _curBlindness) * LerpingSpeed;
			UpdateOpacity();
		}

		private void UpdateOpacity()
		{
			if (_colorAdjustments == null)
			{
				return;
			}
			float num = Mathf.Clamp01(_curBlindness / 100f);
			_colorAdjustments.colorFilter.value = new Color(1f - num, 1f - num, 1f - num, 1f);
		}

		public bool IsHealable(ItemType item)
		{
			if (item == ItemType.SCP500)
			{
				byte intensity = base.Intensity;
				if (intensity <= 100)
				{
					return intensity > 15;
				}
				return false;
			}
			return false;
		}

		public void OnHeal(ItemType item)
		{
			base.Intensity = 15;
		}

		public bool CheckConflicts(StatusEffectBase other)
		{
			if (!(other is Flashed))
			{
				return false;
			}
			other.ServerDisable();
			return true;
		}
	}
}
