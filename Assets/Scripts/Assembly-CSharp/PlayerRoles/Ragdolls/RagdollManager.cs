using System;
using System.Collections.Generic;
using LabApi.Events.Arguments.PlayerEvents;
using LabApi.Events.Handlers;
using Mirror;
using PlayerStatsSystem;
using RelativePositioning;
using UnityEngine;
using UserSettings;
using UserSettings.VideoSettings;
using Utils.NonAllocLINQ;

namespace PlayerRoles.Ragdolls
{
	public static class RagdollManager
	{
		public static readonly HashSet<BasicRagdoll> AllRagdolls = new HashSet<BasicRagdoll>();

		private static readonly HashSet<NetworkIdentity> CachedRagdollPrefabs = new HashSet<NetworkIdentity>();

		private static bool _prefabsCacheSet;

		public static int FreezeTime { get; set; }

		private static HashSet<NetworkIdentity> AllRagdollPrefabs
		{
			get
			{
				if (_prefabsCacheSet)
				{
					return CachedRagdollPrefabs;
				}
				foreach (KeyValuePair<RoleTypeId, PlayerRoleBase> allRole in PlayerRoleLoader.AllRoles)
				{
					if (allRole.Value is IRagdollRole ragdollRole)
					{
						CachedRagdollPrefabs.Add(ragdollRole.Ragdoll.netIdentity);
					}
				}
				_prefabsCacheSet = true;
				return CachedRagdollPrefabs;
			}
		}

		public static event Action<ReferenceHub, BasicRagdoll> ServerOnRagdollCreated;

		public static event Action<BasicRagdoll> OnRagdollSpawned;

		public static event Action<BasicRagdoll> OnRagdollRemoved;

		internal static void OnSpawnedRagdoll(BasicRagdoll ragdoll)
		{
			AllRagdolls.Add(ragdoll);
			OnRagdollSpawned?.Invoke(ragdoll);
		}

		internal static void OnRemovedRagdoll(BasicRagdoll ragdoll)
		{
			AllRagdolls.Remove(ragdoll);
			OnRagdollRemoved?.Invoke(ragdoll);
		}

		public static BasicRagdoll ServerSpawnRagdoll(ReferenceHub owner, DamageHandlerBase handler)
		{
			if (!NetworkServer.active || owner == null)
			{
				return null;
			}
			if (!(owner.roleManager.CurrentRole is IRagdollRole ragdollRole))
			{
				return null;
			}
			PlayerSpawningRagdollEventArgs e = new PlayerSpawningRagdollEventArgs(owner, ragdollRole.Ragdoll, handler);
			PlayerEvents.OnSpawningRagdoll(e);
			if (!e.IsAllowed)
			{
				return null;
			}
			BasicRagdoll basicRagdoll = ragdollRole.Ragdoll.ServerInstantiateSelf(owner, owner.GetRoleId());
			Transform transform = ragdollRole.Ragdoll.transform;
			basicRagdoll.NetworkInfo = new RagdollData(owner, handler, transform.localPosition, transform.localRotation);
			ServerOnRagdollCreated?.Invoke(owner, basicRagdoll);
			NetworkServer.Spawn(basicRagdoll.gameObject);
			PlayerEvents.OnSpawnedRagdoll(new PlayerSpawnedRagdollEventArgs(owner, basicRagdoll, handler));
			return basicRagdoll;
		}

		public static BasicRagdoll ServerCreateRagdoll(RoleTypeId role, Vector3 position, Quaternion rotation, DamageHandlerBase handler, string nickname, Vector3? scale = null, ushort? serial = null, ReferenceHub owner = null)
		{
			if (!role.TryGetRoleTemplate<PlayerRoleBase>(out var result))
			{
				return null;
			}
			if (!(result is IRagdollRole ragdollRole))
			{
				return null;
			}
			RelativePosition relPos = new RelativePosition(position);
			if (relPos.OutOfRange)
			{
				return null;
			}
			Quaternion relativeRotation = WaypointBase.GetRelativeRotation(relPos.WaypointId, rotation);
			Vector3 defaultScale = GetDefaultScale(role);
			scale = (scale.HasValue ? new Vector3?(Vector3.Scale(scale.Value, defaultScale)) : new Vector3?(defaultScale));
			BasicRagdoll basicRagdoll = ragdollRole.Ragdoll.ServerInstantiateSelf(owner, role);
			basicRagdoll.NetworkInfo = new RagdollData(owner, handler, role, relPos, relativeRotation, scale.Value, nickname, NetworkTime.time, serial);
			ServerOnRagdollCreated?.Invoke(owner, basicRagdoll);
			NetworkServer.Spawn(basicRagdoll.gameObject);
			return basicRagdoll;
		}

		public static Vector3 GetDefaultScale(RoleTypeId role)
		{
			if (!role.TryGetRoleTemplate<PlayerRoleBase>(out var result))
			{
				return Vector3.zero;
			}
			if (!(result is IRagdollRole ragdollRole))
			{
				return Vector3.zero;
			}
			return ragdollRole.Ragdoll.transform.localScale;
		}

		[RuntimeInitializeOnLoadMethod]
		private static void Init()
		{
			CustomNetworkManager.OnClientStarted += () =>
			{
				AllRagdollPrefabs.ForEach(RegisterPrefab);
			};
			UserSetting<bool>.AddListener(PerformanceVideoSetting.RagdollFreeze, (bool _) =>
			{
				UpdateCleanupPrefs();
			});
			UserSetting<float>.AddListener(PerformanceVideoSetting.RagdollFreeze, (float _) =>
			{
				UpdateCleanupPrefs();
			});
			UpdateCleanupPrefs();
		}

		private static void RegisterPrefab(NetworkIdentity nid)
		{
			if (!NetworkClient.prefabs.ContainsKey(nid.assetId))
			{
				NetworkClient.UnregisterSpawnHandler(nid.assetId);
				BasicRagdoll component = nid.GetComponent<BasicRagdoll>();
				NetworkClient.RegisterPrefab(nid.gameObject, component.ClientHandleSpawn, component.ClientHandleDespawn);
			}
		}

		private static void UpdateCleanupPrefs()
		{
			bool num = UserSetting<bool>.Get(PerformanceVideoSetting.RagdollFreeze);
			int num2 = Mathf.RoundToInt(UserSetting<float>.Get(PerformanceVideoSetting.RagdollFreeze));
			FreezeTime = (num ? num2 : int.MaxValue);
		}
	}
}
