using System;
using System.Collections.Generic;
using CustomPlayerEffects;
using InventorySystem;
using LabApi.Events.Arguments.PlayerEvents;
using LabApi.Events.Handlers;
using Mirror;
using PlayerRoles;
using PlayerRoles.FirstPersonControl;
using PlayerRoles.PlayableScps.Scp106;
using PlayerRoles.Ragdolls;
using PlayerRoles.Spectating;
using PlayerStatsSystem.Modifiers;
using UnityEngine;

namespace PlayerStatsSystem
{
	public class PlayerStats : NetworkBehaviour
	{
		public static readonly Type[] DefinedModules = new Type[6]
		{
			typeof(HealthStat),
			typeof(AhpStat),
			typeof(StaminaStat),
			typeof(AdminFlagsStat),
			typeof(HumeShieldStat),
			typeof(VigorStat)
		};

		private ReferenceHub _hub;

		private bool _eventAssigned;

		private double _hurtTimestamp;

		private StatBase[] _statModules;

		private readonly Dictionary<Type, StatBase> _dictionarizedTypes = new Dictionary<Type, StatBase>();

		public StatBase[] StatModules
		{
			get
			{
				if (_statModules != null)
				{
					return _statModules;
				}
				_statModules = new StatBase[DefinedModules.Length];
				for (int i = 0; i < DefinedModules.Length; i++)
				{
					object obj = Activator.CreateInstance(DefinedModules[i]);
					_statModules[i] = obj as StatBase;
				}
				return _statModules;
			}
		}

		public double TimeSinceDamageTick => Math.Max(0.0, _hurtTimestamp - NetworkTime.time);

		public event Action<DamageHandlerBase> OnThisPlayerDamaged = (DamageHandlerBase usedHandler) =>
		{
		};

		public event Action<DamageHandlerBase> OnThisPlayerDied = (DamageHandlerBase usedHandler) =>
		{
		};

		public static event Action<ReferenceHub, DamageHandlerBase> OnAnyPlayerDamaged = (ReferenceHub victimPlayer, DamageHandlerBase usedHandler) =>
		{
		};

		public static event Action<ReferenceHub, DamageHandlerBase> OnAnyPlayerDied = (ReferenceHub victimPlayer, DamageHandlerBase usedHandler) =>
		{
		};

		private void Awake()
		{
			StatBase[] statModules = StatModules;
			foreach (StatBase statBase in statModules)
			{
				_dictionarizedTypes.Add(statBase.GetType(), statBase);
			}
			_hub = ReferenceHub.GetHub(base.gameObject);
			statModules = StatModules;
			for (int i = 0; i < statModules.Length; i++)
			{
				statModules[i].Init(_hub);
			}
		}

		private void Start()
		{
			if (_hub.isLocalPlayer)
			{
				PlayerRoleManager.OnRoleChanged += OnClassChanged;
				_eventAssigned = true;
			}
		}

		private void OnDestroy()
		{
			if (_eventAssigned)
			{
				PlayerRoleManager.OnRoleChanged -= OnClassChanged;
				_eventAssigned = false;
			}
		}

		private void Update()
		{
			StatBase[] statModules = StatModules;
			for (int i = 0; i < statModules.Length; i++)
			{
				statModules[i].Update();
			}
		}

		public T GetModule<T>() where T : StatBase
		{
			return _dictionarizedTypes[typeof(T)] as T;
		}

		public bool TryGetModule<T>(out T module) where T : StatBase
		{
			if (_dictionarizedTypes.TryGetValue(typeof(T), out var value) && value is T val)
			{
				module = val;
				return true;
			}
			module = null;
			return false;
		}

		public bool DealDamage(DamageHandlerBase handler)
		{
			if (_hub.characterClassManager.GodMode)
			{
				return false;
			}
			if (_hub.playerEffectsController.TryGetEffect<SpawnProtected>(out var playerEffect) && playerEffect.IsEnabled)
			{
				return false;
			}
			if (_hub.roleManager.CurrentRole is IDamageHandlerProcessingRole damageHandlerProcessingRole)
			{
				handler = damageHandlerProcessingRole.ProcessDamageHandler(handler);
			}
			ReferenceHub attacker = null;
			if (handler is AttackerDamageHandler attackerDamageHandler)
			{
				attacker = attackerDamageHandler.Attacker.Hub;
			}
			PlayerHurtingEventArgs e = new PlayerHurtingEventArgs(attacker, _hub, handler);
			PlayerEvents.OnHurting(e);
			if (!e.IsAllowed)
			{
				return false;
			}
			DamageHandlerBase.HandlerOutput handlerOutput = handler.ApplyDamage(_hub);
			PlayerEvents.OnHurt(new PlayerHurtEventArgs(attacker, _hub, handler));
			if (handlerOutput == DamageHandlerBase.HandlerOutput.Nothing)
			{
				return false;
			}
			OnAnyPlayerDamaged?.Invoke(_hub, handler);
			OnThisPlayerDamaged?.Invoke(handler);
			_hurtTimestamp = NetworkTime.time;
			if (handlerOutput == DamageHandlerBase.HandlerOutput.Death)
			{
				PlayerDyingEventArgs e2 = new PlayerDyingEventArgs(_hub, attacker, handler);
				PlayerEvents.OnDying(e2);
				if (!e2.IsAllowed)
				{
					return false;
				}
				RoleTypeId roleId = _hub.GetRoleId();
				Vector3 position = _hub.GetPosition();
				Vector3 velocity = _hub.GetVelocity();
				Quaternion rotation = _hub.PlayerCameraReference.rotation;
				OnAnyPlayerDied?.Invoke(_hub, handler);
				OnThisPlayerDied?.Invoke(handler);
				KillPlayer(handler);
				PlayerEvents.OnDeath(new PlayerDeathEventArgs(_hub, attacker, handler, roleId, position, velocity, rotation));
			}
			return true;
		}

		private void KillPlayer(DamageHandlerBase handler)
		{
			if (!(handler is IDeathRagdollModifier { PreventRagdollSpawn: not false }))
			{
				RagdollManager.ServerSpawnRagdoll(_hub, handler);
			}
			if (!(handler is IDeathInventoryModifier { PreventDropInventory: not false }))
			{
				_hub.inventory.ServerDropEverything();
			}
			_hub.roleManager.ServerSetRole(RoleTypeId.Spectator, RoleChangeReason.Died, RoleSpawnFlags.All, (PlayerRoleBase roleBase) =>
			{
				if (_hub.roleManager.CurrentRole is SpectatorRole spectatorRole)
				{
					spectatorRole.ServerSetData(handler);
				}
			});
			_hub.gameConsoleTransmission.SendToClient("You died. Reason: " + handler.ServerLogsText, "yellow");
		}

		private void OnClassChanged(ReferenceHub userHub, PlayerRoleBase prevRole, PlayerRoleBase newRole)
		{
			StatBase[] statModules = userHub.playerStats.StatModules;
			for (int i = 0; i < statModules.Length; i++)
			{
				statModules[i].ClassChanged();
			}
		}

		public override bool Weaved()
		{
			return true;
		}
	}
}
