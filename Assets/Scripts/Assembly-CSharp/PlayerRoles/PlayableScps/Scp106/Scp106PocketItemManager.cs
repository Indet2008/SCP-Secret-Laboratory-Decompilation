using System;
using System.Collections.Generic;
using AudioPooling;
using InventorySystem;
using InventorySystem.Items;
using InventorySystem.Items.Pickups;
using MapGeneration;
using Mirror;
using PlayerRoles.FirstPersonControl;
using RelativePositioning;
using UnityEngine;
using Utils.NonAllocLINQ;

namespace PlayerRoles.PlayableScps.Scp106
{
	public static class Scp106PocketItemManager
	{
		public class PocketItem
		{
			public double TriggerTime;

			public bool Remove;

			public bool WarningSent;

			public RelativePosition DropPosition;
		}

		public struct WarningMessage : NetworkMessage
		{
			public RelativePosition Position;
		}

		public static readonly float[] RecycleChances = new float[3] { 0.5f, 0.7f, 1f };

		public static Vector2 TimerRange = new Vector2(90f, 240f);

		public static readonly Dictionary<ItemPickupBase, PocketItem> TrackedItems = new Dictionary<ItemPickupBase, PocketItem>();

		private const float WarningTime = 3f;

		private const float RaycastRange = 30f;

		private const float SoundRange = 12f;

		private const float SpawnOffset = 0.3f;

		private const float RandomEscapeVelocity = 0.2f;

		private const int MaxValidPositions = 64;

		private static readonly Vector3[] ValidPositionsNonAlloc = new Vector3[64];

		private static readonly HashSet<ItemPickupBase> ToRemove = new HashSet<ItemPickupBase>();

		private static float RandomVel => UnityEngine.Random.Range(-0.2f, 0.2f);

		public static event Action<ItemPickupBase, PocketItem> OnPocketItemAdded;

		public static event Action<ItemPickupBase> OnPocketItemRemoved;

		public static void AddItem(ItemPickupBase itemPickup)
		{
			if (InventoryItemLoader.TryGetItem<ItemBase>(itemPickup.Info.ItemId, out var result))
			{
				PocketItem pocketItem = new PocketItem
				{
					Remove = (UnityEngine.Random.value > RecycleChances[GetRarity(result)]),
					TriggerTime = NetworkTime.time + (double)UnityEngine.Random.Range(TimerRange.x, TimerRange.y),
					DropPosition = GetRandomValidSpawnPosition(),
					WarningSent = false
				};
				OnPocketItemAdded?.Invoke(itemPickup, pocketItem);
				TrackedItems.Add(itemPickup, pocketItem);
			}
		}

		public static void RemoveItem(ItemPickupBase itemPickup)
		{
			OnPocketItemRemoved?.Invoke(itemPickup);
			TrackedItems.Remove(itemPickup);
		}

		public static int GetRarity(ItemBase ib)
		{
			int num = 0;
			if (HasFlagFast(ib, ItemTierFlags.Rare))
			{
				num++;
			}
			if (HasFlagFast(ib, ItemTierFlags.MilitaryGrade))
			{
				num++;
			}
			if (HasFlagFast(ib, ItemTierFlags.ExtraRare))
			{
				num += 2;
			}
			return Mathf.Min(num, RecycleChances.Length - 1);
		}

		[RuntimeInitializeOnLoadMethod]
		private static void Init()
		{
			ItemPickupBase.OnPickupAdded += OnAdded;
			ItemPickupBase.OnPickupDestroyed += OnRemoved;
			StaticUnityMethods.OnUpdate += Update;
			CustomNetworkManager.OnClientReady += () =>
			{
				TrackedItems.Clear();
				NetworkClient.ReplaceHandler((WarningMessage x) =>
				{
					if (RoleTypeId.Scp106.TryGetRoleTemplate<Scp106Role>(out var result))
					{
						AudioSourcePoolManager.PlayAtPosition(result.ItemSpawnSound, x.Position, 12f);
					}
				});
			};
		}

