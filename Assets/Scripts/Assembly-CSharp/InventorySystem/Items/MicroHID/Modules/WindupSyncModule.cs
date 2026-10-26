using System;
using System.Collections.Generic;
using InventorySystem.Items.Autosync;
using Mirror;
using UnityEngine;

namespace InventorySystem.Items.MicroHID.Modules
{
	public class WindupSyncModule : MicroHidModuleBase
	{
		private static readonly Dictionary<ushort, byte> ReceivedData = new Dictionary<ushort, byte>();

		private readonly Action<CycleController> _serverUpdateController;

		public WindupSyncModule()
		{
			_serverUpdateController = ServerUpdateController;
		}

		private void ServerUpdateController(CycleController cycle)
		{
			byte b = (byte)Mathf.RoundToInt(cycle.ServerWindUpProgress * 255f);
			if (ReceivedData.TryGetValue(cycle.Serial, out var value) && value == b)
			{
				return;
			}
			NetworkWriter writer;
			using (new AutosyncRpc(new ItemIdentifier(base.ItemId.TypeId, cycle.Serial), out writer))
			{
				writer.WriteByte(base.SyncId);
				writer.WriteByte(b);
			}
		}

		internal override void OnClientReady()
		{
			base.OnClientReady();
			ReceivedData.Clear();
		}

		internal override void TemplateUpdate()
		{
			base.TemplateUpdate();
			if (NetworkServer.active)
			{
				CycleSyncModule.ForEachController(_serverUpdateController);
			}
		}

		public override void ClientProcessRpcTemplate(NetworkReader reader, ushort serial)
		{
			base.ClientProcessRpcTemplate(reader, serial);
			ReceivedData[serial] = reader.ReadByte();
		}

		public static float GetProgress(ushort serial)
		{
			return (float)(int)ReceivedData.GetValueOrDefault(serial) * (1f / 255f);
		}
	}
}
