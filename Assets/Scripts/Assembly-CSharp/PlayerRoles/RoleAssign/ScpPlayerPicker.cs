using System;
using System.Collections.Generic;
using NorthwoodLib.Pools;
using UnityEngine;

namespace PlayerRoles.RoleAssign
{
	public static class ScpPlayerPicker
	{
		private class PotentialScp
		{
			public ReferenceHub Player;

			public long Weight;
		}

		private const int DefaultTickets = 10;

		private const int HumanTicketBonus = 2;

		public const int ScpOptOutTickets = 0;

		private static readonly List<ReferenceHub> ScpsToSpawn = new List<ReferenceHub>();

		public static List<ReferenceHub> ChoosePlayers(int targetScps)
		{
			using (ScpTicketsLoader scpTicketsLoader = new ScpTicketsLoader())
			{
				GenerateList(scpTicketsLoader, targetScps);
				foreach (ReferenceHub allHub in ReferenceHub.AllHubs)
				{
					if (RoleAssigner.CheckPlayer(allHub) && !IsOptedOutOfScp(allHub))
					{
						int tickets = scpTicketsLoader.GetTickets(allHub, 10);
						scpTicketsLoader.ModifyTickets(allHub, tickets + 2);
					}
				}
				foreach (ReferenceHub item in ScpsToSpawn)
				{
					scpTicketsLoader.ModifyTickets(item, 10);
				}
			}
			if (targetScps != ScpsToSpawn.Count)
			{
				throw new InvalidOperationException("Failed to meet target number of SCPs.");
			}
			return ScpsToSpawn;
		}

		private static void GenerateList(ScpTicketsLoader loader, int scpsToAssign)
		{
			ScpsToSpawn.Clear();
			if (scpsToAssign <= 0)
			{
				return;
			}
			int num = 0;
			foreach (ReferenceHub allHub in ReferenceHub.AllHubs)
			{
				if (!RoleAssigner.CheckPlayer(allHub))
				{
					continue;
				}
				int tickets = loader.GetTickets(allHub, 10);
				if (tickets >= num)
				{
					if (tickets > num)
					{
						ScpsToSpawn.Clear();
					}
					num = tickets;
					ScpsToSpawn.Add(allHub);
				}
			}
			if (ScpsToSpawn.Count > 1)
			{
				ReferenceHub item = ScpsToSpawn.RandomItem();
				ScpsToSpawn.Clear();
				ScpsToSpawn.Add(item);
			}
			scpsToAssign -= ScpsToSpawn.Count;
			if (scpsToAssign <= 0)
			{
				return;
			}
			List<PotentialScp> list = ListPool<PotentialScp>.Shared.Rent();
			long num2 = 0L;
			foreach (ReferenceHub allHub2 in ReferenceHub.AllHubs)
			{
				if (!ScpsToSpawn.Contains(allHub2) && RoleAssigner.CheckPlayer(allHub2))
				{
					long num3 = 1L;
					int tickets2 = loader.GetTickets(allHub2, 10);
					for (int i = 0; i < scpsToAssign; i++)
					{
						num3 *= tickets2;
					}
					list.Add(new PotentialScp
					{
						Player = allHub2,
						Weight = num3
					});
					num2 += num3;
				}
			}
			while (scpsToAssign > 0)
			{
				double num4 = (double)UnityEngine.Random.value * (double)num2;
				for (int j = 0; j < list.Count; j++)
				{
					PotentialScp potentialScp = list[j];
					num4 -= (double)potentialScp.Weight;
					if (!(num4 > 0.0))
					{
						scpsToAssign--;
						ScpsToSpawn.Add(potentialScp.Player);
						list.RemoveAt(j);
						num2 -= potentialScp.Weight;
						break;
					}
				}
			}
			ListPool<PotentialScp>.Shared.Return(list);
		}

		public static bool IsOptedOutOfScp(ReferenceHub ply)
		{
			int connectionId = ply.connectionToClient.connectionId;
			if (!ScpSpawnPreferences.Preferences.TryGetValue(connectionId, out var value))
			{
				return false;
			}
			return value.OptOutOfScp;
		}
	}
}
