using AudioPooling;
using Footprinting;
using Mirror;
using PlayerRoles.FirstPersonControl;
using PlayerRoles.Spectating;
using PlayerStatsSystem;
using UnityEngine;

namespace CustomPlayerEffects
{
	public class CardiacArrest : ParentEffectBase<SubEffectBase>, IHealableEffect, IStaminaModifier
	{
		private const float SprintStaminaUsage = 3f;

		private const float DamagePerTick = 8f;

		private Footprint _attacker;

		[SerializeField]
		private AudioClip _dyingSoundEffect;

		[Tooltip("Used to track intervals/timers/etc without every effect needing to redefine a unique float.")]
		public float TimeBetweenTicks;

		private float _timeTillTick;

		private AudioPoolSession _dyingSoundSession;

		public bool StaminaModifierActive => base.IsEnabled;

		public float StaminaUsageMultiplier => 3f;

		public float StaminaRegenMultiplier => 1f;

		public bool SprintingDisabled => false;

		public override bool AllowEnabling => !SpawnProtected.CheckPlayer(base.Hub);

		protected override void Enabled()
		{
			base.Enabled();
			if (base.Hub.isLocalPlayer || base.Hub.IsLocallySpectated())
			{
				_dyingSoundSession = new AudioPoolSession(AudioSourcePoolManager.Play2D(_dyingSoundEffect));
			}
			if (NetworkServer.active)
			{
				_timeTillTick = 0f;
			}
		}

		protected override void Disabled()
		{
			base.Disabled();
			_attacker = default;
		}

		public void SetAttacker(ReferenceHub ply)
		{
			_attacker = new Footprint(ply);
		}

		public bool IsHealable(ItemType it)
		{
			if (it != ItemType.SCP500)
			{
				return it == ItemType.Adrenaline;
			}
			return true;
		}

		protected override void OnEffectUpdate()
		{
			if (NetworkServer.active)
			{
				ServerUpdate();
			}
			UpdateSubEffects();
		}

		public override void OnStopSpectating()
		{
			base.OnStopSpectating();
			if (_dyingSoundSession.SameSession)
			{
				_dyingSoundSession.Source.Stop();
			}
		}

		private void ServerUpdate()
		{
			_timeTillTick -= Time.deltaTime;
			if (!(_timeTillTick > 0f))
			{
				_timeTillTick += TimeBetweenTicks;
				base.Hub.playerStats.DealDamage(new Scp049DamageHandler(_attacker, 8f, Scp049DamageHandler.AttackType.CardiacArrest));
			}
		}
	}
}
