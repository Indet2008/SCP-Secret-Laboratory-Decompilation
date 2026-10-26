using Mirror;
using PlayerStatsSystem;
using UnityEngine;

namespace CustomPlayerEffects
{
	public class SeveredEyes : TickingEffectBase
	{
		// Client-only serialized fields restored from the v14 client layout (server build stripped them).
		[global::UnityEngine.SerializeField]
		private global::UnityEngine.AudioClip _severClip;

		[global::UnityEngine.SerializeField]
		private global::UnityEngine.AudioClip _severNonDiegeticClip;

		[global::UnityEngine.SerializeField]
		private float _severSoundDistance;

		[global::UnityEngine.SerializeField]
		private global::UnityEngine.GameObject _severedEyesPrefab;


		[SerializeField]
		private float _damagePerTick;

		public override bool AllowEnabling => true;

		protected override void OnTick()
		{
			if (NetworkServer.active)
			{
				base.Hub.playerStats.DealDamage(new UniversalDamageHandler(_damagePerTick, DeathTranslations.Scp1344));
			}
		}
	}
}
