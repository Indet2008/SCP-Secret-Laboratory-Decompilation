using System;
using System.Collections.Generic;
using InventorySystem.Items.Autosync;
using InventorySystem.Items.Firearms.Modules.Misc;
using Mirror;
using UnityEngine;
using Utils.NonAllocLINQ;

namespace InventorySystem.Items.Firearms.Modules
{
	public class EventBasedEquipperModule : ModuleBase, IEquipperModule, IBusyIndicatorModule
	{
		private enum RpcType
		{
			SeedSync = 0,
			FirstTimeTrue = 1,
			FirstTimeFalse = 2,
			ResyncAllFirstTime = 3
		}

		private static readonly HashSet<ushort> ClientAlreadyEquippedSerials = new HashSet<ushort>();

		private static readonly HashSet<ushort> SyncFirstEquips = new HashSet<ushort>();

		private static readonly Dictionary<ushort, ushort> NextSeeds = new Dictionary<ushort, ushort>();

		[field: SerializeField]
		public float DisplayBaseEquipTime { get; private set; }

		[field: SerializeField]
		public bool RandomizeOnEquip { get; private set; }

		public bool IsBusy
		{
			get
			{
				if (IsEquipped || base.IsSpectator)
				{
					return base.Firearm.IsHolstering;
				}
				return true;
			}
		}

		public bool IsEquipped { get; private set; }

		public override bool AllowCmdsWhileHolstered => true;

		internal override void OnEquipped()
		{
			base.OnEquipped();
			Randomize();
			ApplyFirstTimeAnims();
			if (base.IsLocalPlayer)
			{
				ClientAlreadyEquippedSerials.Add(base.ItemSerial);
			}
		}

		internal override void SpectatorInit()
		{
			base.SpectatorInit();
			Randomize();
			ApplyFirstTimeAnims();
		}

		internal override void OnAdded()
		{
			base.OnAdded();
			ServerUpdateSeed();
			if (base.IsLocalPlayer && !ClientAlreadyEquippedSerials.Contains(base.ItemSerial))
			{
				SendCmd();
			}
		}

		internal override void OnHolstered()
		{
			base.OnHolstered();
			IsEquipped = false;
			ServerUpdateSeed();
			if (base.IsServer && SyncFirstEquips.Contains(base.ItemSerial))
			{
				SendRpc((NetworkWriter x) =>
				{
					x.WriteSubheader(RpcType.FirstTimeFalse);
				});
			}
		}

		internal override void OnClientReady()
		{
			base.OnClientReady();
			NextSeeds.Clear();
			SyncFirstEquips.Clear();
			ClientAlreadyEquippedSerials.Clear();
		}

		internal override void ServerOnPlayerConnected(ReferenceHub hub, bool firstModule)
		{
			base.ServerOnPlayerConnected(hub, firstModule);
			if (!firstModule)
			{
				return;
			}
			SendRpc((NetworkWriter writer) =>
			{
				writer.WriteSubheader(RpcType.ResyncAllFirstTime);
				SyncFirstEquips.ForEach((ushort s) =>
				{
					writer.WriteUShort(s);
				});
			});
		}

		public override void ServerProcessCmd(NetworkReader reader)
		{
			base.ServerProcessCmd(reader);
			SendRpc((NetworkWriter x) =>
			{
				x.WriteSubheader(RpcType.FirstTimeTrue);
			});
		}

		public override void ClientProcessRpcTemplate(NetworkReader reader, ushort serial)
		{
			base.ClientProcessRpcTemplate(reader, serial);
			switch ((RpcType)reader.ReadByte())
			{
			case RpcType.SeedSync:
				NextSeeds[serial] = reader.ReadUShort();
				break;
			case RpcType.FirstTimeTrue:
				SyncFirstEquips.Add(serial);
				break;
			case RpcType.FirstTimeFalse:
				SyncFirstEquips.Remove(serial);
				break;
			case RpcType.ResyncAllFirstTime:
				SyncFirstEquips.Clear();
				while (reader.Remaining > 0)
				{
					SyncFirstEquips.Add(reader.ReadUShort());
				}
				break;
			}
		}

		private void ServerUpdateSeed()
		{
			if (base.IsServer && RandomizeOnEquip)
			{
				int rand = UnityEngine.Random.Range(0, 65535);
				SendRpc((NetworkWriter x) =>
				{
					x.WriteSubheader(RpcType.SeedSync);
					x.WriteUShort((ushort)rand);
				});
			}
		}

		private void Randomize()
		{
			if (RandomizeOnEquip)
			{
				double num = new System.Random(NextSeeds.GetValueOrDefault(base.ItemSerial, base.ItemSerial)).NextDouble();
				base.Firearm.AnimSetFloat(FirearmAnimatorHashes.Random, (float)num);
			}
		}

		private void ApplyFirstTimeAnims()
		{
			if (SyncFirstEquips.Contains(base.ItemSerial))
			{
				base.Firearm.AnimSetBool(FirearmAnimatorHashes.FirstTimePickup, b: true, checkIfExists: true);
			}
		}

		[ExposedFirearmEvent]
		public void Equip()
		{
			IsEquipped = true;
		}
	}
}
