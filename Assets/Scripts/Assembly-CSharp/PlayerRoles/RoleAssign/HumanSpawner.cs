using System;
using System.Collections.Generic;
using Utils.NonAllocLINQ;

namespace PlayerRoles.RoleAssign
{
	public static class HumanSpawner
	{
		private class RoleHistory
		{
			private int _clock;

			private RoleTypeId[] _history;

			public RoleTypeId[] History
			{
				get
				{
					if (_history == null)
					{
						_history = new RoleTypeId[5];
						for (int i = 0; i < 5; i++)
						{
							_history[i] = RoleTypeId.None;
						}
					}
					return _history;
				}
			}

			public void RegisterRole(RoleTypeId role)
			{
				History[_clock++ % 5] = role;
			}
		}

		private const RoleTypeId DefaultHumanRole = RoleTypeId.ClassD;

		private const int HistorySize = 5;

		private static Team[] _humanQueue;

		private static int _queueClock;

		private static int _queueLength;

		private static readonly Dictionary<Team, IHumanSpawnHandler> Handlers = new Dictionary<Team, IHumanSpawnHandler>
		{
			[Team.ClassD] = new OneRoleHumanSpawner(RoleTypeId.ClassD),
			[Team.FoundationForces] = new OneRoleHumanSpawner(RoleTypeId.FacilityGuard),
			[Team.Scientists] = new OneRoleHumanSpawner(RoleTypeId.Scientist)
		};

		private static readonly Dictionary<string, RoleHistory> History = new Dictionary<string, RoleHistory>();

		private static readonly List<ReferenceHub> Candidates = new List<ReferenceHub>();

		private static RoleTypeId NextHumanRoleToSpawn
		{
			get
			{
				if (_queueLength == 0)
				{
					throw new InvalidOperationException("Failed to get next role to spawn, queue has no human roles.");
				}
				Team key = _humanQueue[_queueClock++ % _queueLength];
				if (!Handlers.TryGetValue(key, out var value))
				{
					return RoleTypeId.ClassD;
				}
				return value.NextRole;
			}
		}

		public static void SpawnHumans(Team[] queue, int queueLength)
		{
			_humanQueue = queue;
			_queueClock = 0;
			_queueLength = queueLength;
			int num = ReferenceHub.AllHubs.Count(RoleAssigner.CheckPlayer);
			RoleTypeId[] array = new RoleTypeId[num];
			for (int i = 0; i < num; i++)
			{
				array[i] = NextHumanRoleToSpawn;
			}
			array.ShuffleList();
			for (int j = 0; j < num; j++)
			{
				AssignHumanRoleToRandomPlayer(array[j]);
			}
		}

		public static void SpawnLate(ReferenceHub ply)
		{
			ply.roleManager.ServerSetRole(NextHumanRoleToSpawn, RoleChangeReason.LateJoin);
		}

		private static void AssignHumanRoleToRandomPlayer(RoleTypeId role)
		{
			Candidates.Clear();
			int num = int.MaxValue;
			foreach (ReferenceHub allHub in ReferenceHub.AllHubs)
			{
				if (!RoleAssigner.CheckPlayer(allHub))
				{
					continue;
				}
				RoleHistory orAdd = History.GetOrAdd(allHub.authManager.UserId, () => new RoleHistory());
				int num2 = 0;
				for (int num3 = 0; num3 < 5; num3++)
				{
					if (orAdd.History[num3] == role)
					{
						num2++;
					}
				}
				if (num2 <= num)
				{
					if (num2 < num)
					{
						Candidates.Clear();
					}
					Candidates.Add(allHub);
					num = num2;
				}
			}
			if (Candidates.Count != 0)
			{
				ReferenceHub referenceHub = Candidates.RandomItem();
				referenceHub.roleManager.ServerSetRole(role, RoleChangeReason.RoundStart);
				History[referenceHub.authManager.UserId].RegisterRole(role);
			}
		}
	}
}
