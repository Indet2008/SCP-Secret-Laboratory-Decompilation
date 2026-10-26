using PlayerStatsSystem;
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

		public bool TryPreventHitmarker(AttackerDamageHandler attacker)
		{
			return true;
		}
	}
}
