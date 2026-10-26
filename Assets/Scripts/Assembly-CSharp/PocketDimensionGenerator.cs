using System;
using System.Linq;
using GameCore;
using Mirror;
using UnityEngine;

public static class PocketDimensionGenerator
{
	public static void RandomizeTeleports()
	{
		if (!NetworkServer.active)
		{
			return;
		}
		System.Random random = Misc.CreateRandom();
		PocketDimensionTeleport[] array = PrepTeleports();
		int num = ConfigFile.ServerConfig.GetInt("pd_exit_count", 2);
		for (int i = 0; i < num; i++)
		{
			if (!ContainsKiller(array))
			{
				break;
			}
			int num2 = -1;
			while ((num2 < 0 || array[num2].GetTeleportType() == PocketDimensionTeleport.PDTeleportType.Exit) && ContainsKiller(array))
			{
				num2 = random.Next(0, array.Length);
			}
			array[Mathf.Clamp(num2, 0, array.Length - 1)].SetType(PocketDimensionTeleport.PDTeleportType.Exit);
		}
	}

	private static PocketDimensionTeleport[] PrepTeleports()
	{
		PocketDimensionTeleport[] array = PocketDimensionTeleport.AllInstances.ToArray();
		for (int i = 0; i < array.Length; i++)
		{
			array[i].SetType(PocketDimensionTeleport.PDTeleportType.Killer);
		}
		return array;
	}

	private static bool ContainsKiller(PocketDimensionTeleport[] pdtps)
	{
		for (int i = 0; i < pdtps.Length; i++)
		{
			if (pdtps[i].GetTeleportType() == PocketDimensionTeleport.PDTeleportType.Killer)
			{
				return true;
			}
		}
		return false;
	}

	[RuntimeInitializeOnLoadMethod]
	private static void Init()
	{
		PocketDimensionTeleport.OnInstancesUpdated += RandomizeTeleports;
	}
}
