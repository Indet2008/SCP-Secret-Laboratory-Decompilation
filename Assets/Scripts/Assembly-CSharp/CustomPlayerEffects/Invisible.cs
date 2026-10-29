using PlayerStatsSystem;
using PlayerRoles.Spectating;
using RemoteAdmin.Interfaces;

namespace CustomPlayerEffects
{
	public class Invisible : StatusEffectBase, ISpectatorDataPlayerEffect, ICustomDisplayName, IHitmarkerPreventer
	{
		// Client-only serialized fields restored from the v14 client layout (server build stripped them).
		[global::UnityEngine.SerializeField]
		private global::UnityEngine.AudioClip _sfxEnable;

		[global::UnityEngine.SerializeField]
		private global::UnityEngine.AudioClip _sfxDisable;


		public override EffectClassification Classification => EffectClassification.Positive;

		public string DisplayName => "Invisibility";

		public bool CanBeDisplayed => true;

		public bool GetSpectatorText(out string s)
		{
			s = "SCP-268";
			return true;
		}

		protected override void Enabled()
		{
			PlaySound(isEnabled: true);
		}

		protected override void Disabled()
		{
			PlaySound(isEnabled: false);
		}

		private void PlaySound(bool isEnabled)
		{
			if (base.Hub.isLocalPlayer || base.Hub.IsLocallySpectated())
			{
				global::AudioPooling.AudioSourcePoolManager.Play2D(isEnabled ? _sfxEnable : _sfxDisable, 1f, global::AudioPooling.MixerChannel.NoDucking);
			}
		}

		public bool TryPreventHitmarker(AttackerDamageHandler attacker)
		{
			return true;
		}
	}
}
