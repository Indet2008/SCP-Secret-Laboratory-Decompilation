namespace LabApi.Features.Wrappers
{
	public class PocketDimension : global::LabApi.Features.Wrappers.Room
	{
		public static global::LabApi.Features.Wrappers.PocketDimension? Instance { get; private set; }

		public static global::System.Collections.Generic.IReadOnlyCollection<global::LabApi.Features.Wrappers.PocketTeleport> PocketTeleports => global::LabApi.Features.Wrappers.PocketTeleport.List;

		public static global::System.Collections.Generic.IEnumerable<global::LabApi.Features.Wrappers.PocketItem> PocketItems => global::LabApi.Features.Wrappers.PocketItem.List;

		public static float[] RecycleChances => global::PlayerRoles.PlayableScps.Scp106.Scp106PocketItemManager.RecycleChances;

		public static float MinPocketItemTriggerDelay
		{
			get
			{
				return global::PlayerRoles.PlayableScps.Scp106.Scp106PocketItemManager.TimerRange.x;
			}
			set
			{
				global::UnityEngine.Vector2 timerRange = global::PlayerRoles.PlayableScps.Scp106.Scp106PocketItemManager.TimerRange;
				timerRange.x = value;
				global::PlayerRoles.PlayableScps.Scp106.Scp106PocketItemManager.TimerRange = timerRange;
			}
		}

		public static float MaxPocketItemTriggerDelay
		{
			get
			{
				return global::PlayerRoles.PlayableScps.Scp106.Scp106PocketItemManager.TimerRange.y;
			}
			set
			{
				global::UnityEngine.Vector2 timerRange = global::PlayerRoles.PlayableScps.Scp106.Scp106PocketItemManager.TimerRange;
				timerRange.y = value;
				global::PlayerRoles.PlayableScps.Scp106.Scp106PocketItemManager.TimerRange = timerRange;
			}
		}

		public static void ForceInside(global::LabApi.Features.Wrappers.Player player)
		{
			player.EnableEffect<global::CustomPlayerEffects.PocketCorroding>(1);
		}

		public static bool IsPlayerInside(global::LabApi.Features.Wrappers.Player player)
		{
			return player.HasEffect<global::CustomPlayerEffects.PocketCorroding>();
		}

		public static global::UnityEngine.Vector3 GetCaughtPosition(global::LabApi.Features.Wrappers.Player player)
		{
			global::CustomPlayerEffects.PocketCorroding effect = player.GetEffect<global::CustomPlayerEffects.PocketCorroding>();
			if (effect != null && effect.Intensity > 0)
			{
				return effect.CapturePosition.Position;
			}
			return global::UnityEngine.Vector3.zero;
		}

		public static void ForceExit(global::LabApi.Features.Wrappers.Player player)
		{
			PocketDimensionTeleport.TryExit(null, player.ReferenceHub);
		}

		public static void ForceKill(global::LabApi.Features.Wrappers.Player player)
		{
			PocketDimensionTeleport.TryKill(null, player.ReferenceHub);
		}

		public static bool IsPickupInside(global::LabApi.Features.Wrappers.Pickup pickup)
		{
			return global::PlayerRoles.PlayableScps.Scp106.Scp106PocketItemManager.TrackedItems.ContainsKey(pickup.Base);
		}

		public static void RandomizeExits()
		{
			PocketDimensionGenerator.RandomizeTeleports();
		}

		public static global::System.Collections.Generic.IReadOnlyCollection<global::UnityEngine.Pose> GetExitPosesForZone(global::MapGeneration.FacilityZone zone)
		{
			return global::PlayerRoles.PlayableScps.Scp106.Scp106PocketExitFinder.GetPosesForZone(zone);
		}

		public static void AddExitPosesForZone(global::MapGeneration.FacilityZone zone, global::System.Collections.Generic.IEnumerable<global::UnityEngine.Pose> poses)
		{
			if (!global::PlayerRoles.PlayableScps.Scp106.Scp106PocketExitFinder.PosesForZoneCache.ContainsKey(zone))
			{
				global::PlayerRoles.PlayableScps.Scp106.Scp106PocketExitFinder.GetPosesForZone(zone);
			}
			global::System.Collections.Generic.Dictionary<global::MapGeneration.FacilityZone, global::UnityEngine.Pose[]> posesForZoneCache = global::PlayerRoles.PlayableScps.Scp106.Scp106PocketExitFinder.PosesForZoneCache;
			global::System.Collections.Generic.List<global::UnityEngine.Pose> list = new global::System.Collections.Generic.List<global::UnityEngine.Pose>();
			list.AddRange(global::PlayerRoles.PlayableScps.Scp106.Scp106PocketExitFinder.PosesForZoneCache[zone]);
			list.AddRange(poses);
			posesForZoneCache[zone] = list.ToArray();
		}

		public static void AddExitPoseForZone(global::MapGeneration.FacilityZone zone, global::UnityEngine.Pose pose)
		{
			AddExitPosesForZone(zone, new _003C_003Ez__ReadOnlySingleElementList<global::UnityEngine.Pose>(pose));
		}

		public static void RemoveAllExitPosesForZone(global::MapGeneration.FacilityZone zone)
		{
			global::PlayerRoles.PlayableScps.Scp106.Scp106PocketExitFinder.PosesForZoneCache[zone] = global::System.Array.Empty<global::UnityEngine.Pose>();
		}

		public static void RemoveExitPosesForZone(global::MapGeneration.FacilityZone zone, global::System.Collections.Generic.IEnumerable<global::UnityEngine.Pose> poses)
		{
			if (!global::PlayerRoles.PlayableScps.Scp106.Scp106PocketExitFinder.PosesForZoneCache.ContainsKey(zone))
			{
				global::PlayerRoles.PlayableScps.Scp106.Scp106PocketExitFinder.GetPosesForZone(zone);
			}
			global::PlayerRoles.PlayableScps.Scp106.Scp106PocketExitFinder.PosesForZoneCache[zone] = global::System.Linq.Enumerable.ToArray(global::System.Linq.Enumerable.Except(global::PlayerRoles.PlayableScps.Scp106.Scp106PocketExitFinder.PosesForZoneCache[zone], poses));
		}

		public static void RemoveExitPoseForZone(global::MapGeneration.FacilityZone zone, global::UnityEngine.Pose pose)
		{
			RemoveExitPosesForZone(zone, new _003C_003Ez__ReadOnlySingleElementList<global::UnityEngine.Pose>(pose));
		}

		public static int GetRarity(global::LabApi.Features.Wrappers.Pickup pickup)
		{
			return GetRarity(global::InventorySystem.InventoryItemLoader.AvailableItems[pickup.Type]);
		}

		public static int GetRarity(global::LabApi.Features.Wrappers.Item item)
		{
			return GetRarity(item.Base);
		}

		public static int GetRarity(global::InventorySystem.Items.ItemBase item)
		{
			return global::PlayerRoles.PlayableScps.Scp106.Scp106PocketItemManager.GetRarity(item);
		}

		internal PocketDimension(global::MapGeneration.RoomIdentifier room)
			: base(room)
		{
			if (base.CanCache)
			{
				Instance = this;
			}
		}

		internal override void OnRemoved()
		{
			base.OnRemoved();
			Instance = null;
		}
	}
}
