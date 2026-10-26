using System.Collections.Generic;
using Mirror;
using NorthwoodLib.Pools;
using UnityEngine;

namespace NetworkManagerUtils.Dummies
{
	public static class DummyUtils
	{
		public static UserGroup DummyGroup { get; set; } = new UserGroup
		{
			BadgeColor = "pumpkin",
			BadgeText = "Dummy",
			Permissions = 0uL,
			KickPower = 0,
			Cover = true,
			HiddenByDefault = false,
			Shared = false,
			RequiredKickPower = byte.MaxValue
		};

		public static ReferenceHub SpawnDummy(string nickname = "Dummy")
		{
			GameObject gameObject = Object.Instantiate(NetworkManager.singleton.playerPrefab);
			if (!gameObject.TryGetComponent<ReferenceHub>(out var component))
			{
				return null;
			}
			component.nicknameSync.MyNick = nickname;
			NetworkServer.AddPlayerForConnection(new DummyNetworkConnection(), gameObject);
			return component;
		}

		public static void DestroyAllDummies()
		{
			List<ReferenceHub> list = ListPool<ReferenceHub>.Shared.Rent();
			foreach (ReferenceHub allHub in ReferenceHub.AllHubs)
			{
				if (allHub.IsDummy)
				{
					list.Add(allHub);
				}
			}
			foreach (ReferenceHub item in list)
			{
				NetworkServer.Destroy(item.gameObject);
			}
			ListPool<ReferenceHub>.Shared.Return(list);
		}
	}
}
