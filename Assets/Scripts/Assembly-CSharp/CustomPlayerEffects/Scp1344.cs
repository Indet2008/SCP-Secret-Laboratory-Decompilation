using AudioPooling;
using InventorySystem.Items.Usables.Scp1344;
using Mirror;
using PlayerRoles.FirstPersonControl.Thirdperson.Subcontrollers.Wearables;
using PlayerRoles.Visibility;
using RemoteAdmin.Interfaces;
using UnityEngine;

namespace CustomPlayerEffects
{
	public class Scp1344 : StatusEffectBase, ICustomDisplayName
	{
		public const InvisibilityFlags BypassFlags = (InvisibilityFlags)3u;

		[SerializeField]
		private AudioClip _sfxEnable;

		[SerializeField]
		private AudioClip _sfxEnableNonDiegetic;

		[SerializeField]
		private AudioClip _sfxBuildupDiegetic;

		[SerializeField]
		private Scp1344XrayProviderBase[] _xrayProviders;

		private AudioPoolSession _enableSoundSession;

		private bool _prevVisionActive;

		public override EffectClassification Classification => EffectClassification.Mixed;

		public string DisplayName => "SCP-1344";

		public bool CanBeDisplayed => true;

		protected override void Start()
		{
			DisableEffect();
		}

		protected override void Awake()
		{
			base.Awake();
			Scp1344XrayProviderBase[] xrayProviders = _xrayProviders;
			for (int i = 0; i < xrayProviders.Length; i++)
			{
				xrayProviders[i].OnInit(this);
			}
		}

		protected override void Enabled()
		{
			if (NetworkServer.active)
			{
				base.Hub.EnableWearables(WearableElements.Scp1344Goggles);
			}
			PlaySound();
		}

		protected override void Disabled()
		{
			if (NetworkServer.active)
			{
				base.Hub.DisableWearables(WearableElements.Scp1344Goggles);
			}
			UpdateVision(isVisionActive: false);
		}

		protected override void OnEffectUpdate()
		{
			base.OnEffectUpdate();
			UpdateVision(base.IsPOV || NetworkServer.active);
		}

		public override void OnStopSpectating()
		{
			base.OnStopSpectating();
			CloseSoundSessions();
			UpdateVision(isVisionActive: false);
		}

		public void PlayBuildupSound()
		{
			AudioSourcePoolManager.PlayOnTransform(_sfxBuildupDiegetic, base.Hub.transform);
		}

		private void CloseSoundSessions()
		{
			if (_enableSoundSession.SameSession)
			{
				_enableSoundSession.Source.Stop();
			}
		}

		private void PlaySound()
		{
			AudioSourcePoolManager.PlayOnTransform(_sfxEnable, base.Hub.transform);
			if (base.IsLocalPlayer || base.IsSpectated)
			{
				_enableSoundSession = new AudioPoolSession(AudioSourcePoolManager.Play2D(_sfxEnableNonDiegetic, 1f, MixerChannel.NoDucking));
			}
		}

		private void UpdateVision(bool isVisionActive)
		{
			if (isVisionActive != _prevVisionActive)
			{
				if (isVisionActive)
				{
					_xrayProviders.ForEach((Scp1344XrayProviderBase x) =>
					{
						x.OnVisionEnabled();
					});
				}
				else
				{
					_xrayProviders.ForEach((Scp1344XrayProviderBase x) =>
					{
						x.OnVisionDisabled();
					});
				}
				_prevVisionActive = isVisionActive;
			}
			if (isVisionActive)
			{
				_xrayProviders.ForEach((Scp1344XrayProviderBase x) =>
				{
					x.OnUpdate();
				});
			}
		}
	}
}
