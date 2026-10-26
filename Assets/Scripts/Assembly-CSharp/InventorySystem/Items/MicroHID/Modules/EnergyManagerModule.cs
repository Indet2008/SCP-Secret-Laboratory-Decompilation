using System.Collections.Generic;
using Mirror;
using UnityEngine;

namespace InventorySystem.Items.MicroHID.Modules
{
	public class EnergyManagerModule : MicroHidModuleBase
	{
		private static readonly Dictionary<ushort, float> SyncEnergy = new Dictionary<ushort, float>();

		private byte _serverLastSentEnergy;

		public float Energy => GetEnergy(base.ItemSerial);

		public static float GetEnergy(ushort serial)
		{
			return SyncEnergy.GetValueOrDefault(serial, 1f);
		}

		public override void ClientProcessRpcTemplate(NetworkReader reader, ushort serial)
		{
			base.ClientProcessRpcTemplate(reader, serial);
			if (!NetworkServer.active)
			{
				while (reader.Remaining > 0)
				{
					ushort key = reader.ReadUShort();
					byte compressed = reader.ReadByte();
					SyncEnergy[key] = DecodeEnergy(compressed);
				}
			}
		}

		internal override void OnClientReady()
		{
			base.OnClientReady();
			SyncEnergy.Clear();
		}

		internal override void OnAdded()
		{
			base.OnAdded();
			if (base.IsServer)
			{
				SendRpc((NetworkWriter x) =>
				{
					x.WriteUShort(base.ItemSerial);
					x.WriteByte(EncodeEnergy(Energy));
				});
			}
		}

		internal override void EquipUpdate()
		{
			base.EquipUpdate();
			if (!base.IsServer)
			{
				return;
			}
			float num = Energy;
			MicroHidPhase phase = base.MicroHid.CycleController.Phase;
			if (phase != MicroHidPhase.Standby && base.MicroHid.CycleController.TryGetLastFiringController(out var ret))
			{
				switch (phase)
				{
				case MicroHidPhase.WindingUp:
					num -= ret.DrainRateWindUp * Time.deltaTime;
					break;
				case MicroHidPhase.WoundUpSustain:
					num -= ret.DrainRateSustain * Time.deltaTime;
					break;
				case MicroHidPhase.Firing:
					num -= ret.DrainRateFiring * Time.deltaTime;
					break;
				}
				ServerSetEnergy(base.ItemSerial, num);
			}
		}

		private byte EncodeEnergy(float energy)
		{
			return (byte)(energy * 255f);
		}

		private float DecodeEnergy(byte compressed)
		{
			return (float)(int)compressed / 255f;
		}

		public void ServerSetEnergy(ushort serial, float amount)
		{
			amount = Mathf.Clamp01(amount);
			SyncEnergy[serial] = amount;
			byte energyCompressed = EncodeEnergy(amount);
			if (energyCompressed != _serverLastSentEnergy)
			{
				_serverLastSentEnergy = energyCompressed;
				SendRpc((NetworkWriter x) =>
				{
					x.WriteUShort(serial);
					x.WriteByte(energyCompressed);
				});
			}
		}

		internal override void ServerOnPlayerConnected(ReferenceHub hub, bool firstSubcomponent)
		{
			base.ServerOnPlayerConnected(hub, firstSubcomponent);
			if (!firstSubcomponent)
			{
				return;
			}
			SendRpc(hub, (NetworkWriter x) =>
			{
				foreach (KeyValuePair<ushort, float> item in SyncEnergy)
				{
					x.WriteUShort(item.Key);
					x.WriteByte(EncodeEnergy(item.Value));
				}
			});
		}
	}
}
