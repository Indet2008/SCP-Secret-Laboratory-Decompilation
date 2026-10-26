using System.Collections.Generic;
using System.Runtime.InteropServices;
using Interactables;
using Interactables.Interobjects.DoorUtils;
using Interactables.Verification;
using LabApi.Events.Arguments.PlayerEvents;
using LabApi.Events.Handlers;
using MapGeneration.Holidays;
using MapGeneration.StaticHelpers;
using Mirror;
using Mirror.RemoteCalls;
using NorthwoodLib.Pools;
using UnityEngine;

namespace MapGeneration.Distributors
{
	public class Locker : SpawnableStructure, IServerInteractable, IInteractable, IBlockStaticBatching
	{
		public LockerLoot[] Loot;

		public LockerChamber[] Chambers;

		[SyncVar]
		public ushort OpenedChambers;

		[SerializeField]
		private AudioClip _grantedBeep;

		[SerializeField]
		private AudioClip _deniedBeep;

		[Header("Leave 0 to fill all chambers")]
		public int MinChambersToFill;

		public int MaxChambersToFill;

		private ushort? _prevOpened;

		private bool _serverChambersFilled;

		private float _deniedCooldown;

		private const float DeniedCooldownDuration = 1f;

		public IVerificationRule VerificationRule => StandardDistanceVerification.Default;

		public ushort NetworkOpenedChambers
		{
			get
			{
				return OpenedChambers;
			}
			[param: In]
			set
			{
				GeneratedSyncVarSetter(value, ref OpenedChambers, 1uL, null);
			}
		}

		public void ServerInteract(ReferenceHub ply, byte colliderId)
		{
			if (!Chambers.TryGet(colliderId, out var element) || !element.CanInteract)
			{
				return;
			}
			bool flag = !CheckTogglePerms(colliderId, ply, out var callback);
			PlayerInteractingLockerEventArgs e = new PlayerInteractingLockerEventArgs(ply, this, Chambers[colliderId], !flag);
			PlayerEvents.OnInteractingLocker(e);
			if (!e.IsAllowed)
			{
				return;
			}
			flag = !e.CanOpen;
			if (flag)
			{
				if (_deniedCooldown <= 0f)
				{
					RpcPlayDenied(colliderId, ply.GetCombinedPermissions(element));
					callback?.Invoke(element, success: false);
					_deniedCooldown = 1f;
				}
				PlayerEvents.OnInteractedLocker(new PlayerInteractedLockerEventArgs(ply, this, Chambers[colliderId], !flag));
			}
			else
			{
				element.SetDoor(!element.IsOpen, _grantedBeep);
				RefreshOpenedSyncvar();
				callback?.Invoke(element, success: true);
				PlayerEvents.OnInteractedLocker(new PlayerInteractedLockerEventArgs(ply, this, Chambers[colliderId], !flag));
			}
		}

		public void RefreshOpenedSyncvar()
		{
			int num = 1;
			int num2 = 0;
			LockerChamber[] chambers = Chambers;
			for (int i = 0; i < chambers.Length; i++)
			{
				if (chambers[i].IsOpen)
				{
					num2 += num;
				}
				num *= 2;
			}
			if (num2 != OpenedChambers)
			{
				NetworkOpenedChambers = (ushort)num2;
			}
		}

		public virtual void FillChamber(LockerChamber ch)
		{
			List<int> list = ListPool<int>.Shared.Rent();
			for (int i = 0; i < Loot.Length; i++)
			{
				LockerLoot lockerLoot = Loot[i];
				if (lockerLoot.RemainingUses > 0 && (ch.AcceptableItems.Length == 0 || ch.AcceptableItems.Contains(lockerLoot.TargetItem)))
				{
					for (int j = 0; j <= lockerLoot.ProbabilityPoints; j++)
					{
						list.Add(i);
					}
				}
			}
			if (list.Count > 0)
			{
				int num = list[Random.Range(0, list.Count)];
				LockerLoot lockerLoot2 = Loot[num];
				ch.SpawnItem(lockerLoot2.TargetItem, Random.Range(lockerLoot2.MinPerChamber, lockerLoot2.MaxPerChamber + 1));
				lockerLoot2.RemainingUses--;
			}
			ListPool<int>.Shared.Return(list);
		}

