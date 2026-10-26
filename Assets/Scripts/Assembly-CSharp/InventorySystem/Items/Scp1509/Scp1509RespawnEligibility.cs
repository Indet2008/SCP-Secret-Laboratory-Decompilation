using System.Collections.Generic;
using Footprinting;
using NorthwoodLib.Pools;
using PlayerRoles;
using PlayerRoles.Spectating;
using UnityEngine;
using Utils.NonAllocLINQ;

namespace InventorySystem.Items.Scp1509
{
	public static class Scp1509RespawnEligibility
	{
		private static List<Footprint> _ineligibleForRoundPlayers = new List<Footprint>();

		private static Dictionary<ReferenceHub, RoleTypeId> _previousRole = new Dictionary<ReferenceHub, RoleTypeId>();

		[RuntimeInitializeOnLoadMethod(RuntimeInitializeLoadType.BeforeSceneLoad)]
		private static void Init()
		{
			PlayerRoleManager.OnServerRoleSet += OnServerRoleSet;
			CustomNetworkManager.OnClientReady += () =>
			{
				_ineligibleForRoundPlayers.Clear();
				_previousRole.Clear();
			};
		}

		public static void OnServer1509Kill(ReferenceHub victim)
		{
			if (!_ineligibleForRoundPlayers.Any((Footprint x) => x.Hub == victim))
			{
				_ineligibleForRoundPlayers.Add(new Footprint(victim));
			}
		}

		public static ReferenceHub GetEligibleSpectator(RoleTypeId roleToRespawn)
		{
			List<ReferenceHub> list = ListPool<ReferenceHub>.Shared.Rent(ReferenceHub.AllHubs.Count);
			List<ReferenceHub> list2 = ListPool<ReferenceHub>.Shared.Rent(ReferenceHub.AllHubs.Count);
			foreach (ReferenceHub player in ReferenceHub.AllHubs)
			{
				if (player.roleManager.CurrentRole is SpectatorRole { ReadyToRespawn: not false } && !_ineligibleForRoundPlayers.Any((Footprint x) => x.Hub == player))
				{
					list.Add(player);
					if (_previousRole.Any((KeyValuePair<ReferenceHub, RoleTypeId> x) => x.Key == player && (x.Value == roleToRespawn || roleToRespawn.GetTeam() == x.Value.GetTeam())))
					{
						list2.Add(player);
					}
				}
			}
			list.Sort((ReferenceHub ply1, ReferenceHub ply2) => ply2.roleManager.CurrentRole.ActiveTime.CompareTo(ply1.roleManager.CurrentRole.ActiveTime));
			list2.Sort((ReferenceHub ply1, ReferenceHub ply2) => ply2.roleManager.CurrentRole.ActiveTime.CompareTo(ply1.roleManager.CurrentRole.ActiveTime));
			ReferenceHub referenceHub = ((list2.Count != 0) ? list2[0] : ((list.Count == 0) ? null : list[0]));
			if (referenceHub != null)
			{
				_ineligibleForRoundPlayers.Add(new Footprint(referenceHub));
			}
			ListPool<ReferenceHub>.Shared.Return(list);
			ListPool<ReferenceHub>.Shared.Return(list2);
			return referenceHub;
		}

		public static bool IsAnyEligibleSpectators()
		{
			foreach (ReferenceHub player in ReferenceHub.AllHubs)
			{
				if (player.roleManager.CurrentRole is SpectatorRole { ReadyToRespawn: not false } && !_ineligibleForRoundPlayers.Any((Footprint x) => x.Hub == player))
				{
					return true;
				}
			}
			return false;
		}

		public static bool IsEligible(ReferenceHub player)
		{
			if (!(player.roleManager.CurrentRole is SpectatorRole { ReadyToRespawn: not false }))
			{
				return false;
			}
			return !_ineligibleForRoundPlayers.Any((Footprint x) => x.Hub == player);
		}

		public static void SetEligible(ReferenceHub player, bool isEligible)
		{
			int num = _ineligibleForRoundPlayers.FindIndex((Footprint x) => x.Hub == player);
			if (num != -1)
			{
				_ineligibleForRoundPlayers.RemoveAt(num);
			}
			if (!isEligible)
			{
				_ineligibleForRoundPlayers.Add(new Footprint(player));
			}
		}

		private static void OnServerRoleSet(ReferenceHub userHub, RoleTypeId newRole, RoleChangeReason reason)
		{
			RoleTypeId roleId = userHub.GetRoleId();
			_previousRole[userHub] = roleId;
		}
	}
}
