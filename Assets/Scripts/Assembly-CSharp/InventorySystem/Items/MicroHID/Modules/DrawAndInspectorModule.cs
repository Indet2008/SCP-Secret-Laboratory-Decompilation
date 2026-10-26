using System;
using System.Collections.Generic;
using AudioPooling;
using LabApi.Events.Arguments.PlayerEvents;
using LabApi.Events.Handlers;
using Mirror;
using UnityEngine;

namespace InventorySystem.Items.MicroHID.Modules
{
	public class DrawAndInspectorModule : MicroHidModuleBase
	{
		private enum RpcType
		{
			AddPickup = 0,
			OnEquipped = 1,
			OnHolstered = 2,
			InspectRequested = 3
		}

		private static readonly HashSet<ushort> PickupAnimSerials = new HashSet<ushort>();

		[SerializeField]
		private AudioClip _equipSound;

		[SerializeField]
		private AudioClip _pickupSound;

		public static event Action<ushort> OnInspectRequested;

		public static bool CheckPickupPreference(ushort serial)
		{
			return PickupAnimSerials.Contains(serial);
		}

		public void ServerRegisterSerial(ushort serial)
		{
			SendRpc((NetworkWriter x) =>
			{
				x.WriteByte(0);
				x.WriteUShort(serial);
			});
		}

		public override void ClientProcessRpcTemplate(NetworkReader reader, ushort serial)
		{
			base.ClientProcessRpcTemplate(reader, serial);
			switch ((RpcType)reader.ReadByte())
			{
			case RpcType.OnHolstered:
				PickupAnimSerials.Remove(serial);
				{
					foreach (AudioPoolSession activeSession in AudioManagerModule.GetController(serial).ActiveSessions)
					{
						AudioClip clip = activeSession.Source.clip;
						if (!(clip != _equipSound) || !(clip != _pickupSound))
						{
							activeSession.Source.Stop();
						}
					}
					break;
				}
			case RpcType.OnEquipped:
				AudioManagerModule.GetController(serial).PlayOneShot(CheckPickupPreference(serial) ? _pickupSound : _equipSound);
				break;
			case RpcType.AddPickup:
				while (reader.Remaining > 0)
				{
					PickupAnimSerials.Add(reader.ReadUShort());
				}
				break;
			case RpcType.InspectRequested:
				OnInspectRequested?.Invoke(serial);
				break;
			}
		}

		internal override void OnEquipped()
		{
			base.OnEquipped();
			if (base.IsServer)
			{
				SendRpc((NetworkWriter x) =>
				{
					x.WriteByte(1);
				});
			}
		}

		internal override void OnHolstered()
		{
			base.OnHolstered();
			SendRpc((NetworkWriter x) =>
			{
				x.WriteByte(2);
			});
		}

		internal override void EquipUpdate()
		{
			base.EquipUpdate();
			if (base.IsControllable && GetActionDown(ActionName.InspectItem))
			{
				SendCmd();
			}
		}

		public override void ServerProcessCmd(NetworkReader reader)
		{
			base.ServerProcessCmd(reader);
			if (base.ItemUsageBlocked)
			{
				return;
			}
			PlayerInspectingItemEventArgs e = new PlayerInspectingItemEventArgs(base.MicroHid.Owner, base.MicroHid);
			PlayerEvents.OnInspectingItem(e);
			if (e.IsAllowed)
			{
				SendRpc((NetworkWriter x) =>
				{
					x.WriteByte(3);
				});
				PlayerEvents.OnInspectedItem(new PlayerInspectedItemEventArgs(base.MicroHid.Owner, base.MicroHid));
			}
		}

		internal override void OnClientReady()
		{
			base.OnClientReady();
			PickupAnimSerials.Clear();
		}

		internal override void ServerOnPlayerConnected(ReferenceHub hub, bool firstSubcomponent)
		{
			base.ServerOnPlayerConnected(hub, firstSubcomponent);
			SendRpc(hub, (NetworkWriter x) =>
			{
				x.WriteByte(0);
				foreach (ushort pickupAnimSerial in PickupAnimSerials)
				{
					x.WriteUShort(pickupAnimSerial);
				}
			});
		}
	}
}
