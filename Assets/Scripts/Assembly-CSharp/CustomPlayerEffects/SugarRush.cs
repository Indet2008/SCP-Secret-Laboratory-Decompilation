using MapGeneration.Holidays;
using Mirror;
using PlayerRoles.FirstPersonControl;
using PlayerStatsSystem;
using UnityEngine;

namespace CustomPlayerEffects
{
	public class SugarRush : StatusEffectBase, IStaminaModifier, IMovementSpeedModifier, IMovementInputOverride, ISoundtrackMutingEffect, IHolidayEffect
	{
		private const float InstantStamina = 100f;

		[SerializeField]
		private AudioSource _backgroundMusic;

		[SerializeField]
		private float _volumeAdjustRate;

		[SerializeField]
		private float _pitchAdjustRate;

		private bool _continueUpdateSource;

		public override EffectClassification Classification => EffectClassification.Positive;

		public bool MuteSoundtrack => base.IsEnabled;

		public bool StaminaModifierActive => base.IsEnabled;

		public float StaminaUsageMultiplier => 0f;

		public float StaminaRegenMultiplier => 1f;

		public bool SprintingDisabled => false;

		public bool ForceSprinting => true;

		public bool MovementModifierActive => base.IsEnabled;

		public float MovementSpeedMultiplier => 1.5f;

		public float MovementSpeedLimit => float.MaxValue;

		public bool MovementOverrideActive => base.IsEnabled;

		public Vector3 MovementOverrideDirection => base.Hub.transform.forward;

		public HolidayType[] TargetHolidays { get; } = new HolidayType[1] { HolidayType.Halloween };

		private void UpdateSource()
		{
			_backgroundMusic.mute = !base.IsSpectated && !base.IsLocalPlayer;
			if (base.IsEnabled)
			{
				AdjustSource(1f);
				return;
			}
			if (_backgroundMusic.volume > 0f)
			{
				AdjustSource(0f);
				return;
			}
			_backgroundMusic.pitch = 1f;
			_continueUpdateSource = false;
		}

		private void AdjustSource(float target)
		{
			_backgroundMusic.volume = Mathf.MoveTowards(_backgroundMusic.volume, target, Time.deltaTime * _volumeAdjustRate);
			_backgroundMusic.pitch = Mathf.MoveTowards(_backgroundMusic.pitch, target, Time.deltaTime * _pitchAdjustRate);
		}

		protected override void Enabled()
		{
			base.Enabled();
			_continueUpdateSource = true;
			_backgroundMusic.Play();
			UpdateSource();
			if (NetworkServer.active && base.Hub.playerStats.TryGetModule<StaminaStat>(out var module))
			{
				module.AddAmount(100f);
			}
		}

		protected override void Update()
		{
			base.Update();
			if (_continueUpdateSource)
			{
				UpdateSource();
			}
		}
	}
}
