using System.Collections.Generic;
using InventorySystem.Items.Autosync;
using InventorySystem.Items.Firearms.Modules;
using Mirror;
using PlayerRoles;
using PlayerRoles.Spectating;
using UnityEngine;
using Utils.Networking;

namespace InventorySystem.Items.Firearms.Ammo
{
	public static class ReserveAmmoSync
	{
		private class LastSent
		{
			public ItemType AmmoType;

			public int AmmoCount;
		}

		public readonly struct ReserveAmmoMessage : NetworkMessage
		{
			private readonly sbyte _ammoType;

			private readonly byte _amount;

			private readonly RecyclablePlayerId _player;

			public ReserveAmmoMessage(NetworkReader reader)
			{
				_ammoType = reader.ReadSByte();
				_amount = reader.ReadByte();
				_player = reader.ReadRecyclablePlayerId();
			}

			public ReserveAmmoMessage(ReferenceHub owner, ItemType ammoType)
			{
				_ammoType = (sbyte)ammoType;
				_amount = (byte)Mathf.Clamp(owner.inventory.GetCurAmmo(ammoType), 0, 255);
				_player = new RecyclablePlayerId(owner);
			}

			public void Serialize(NetworkWriter writer)
			{
				writer.WriteSByte(_ammoType);
				writer.WriteByte(_amount);
				writer.WriteRecyclablePlayerId(_player);
			}

			public void Apply()
			{
				if (ReferenceHub.TryGetHub(_player.Value, out var hub))
				{
					Set(hub, (ItemType)_ammoType, _amount);
				}
			}
		}

		private static readonly Dictionary<ReferenceHub, Dictionary<ItemType, int>> SyncData = new Dictionary<ReferenceHub, Dictionary<ItemType, int>>();

		private static readonly Dictionary<ReferenceHub, LastSent> ServerLastSent = new Dictionary<ReferenceHub, LastSent>();

		[RuntimeInitializeOnLoadMethod]
		private static void Init()
		{
			ReferenceHub.OnPlayerRemoved += (ReferenceHub hub) =>
			{
				SyncData.Remove(hub);
				ServerLastSent.Remove(hub);
			};
			PlayerRoleManager.OnServerRoleSet += (ReferenceHub hub, RoleTypeId newRole, RoleChangeReason reason) =>
			{
				if (!newRole.IsAlive())
				{
					SendAllToNewSpectator(hub);
				}
			};
			CustomNetworkManager.OnClientReady += () =>
			{
				SyncData.Clear();
				NetworkClient.ReplaceHandler((ReserveAmmoMessage msg) =>
				{
					msg.Apply();
				});
			};
			StaticUnityMethods.OnUpdate += () =>
			{
				if (NetworkServer.active)
				{
					UpdateDelta();
				}
			};
		}

		private static void SendAllToNewSpectator(ReferenceHub spectator)
		{
			foreach (AutosyncItem instance in AutosyncItem.Instances)
			{
				if (TryUnpack(instance, out var owner, out var ammoType))
				{
					spectator.connectionToClient.Send(new ReserveAmmoMessage(owner, ammoType));
				}
			}
		}

		private static void UpdateDelta()
		{
			foreach (AutosyncItem instance in AutosyncItem.Instances)
			{
				if (!TryUnpack(instance, out var owner, out var ammoType))
				{
					continue;
				}
				if (owner == null || owner.gameObject == null)
				{
					break;
				}
				int curAmmo = owner.inventory.GetCurAmmo(ammoType);
				LastSent orAdd = ServerLastSent.GetOrAdd(owner, () => new LastSent());
				if (orAdd.AmmoCount != curAmmo || orAdd.AmmoType != ammoType)
				{
					orAdd.AmmoType = ammoType;
					orAdd.AmmoCount = curAmmo;
					new ReserveAmmoMessage(owner, ammoType).SendToHubsConditionally((ReferenceHub x) => x.roleManager.CurrentRole is SpectatorRole);
				}
			}
		}

		private static bool TryUnpack(AutosyncItem src, out ReferenceHub owner, out ItemType ammoType)
		{
			owner = null;
			ammoType = ItemType.KeycardJanitor;
			if (!(src is Firearm { HasOwner: not false } firearm))
			{
				return false;
			}
			if (!firearm.TryGetModule<IPrimaryAmmoContainerModule>(out var module))
			{
				return false;
			}
			ammoType = module.AmmoType;
			owner = firearm.Owner;
			return true;
		}

		private static void Set(ReferenceHub hub, ItemType ammoType, int reserveAmmo)
		{
			SyncData.GetOrAdd(hub, () => new Dictionary<ItemType, int>())[ammoType] = reserveAmmo;
		}

		public static bool TryGet(ReferenceHub hub, ItemType ammoType, out int reserveAmmo)
		{
			if (NetworkServer.active || hub.isLocalPlayer)
			{
				reserveAmmo = hub.inventory.GetCurAmmo(ammoType);
				return true;
			}
			if (!SyncData.TryGetValue(hub, out var value))
			{
				reserveAmmo = 0;
				return false;
			}
			return value.TryGetValue(ammoType, out reserveAmmo);
		}

		public static void WriteReserveAmmoMessage(this NetworkWriter writer, ReserveAmmoMessage value)
		{
			value.Serialize(writer);
		}

		public static ReserveAmmoMessage ReadReserveAmmoMessage(this NetworkReader reader)
		{
			return new ReserveAmmoMessage(reader);
		}
	}
}
