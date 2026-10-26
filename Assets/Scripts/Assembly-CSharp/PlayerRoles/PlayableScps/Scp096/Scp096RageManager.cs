using LabApi.Events.Arguments.Scp096Events;
using LabApi.Events.Handlers;
using Mirror;
using PlayerRoles.PlayableScps.HumeShield;
using PlayerRoles.Subroutines;
using UnityEngine;

namespace PlayerRoles.PlayableScps.Scp096
{
	public class Scp096RageManager : StandardSubroutine<Scp096Role>, IHumeShieldBlocker
	{
		public const float NormalHumeRegenerationRate = 15f;

		public const float MaxRageTime = 35f;

		public const float MinimumEnrageTime = 20f;

		private const float TimePerExtraTarget = 3f;

		private const float CalmingShieldMultiplier = 1f;

		private const float EnragingShieldMultiplier = 1f;

		public readonly AbilityCooldown HudRageDuration = new AbilityCooldown();

		private DynamicHumeShieldController _shieldController;

		private Scp096TargetsTracker _targetsTracker;

		private float _enragedTimeLeft;

		public bool HumeShieldBlocked { get; set; }

		public bool IsEnragedOrDistressed
		{
			get
			{
				if (!IsEnraged)
				{
					return IsDistressed;
				}
				return true;
			}
		}

		public bool IsEnraged => base.CastRole.IsRageState(Scp096RageState.Enraged);

		public bool IsDistressed => base.CastRole.IsRageState(Scp096RageState.Distressed);

		public float EnragedTimeLeft
		{
			get
			{
				return _enragedTimeLeft;
			}
			set
			{
				if (value < 0f)
				{
					value = 0f;
				}
				HudRageDuration.Remaining = value;
				_enragedTimeLeft = value;
				if (NetworkServer.active && _enragedTimeLeft == 0f)
				{
					ServerEndEnrage(clearTime: false);
				}
			}
		}

		public float TotalRageTime { get; private set; }

		public void ServerEnrage(float initialDuration = 20f)
		{
			if (NetworkServer.active)
			{
				Scp096EnragingEventArgs e = new Scp096EnragingEventArgs(base.Owner, initialDuration);
				Scp096Events.OnEnraging(e);
				if (e.IsAllowed)
				{
					initialDuration = e.InitialDuration;
					EnragedTimeLeft = initialDuration;
					TotalRageTime = initialDuration;
					base.CastRole.StateController.SetRageState(Scp096RageState.Distressed);
					ServerIncreaseDuration(base.Owner, Mathf.Max((float)_targetsTracker.Targets.Count - 3f, 0f));
					Scp096Events.OnEnraged(new Scp096EnragedEventArgs(base.Owner, initialDuration));
				}
			}
		}

		public void ServerEndEnrage(bool clearTime = true)
		{
			if (NetworkServer.active)
			{
				if (clearTime)
				{
					EnragedTimeLeft = 0f;
				}
				base.CastRole.StateController.SetRageState(Scp096RageState.Calming);
				ServerSendRpc(toAll: true);
			}
		}

		public void ServerIncreaseDuration(ReferenceHub ownerHub, float addedDuration = 3f)
		{
			if (NetworkServer.active && !(ownerHub != base.Owner))
			{
				addedDuration = Mathf.Min(addedDuration, 35f - TotalRageTime);
				TotalRageTime += addedDuration;
				EnragedTimeLeft += addedDuration;
				ServerSendRpc(toAll: true);
			}
		}

		public override void ServerWriteRpc(NetworkWriter writer)
		{
			base.ServerWriteRpc(writer);
			writer.WriteFloat(EnragedTimeLeft);
		}

		public override void ClientProcessRpc(NetworkReader reader)
		{
			base.ClientProcessRpc(reader);
			if (!NetworkServer.active)
			{
				EnragedTimeLeft = reader.ReadFloat();
			}
		}

		protected override void Awake()
		{
			base.Awake();
			_shieldController = base.CastRole.HumeShieldModule as DynamicHumeShieldController;
			GetSubroutine<Scp096TargetsTracker>(out _targetsTracker);
			Scp096TargetsTracker.OnTargetAdded += (ReferenceHub ownerHub, ReferenceHub targetedHub) =>
			{
				ServerIncreaseDuration(ownerHub);
			};
			base.CastRole.StateController.OnRageUpdate += OnRageUpdate;
		}

		private void OnRageUpdate(Scp096RageState newState)
		{
			if (newState == Scp096RageState.Enraged)
			{
				HudRageDuration.Trigger(EnragedTimeLeft);
			}
			if (NetworkServer.active)
			{
				float num;
				switch (newState)
				{
				case Scp096RageState.Enraged:
					num = 1f;
					HumeShieldBlocked = true;
					_shieldController.AddBlocker(this);
					break;
				case Scp096RageState.Calming:
					num = 1f;
					TotalRageTime = 0f;
					HumeShieldBlocked = false;
					break;
				default:
					HumeShieldBlocked = false;
					return;
				}
				HumeShieldModuleBase humeShieldModule = base.CastRole.HumeShieldModule;
				humeShieldModule.HsCurrent = Mathf.Clamp(humeShieldModule.HsCurrent * num, 0f, humeShieldModule.HsMax);
			}
		}

		private void Update()
		{
			if (NetworkServer.active)
			{
				UpdateRage();
			}
		}

		private void UpdateRage()
		{
			if (IsEnraged)
			{
				EnragedTimeLeft -= Time.deltaTime;
			}
		}

		public override void ResetObject()
		{
			base.ResetObject();
			HudRageDuration.Clear();
			_shieldController.RegenerationRate = 15f;
			HumeShieldBlocked = false;
			_enragedTimeLeft = 0f;
			TotalRageTime = 0f;
		}
	}
}
