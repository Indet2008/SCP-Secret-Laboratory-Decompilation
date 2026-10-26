using System.Collections.Generic;
using PlayerRoles;
using PlayerRoles.FirstPersonControl;
using PlayerRoles.Spectating;
using Respawning;
using Respawning.Waves;
using UnityEngine;

namespace Christmas.Scp2536.Gifts
{
	public class BuddyInABox : Scp2536ItemGift
	{
		private const int MinimumSpectators = 2;

		private const float MaxSpawnDistance = 3f;

		private static readonly Dictionary<Team, RoleTypeId> TeamToRole = new Dictionary<Team, RoleTypeId>
		{
			[Team.ClassD] = RoleTypeId.ChaosFlamingo,
			[Team.ChaosInsurgency] = RoleTypeId.ChaosFlamingo,
			[Team.FoundationForces] = RoleTypeId.NtfFlamingo,
			[Team.Scientists] = RoleTypeId.NtfFlamingo
		};

		private static bool _waveSpawnedAlready;

		public override UrgencyLevel Urgency => UrgencyLevel.Two;

		protected override Scp2536Reward[] Rewards => new Scp2536Reward[1]
		{
			new Scp2536Reward(ItemType.Adrenaline, 100f)
		};

		public override bool CanBeGranted(ReferenceHub hub)
		{
			if (!base.CanBeGranted(hub))
			{
				return false;
			}
			Team team = hub.GetTeam();
			if (!TeamToRole.ContainsKey(team))
			{
				return false;
			}
			int num = 0;
			foreach (ReferenceHub allHub in ReferenceHub.AllHubs)
			{
				if (!(allHub == hub))
				{
					if (team == allHub.GetTeam())
					{
						return false;
					}
					if (allHub.roleManager.CurrentRole is SpectatorRole { ReadyToRespawn: not false })
					{
						num++;
					}
				}
			}
			return num < 2;
		}

		public override void ServerGrant(ReferenceHub hub)
		{
			if (!(hub.roleManager.CurrentRole is IFpcRole fpcRole))
			{
				return;
			}
			Vector3 forward = hub.PlayerCameraReference.forward;
			Vector3 position = fpcRole.FpcModule.Position;
			Team team = hub.GetTeam();
			RoleTypeId newRole = TeamToRole[team];
			int num = 0;
			ReferenceHub[] availablePlayers = WaveSpawner.GetAvailablePlayers(team);
			foreach (ReferenceHub referenceHub in availablePlayers)
			{
				if (num < 2)
				{
					referenceHub.roleManager.ServerSetRole(newRole, RoleChangeReason.ItemUsage, ~RoleSpawnFlags.UseSpawnpoint);
					if (referenceHub.roleManager.CurrentRole is IFpcRole fpcRole2)
					{
						Vector3 safePosition = SafeLocationFinder.GetSafePosition(position, forward, 3f, fpcRole2.FpcModule.CharController);
						Vector3 eulerAngles = Quaternion.LookRotation(position - safePosition).eulerAngles;
						fpcRole2.FpcModule.ServerOverridePosition(safePosition);
						fpcRole2.FpcModule.ServerOverrideRotation(eulerAngles);
						num++;
					}
					continue;
				}
				break;
			}
		}

		[RuntimeInitializeOnLoadMethod]
		private static void Init()
		{
			WaveManager.OnWaveSpawned += (SpawnableWaveBase w, List<ReferenceHub> _) =>
			{
				_waveSpawnedAlready = true;
			};
			CustomNetworkManager.OnClientReady += () =>
			{
				_waveSpawnedAlready = false;
			};
		}
	}
}
