using CustomRendering;
using Mirror;
using PlayerRoles.Spectating;
using UnityEngine;
using UnityEngine.Rendering;
using UserSettings;
using UserSettings.VideoSettings;

namespace CustomPlayerEffects
{
	public class Flashed : StatusEffectBase
	{
		private Volume _processVolume;

		private Lighten _lightenEffect;

		private Darken _darkenEffect;

		private float _remainingWeight;

		public override bool AllowEnabling => !SpawnProtected.CheckPlayer(base.Hub);

		public float Weight
		{
			get
			{
				return _remainingWeight;
			}
			set
			{
				_remainingWeight = Mathf.Clamp01(value);
				if (base.Hub.isLocalPlayer || base.Hub.IsLocallySpectated())
				{
					_processVolume.weight = _remainingWeight;
				}
			}
		}

		protected override void Awake()
		{
			base.Awake();
			_processVolume = GetComponent<Volume>();
			if (_processVolume != null && _processVolume.profile != null)
			{
				_processVolume.profile.TryGet<Lighten>(out _lightenEffect);
				_processVolume.profile.TryGet<Darken>(out _darkenEffect);
			}
		}

		protected override void Enabled()
		{
			base.Enabled();
			bool flag = UserSetting<bool>.Get(MiscVideoSetting.FlashbangDarkMode);
			if (_lightenEffect != null)
			{
				_lightenEffect.active = !flag;
			}
			if (_darkenEffect != null)
			{
				_darkenEffect.active = flag;
			}
		}

		protected override void IntensityChanged(byte prevState, byte newState)
		{
			float num = (float)(int)newState * 0.1f;
			if (NetworkServer.active)
			{
				base.TimeLeft = num;
			}
			if ((base.Hub.isLocalPlayer || base.Hub.IsLocallySpectated()) && num > 0f)
			{
				_processVolume.enabled = true;
				Weight = 0f;
			}
		}

		protected override void Update()
		{
			base.Update();
			if (NetworkServer.active && base.Duration == 0f)
			{
				base.TimeLeft = 1f;
			}
			if (!base.Hub.isLocalPlayer && !base.Hub.IsLocallySpectated())
			{
				_processVolume.weight = 0f;
			}
			float remainingWeight = _remainingWeight;
			if (base.Intensity > 0)
			{
				Weight = remainingWeight + Time.deltaTime * 2.5f;
			}
			else if (remainingWeight > 0f)
			{
				Weight = remainingWeight - Time.deltaTime * 0.9f;
			}
			else
			{
				_processVolume.enabled = false;
			}
		}
	}
}