		private static void Update()
		{
			if (!NetworkServer.active)
			{
				return;
			}
			bool flag = false;
			foreach (KeyValuePair<ItemPickupBase, PocketItem> trackedItem in TrackedItems)
			{
				if (!trackedItem.Key || !IsInPocketDimension(trackedItem.Key.transform.position))
				{
					flag |= ToRemove.Add(trackedItem.Key);
					continue;
				}
				PocketItem value = trackedItem.Value;
				double num = value.TriggerTime - NetworkTime.time;
				if (num > 3.0)
				{
					continue;
				}
				if (!value.Remove && !value.WarningSent)
				{
					NetworkServer.SendToAll(new WarningMessage
					{
						Position = value.DropPosition
					}, 0, sendToReadyOnly: true);
					value.WarningSent = true;
				}
				if (!(num > 0.0))
				{
					ItemPickupBase key = trackedItem.Key;
					Rigidbody component;
					if (value.Remove)
					{
						key.DestroySelf();
					}
					else if (key.TryGetComponent<Rigidbody>(out component))
					{
						component.linearVelocity = new Vector3(RandomVel, Physics.gravity.y, RandomVel);
						key.transform.position = value.DropPosition.Position;
					}
					value.TriggerTime = NetworkTime.time + (double)UnityEngine.Random.Range(TimerRange.x, TimerRange.y);
				}
			}
			if (flag)
			{
				ToRemove.ForEach((ItemPickupBase x) =>
				{
					RemoveItem(x);
				});
			}
		}

		private static void OnAdded(ItemPickupBase ipb)
		{
			if (NetworkServer.active && IsInPocketDimension(ipb.transform.position))
			{
				AddItem(ipb);
			}
		}

		private static void OnRemoved(ItemPickupBase ipb)
		{
			if (NetworkServer.active)
			{
				TrackedItems.Remove(ipb);
			}
		}

		private static bool IsInPocketDimension(Vector3 position)
		{
			if (position.TryGetRoom(out var room))
			{
				return room.Name == RoomName.Pocket;
			}
			return false;
		}

		private static RelativePosition GetRandomValidSpawnPosition()
		{
			int num = 0;
			foreach (ReferenceHub allHub in ReferenceHub.AllHubs)
			{
				if (!(allHub.roleManager.CurrentRole is IFpcRole fpcRole))
				{
					continue;
				}
				Vector3 position = fpcRole.FpcModule.Position;
				if (!IsInPocketDimension(position) && TryGetRoofPosition(position, out var result))
				{
					ValidPositionsNonAlloc[num] = result;
					if (++num >= 64)
					{
						break;
					}
				}
			}
			if (num > 0)
			{
				return new RelativePosition(ValidPositionsNonAlloc[UnityEngine.Random.Range(0, num + 1)]);
			}
			foreach (RoomIdentifier allRoomIdentifier in RoomIdentifier.AllRoomIdentifiers)
			{
				if ((allRoomIdentifier.Zone == FacilityZone.HeavyContainment || allRoomIdentifier.Zone == FacilityZone.Entrance) && TryGetRoofPosition(allRoomIdentifier.transform.position, out var result2) && !IsInPocketDimension(result2))
				{
					ValidPositionsNonAlloc[num] = result2;
					if (++num >= 64)
					{
						break;
					}
				}
			}
			if (num == 0)
			{
				throw new InvalidOperationException("GetRandomValidSpawnPosition found no valid spawn positions.");
			}
			int num2 = UnityEngine.Random.Range(0, num + 1);
			return new RelativePosition(ValidPositionsNonAlloc[num2]);
		}

		private static bool TryGetRoofPosition(Vector3 point, out Vector3 result)
		{
			if (Physics.Raycast(point, Vector3.up, out var hitInfo, 30f, FpcStateProcessor.Mask))
			{
				result = hitInfo.point + Vector3.down * 0.3f;
				return true;
			}
			result = Vector3.zero;
			return false;
		}

		private static bool HasFlagFast(ItemBase ib, ItemTierFlags flag)
		{
			return (ib.TierFlags & flag) == flag;
		}
	}
}
