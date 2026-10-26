using CustomPlayerEffects;
using Hazards;
using LabApi.Events.Arguments.Scp173Events;
using LabApi.Events.Handlers;
using Mirror;
using PlayerRoles.PlayableScps.HUDs;
using PlayerRoles.PlayableScps.HumeShield;
using PlayerRoles.Subroutines;
using PlayerStatsSystem;
using RelativePositioning;
using UnityEngine;

namespace PlayerRoles.PlayableScps.Scp173
{
	public class Scp173TantrumAbility : KeySubroutine<Scp173Role>
	{
		private const float StainedKillReward = 400f;

		private const float ReducedStainedKillReward = 100f;

		private const float CooldownTime = 30f;

		private const float RayMaxDistance = 3f;

		private const float TantrumHeight = 1.25f;

		public AbilityHud TantrumAbilityHUD;

		public readonly AbilityCooldown Cooldown = new AbilityCooldown();

		[SerializeField]
		private TantrumEnvironmentalHazard _tantrumPrefab;

		[SerializeField]
		private LayerMask _tantrumMask;

		private Scp173ObserversTracker _observersTracker;

		private Scp173BlinkTimer _blinkTimer;

		[SerializeField]
		private CooldownAudio _cooldownAudio;

		protected override ActionName TargetKey => ActionName.ToggleFlashlight;

		protected override void OnKeyDown()
		{
			base.OnKeyDown();
			if (Cooldown.IsReady)
			{
				ClientSendCmd();
			}
		}

		protected override void Awake()
		{
			base.Awake();
			GetSubroutine<Scp173BlinkTimer>(out _blinkTimer);
			GetSubroutine<Scp173ObserversTracker>(out _observersTracker);
		}

		public override void ServerProcessCmd(NetworkReader reader)
		{
			if (!Cooldown.IsReady || _blinkTimer.RemainingSustainPercent > 0f || _observersTracker.IsObserved || !Physics.Raycast(base.CastRole.FpcModule.Position, Vector3.down, out var hitInfo, 3f, _tantrumMask))
			{
				return;
			}
			Scp173CreatingTantrumEventArgs e = new Scp173CreatingTantrumEventArgs(base.Owner);
			Scp173Events.OnCreatingTantrum(e);
			if (!e.IsAllowed)
			{
				return;
			}
			Cooldown.Trigger(30.0);
			ServerSendRpc(toAll: true);
			TantrumEnvironmentalHazard tantrumEnvironmentalHazard = Object.Instantiate(_tantrumPrefab);
			Vector3 targetPos = hitInfo.point + Vector3.up * 1.25f;
			tantrumEnvironmentalHazard.SynchronizedPosition = new RelativePosition(targetPos);
			foreach (TeslaGate allGate in TeslaGate.AllGates)
			{
				if (allGate.IsInIdleRange(base.Owner))
				{
					allGate.TantrumsToBeDestroyed.Add(tantrumEnvironmentalHazard);
				}
			}
			Scp173Events.OnCreatedTantrum(new Scp173CreatedTantrumEventArgs(tantrumEnvironmentalHazard, base.Owner));
		}

		public override void ServerWriteRpc(NetworkWriter writer)
		{
			Cooldown.WriteCooldown(writer);
		}

		public override void ClientProcessRpc(NetworkReader reader)
		{
			Cooldown.ReadCooldown(reader);
		}

		public override void SpawnObject()
		{
			base.SpawnObject();
			PlayerStats.OnAnyPlayerDied += CheckDeath;
		}

		public override void ResetObject()
		{
			base.ResetObject();
			Cooldown.Clear();
			PlayerStats.OnAnyPlayerDied -= CheckDeath;
		}

		private void CheckDeath(ReferenceHub ply, DamageHandlerBase handler)
		{
			if (NetworkServer.active && handler is ScpDamageHandler scpDamageHandler && !(scpDamageHandler.Attacker.Hub != base.Owner) && ply.playerEffectsController.TryGetEffect<Stained>(out var playerEffect) && playerEffect.IsEnabled)
			{
				HumeShieldModuleBase humeShieldModule = base.CastRole.HumeShieldModule;
				RoleTypeId roleId = ply.GetRoleId();
				if (roleId == RoleTypeId.Flamingo || roleId == RoleTypeId.AlphaFlamingo || roleId == RoleTypeId.NtfFlamingo || roleId == RoleTypeId.ChaosFlamingo)
				{
					humeShieldModule.HsCurrent = Mathf.Min(humeShieldModule.HsMax, humeShieldModule.HsCurrent + 100f);
				}
				else
				{
					humeShieldModule.HsCurrent = Mathf.Min(humeShieldModule.HsMax, humeShieldModule.HsCurrent + 400f);
				}
			}
		}
	}
}