		[ClientRpc]
		public void RpcPlayDenied(byte chamberId, DoorPermissionFlags perms)
		{
			NetworkWriterPooled writer = NetworkWriterPool.Get();
			NetworkWriterExtensions.WriteByte(writer, chamberId);
			GeneratedNetworkCode._Write_Interactables_002EInterobjects_002EDoorUtils_002EDoorPermissionFlags(writer, perms);
			SendRPCInternal("System.Void MapGeneration.Distributors.Locker::RpcPlayDenied(System.Byte,Interactables.Interobjects.DoorUtils.DoorPermissionFlags)", 1380298176, writer, 0, includeOwner: true);
			NetworkWriterPool.Return(writer);
		}

		protected override void Start()
		{
			base.Start();
			if (!HolidayUtils.IsHolidayActive(HolidayType.Halloween))
			{
				return;
			}
			LockerLoot[] loot = Loot;
			foreach (LockerLoot lockerLoot in loot)
			{
				if (lockerLoot.TargetItem == ItemType.Flashlight)
				{
					lockerLoot.TargetItem = ItemType.Lantern;
				}
			}
		}

		protected virtual void Update()
		{
			if (!NetworkClient.ready)
			{
				return;
			}
			if (NetworkServer.active)
			{
				if (_deniedCooldown > 0f)
				{
					_deniedCooldown -= Time.deltaTime;
				}
				if (!_serverChambersFilled)
				{
					ServerFillChambers();
					_serverChambersFilled = true;
				}
			}
			if (_prevOpened != OpenedChambers)
			{
				int num = 1;
				LockerChamber[] chambers = Chambers;
				foreach (LockerChamber lockerChamber in chambers)
				{
					lockerChamber.SetDoor((OpenedChambers & num) == num || !lockerChamber.AnimatorSet, _grantedBeep);
					num *= 2;
				}
				_prevOpened = OpenedChambers;
			}
		}

		protected virtual void ServerFillChambers()
		{
			List<LockerChamber> list = new List<LockerChamber>(Chambers);
			if (MinChambersToFill != 0 && MaxChambersToFill >= MinChambersToFill)
			{
				int num = Chambers.Length - Random.Range(MinChambersToFill, MaxChambersToFill + 1);
				for (int i = 0; i < num; i++)
				{
					list.RemoveAt(Random.Range(0, list.Count));
				}
			}
			foreach (LockerChamber item in list)
			{
				FillChamber(item);
			}
		}

		protected virtual bool CheckTogglePerms(int chamberId, ReferenceHub ply, out PermissionUsed callback)
		{
			return Chambers[chamberId].CheckPermissions(ply, out callback);
		}

		public override bool Weaved()
		{
			return true;
		}

		protected void UserCode_RpcPlayDenied__Byte__DoorPermissionFlags(byte chamberId, DoorPermissionFlags perms)
		{
			if (chamberId <= Chambers.Length)
			{
				Chambers[chamberId].PlayDenied(_deniedBeep, perms, 1f);
			}
		}

		protected static void InvokeUserCode_RpcPlayDenied__Byte__DoorPermissionFlags(NetworkBehaviour obj, NetworkReader reader, NetworkConnectionToClient senderConnection)
		{
			if (!NetworkClient.active)
			{
				Debug.LogError("RPC RpcPlayDenied called on server.");
			}
			else
			{
				((Locker)obj).UserCode_RpcPlayDenied__Byte__DoorPermissionFlags(NetworkReaderExtensions.ReadByte(reader), GeneratedNetworkCode._Read_Interactables_002EInterobjects_002EDoorUtils_002EDoorPermissionFlags(reader));
			}
		}

		static Locker()
		{
			RemoteProcedureCalls.RegisterRpc(typeof(Locker), "System.Void MapGeneration.Distributors.Locker::RpcPlayDenied(System.Byte,Interactables.Interobjects.DoorUtils.DoorPermissionFlags)", InvokeUserCode_RpcPlayDenied__Byte__DoorPermissionFlags);
		}

		protected override void SerializeSyncVars(NetworkWriter writer, bool forceAll)
		{
			base.SerializeSyncVars(writer, forceAll);
			if (forceAll)
			{
				writer.WriteUShort(OpenedChambers);
				return;
			}
			writer.WriteULong(base.syncVarDirtyBits);
			if ((base.syncVarDirtyBits & 1L) != 0L)
			{
				writer.WriteUShort(OpenedChambers);
			}
		}

		protected override void DeserializeSyncVars(NetworkReader reader, bool initialState)
		{
			base.DeserializeSyncVars(reader, initialState);
			if (initialState)
			{
				GeneratedSyncVarDeserialize(ref OpenedChambers, null, reader.ReadUShort());
				return;
			}
			long num = (long)reader.ReadULong();
			if ((num & 1L) != 0L)
			{
				GeneratedSyncVarDeserialize(ref OpenedChambers, null, reader.ReadUShort());
			}
		}
	}
}
