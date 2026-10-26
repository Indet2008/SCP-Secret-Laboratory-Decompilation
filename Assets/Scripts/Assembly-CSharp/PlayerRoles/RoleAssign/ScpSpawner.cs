using System.Collections.Generic;
using PlayerRoles.PlayableScps;
using UnityEngine;

namespace PlayerRoles.RoleAssign
{
	public static class ScpSpawner
	{
		private static readonly Dictionary<ReferenceHub, float> SelectedSpawnChances = new Dictionary<ReferenceHub, float>();

		private static readonly Dictionary<ReferenceHub, float> ChancesBuffer = new Dictionary<ReferenceHub, float>();

		private static readonly List<RoleTypeId> BackupScps = new List<RoleTypeId>(8);

		private static readonly List<RoleTypeId> EnqueuedScps = new List<RoleTypeId>(8);

		private static PlayerRoleBase[] _cachedSpawnableScps;

		private static float[] _chancesArray;

		private static bool _cacheSet;

		public static int MaxSpawnableScps => SpawnableScps.Length;

		private static PlayerRoleBase[] SpawnableScps
		{
			get
			{
				if (_cacheSet)
				{
					return _cachedSpawnableScps;
				}
				List<PlayerRoleBase> list = new List<PlayerRoleBase>();
				foreach (KeyValuePair<RoleTypeId, PlayerRoleBase> allRole in PlayerRoleLoader.AllRoles)
				{
					if (allRole.Value is ISpawnableScp)
					{
						list.Add(allRole.Value);
					}
				}
				_cacheSet = true;
				_chancesArray = new float[list.Count];
				return _cachedSpawnableScps = list.ToArray();
			}
		}

		private static RoleTypeId NextScp
		{
			get
			{
				float num = 0f;
				int num2 = SpawnableScps.Length;
				for (int i = 0; i < num2; i++)
				{
					PlayerRoleBase playerRoleBase = SpawnableScps[i];
					if (EnqueuedScps.Contains(playerRoleBase.RoleTypeId))
					{
						_chancesArray[i] = 0f;
						continue;
					}
					float spawnChance = (SpawnableScps[i] as ISpawnableScp).GetSpawnChance(EnqueuedScps);
					spawnChance = Mathf.Max(spawnChance, 0f);
					num += spawnChance;
					_chancesArray[i] = spawnChance;
				}
				if (num == 0f)
				{
					return RandomLeastFrequentScp;
				}
				float num3 = Random.Range(0f, num);
				for (int j = 0; j < num2; j++)
				{
					num3 -= _chancesArray[j];
					if (!(num3 >= 0f))
					{
						return SpawnableScps[j].RoleTypeId;
					}
				}
				return SpawnableScps[num2 - 1].RoleTypeId;
			}
		}

		private static RoleTypeId RandomLeastFrequentScp
		{
			get
			{
				int num = SpawnableScps.Length;
				int num2 = int.MaxValue;
				for (int i = 0; i < num; i++)
				{
					PlayerRoleBase playerRoleBase = SpawnableScps[i];
					if (!(playerRoleBase is ISpawnableScp { AllowFallback: not false }))
					{
						continue;
					}
					RoleTypeId roleTypeId = playerRoleBase.RoleTypeId;
					int num3 = 0;
					foreach (RoleTypeId enqueuedScp in EnqueuedScps)
					{
						if (enqueuedScp == roleTypeId)
						{
							num3++;
						}
					}
					if (num3 <= num2)
					{
						if (num3 < num2)
						{
							BackupScps.Clear();
						}
						BackupScps.Add(roleTypeId);
						num2 = num3;
					}
				}
				return BackupScps.RandomItem();
			}
		}

		public static void SpawnScps(int targetScpNumber)
		{
			EnqueuedScps.Clear();
			for (int i = 0; i < targetScpNumber; i++)
			{
				EnqueuedScps.Add(NextScp);
			}
			List<ReferenceHub> chosenPlayers = ScpPlayerPicker.ChoosePlayers(targetScpNumber);
			while (EnqueuedScps.Count > 0)
			{
				RoleTypeId scp = EnqueuedScps[0];
				EnqueuedScps.RemoveAt(0);
				AssignScp(chosenPlayers, scp, EnqueuedScps);
			}
		}

		private static void AssignScp(List<ReferenceHub> chosenPlayers, RoleTypeId scp, List<RoleTypeId> otherScps)
		{
			ChancesBuffer.Clear();
			int num = 1;
			int num2 = 0;
			foreach (ReferenceHub chosenPlayer in chosenPlayers)
			{
				int combinedPreferencePoints = GetCombinedPreferencePoints(chosenPlayer, scp, otherScps);
				num2++;
				ChancesBuffer[chosenPlayer] = combinedPreferencePoints;
				num = Mathf.Min(combinedPreferencePoints, num);
			}
			float num3 = 0f;
			SelectedSpawnChances.Clear();
			foreach (KeyValuePair<ReferenceHub, float> item in ChancesBuffer)
			{
				float num4 = Mathf.Pow(item.Value - (float)num + 1f, num2);
				SelectedSpawnChances[item.Key] = num4;
				num3 += num4;
			}
			float num5 = num3 * Random.value;
			float num6 = 0f;
			foreach (KeyValuePair<ReferenceHub, float> selectedSpawnChance in SelectedSpawnChances)
			{
				num6 += selectedSpawnChance.Value;
				if (!(num6 < num5))
				{
					ReferenceHub key = selectedSpawnChance.Key;
					chosenPlayers.Remove(key);
					key.roleManager.ServerSetRole(scp, RoleChangeReason.RoundStart);
					break;
				}
			}
		}

		private static int GetCombinedPreferencePoints(ReferenceHub ply, RoleTypeId scp, List<RoleTypeId> otherScps)
		{
			if (!(PlayerRoleLoader.AllRoles[scp] is ISpawnableScp { RespectPreferences: not false }))
			{
				return 0;
			}
			int num = GetSyncedPreference(ply, scp);
			foreach (RoleTypeId otherScp in otherScps)
			{
				num -= GetSyncedPreference(ply, otherScp);
			}
			return num;
			static int GetSyncedPreference(ReferenceHub referenceHub, RoleTypeId key)
			{
				int connectionId = referenceHub.connectionToClient.connectionId;
				if (!ScpSpawnPreferences.Preferences.TryGetValue(connectionId, out var value))
				{
					return 0;
				}
				if (!value.Preferences.TryGetValue(key, out var value2))
				{
					return 0;
				}
				return value2;
			}
		}
	}
}
