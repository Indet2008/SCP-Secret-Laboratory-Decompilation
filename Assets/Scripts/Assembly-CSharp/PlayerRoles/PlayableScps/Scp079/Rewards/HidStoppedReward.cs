using InventorySystem;
using InventorySystem.Items.MicroHID;
using InventorySystem.Items.MicroHID.Modules;
using MapGeneration;
using Mirror;
using PlayerRoles.FirstPersonControl;
using PlayerStatsSystem;
using UnityEngine;
using Utils.NonAllocLINQ;

namespace PlayerRoles.PlayableScps.Scp079.Rewards
{
	public static class HidStoppedReward
	{
		private const int Reward = 50;

		private const float MinReadiness = 0.75f;

		private const float TimeTolerance = 10f;

		private const float ScpMinProximitySqr = 600f;

		private static bool _available;

		private static double _microDamageCooldown;

		[RuntimeInitializeOnLoadMethod]
		private static void Init()
		{
			PlayerRoleManager.OnRoleChanged += (ReferenceHub hub, PlayerRoleBase x, PlayerRoleBase y) =>
			{
				if (NetworkServer.active && y is Scp079Role)
				{
					_available = true;
				}
			};
			PlayerStats.OnAnyPlayerDamaged += (ReferenceHub hub, DamageHandlerBase dh) =>
			{
				if (NetworkServer.active && _available && dh is MicroHidDamageHandler)
				{
					_microDamageCooldown = NetworkTime.time + 10.0;
				}
			};
			PlayerStats.OnAnyPlayerDied += (ReferenceHub hub, DamageHandlerBase dh) =>
			{
				if (NetworkServer.active && _available && hub.inventory.CurInstance is MicroHIDItem microHIDItem && !(microHIDItem == null) && !(microHIDItem.CycleController.ServerWindUpProgress < 0.75f))
				{
					TryGrant(hub);
				}
			};
			CycleController.OnPhaseChanged += (ushort serial, MicroHidPhase phase) =>
			{
				if (NetworkServer.active)
				{
					CycleController cycleController = CycleSyncModule.GetCycleController(serial);
					if (_available && !(NetworkTime.time < _microDamageCooldown) && phase == MicroHidPhase.WindingDown && !(cycleController.ServerWindUpProgress < 0.75f) && InventoryExtensions.TryGetHubHoldingSerial(serial, out var hub))
					{
						TryGrant(hub);
					}
				}
			};
		}

		private static void TryGrant(ReferenceHub ply)
		{
			if (!(ply.roleManager.CurrentRole is IFpcRole fpcRole))
			{
				return;
			}
			Vector3 humanPos = fpcRole.FpcModule.Position;
			if (!humanPos.TryGetRoom(out var room) || !ReferenceHub.AllHubs.Any((ReferenceHub x) => IsNearbyTeammate(humanPos, x)))
			{
				return;
			}
			foreach (Scp079Role activeInstance in Scp079Role.ActiveInstances)
			{
				if (Scp079RewardManager.CheckForRoomInteractions(activeInstance, room))
				{
					_available = false;
					Scp079RewardManager.GrantExp(activeInstance, 50, Scp079HudTranslation.ExpGainHidStopped);
				}
			}
		}

		private static bool IsNearbyTeammate(Vector3 attackerPos, ReferenceHub teammate)
		{
			if (!teammate.IsSCP(includeZombies: false))
			{
				return false;
			}
			if (!(teammate.roleManager.CurrentRole is IFpcRole fpcRole))
			{
				return false;
			}
			return (fpcRole.FpcModule.Position - attackerPos).sqrMagnitude < 600f;
		}
	}
}
