using System;
using System.Collections.Generic;
using Mirror;

namespace InventorySystem.Items.MicroHID.Modules
{
	public class CycleSyncModule : MicroHidModuleBase
	{
		private class SyncedCycleController
		{
			public readonly CycleController Controller;

			public MicroHidPhase? LastSentPhase;

			public bool NeedsResync => LastSentPhase != Controller.Phase;

			public SyncedCycleController(ushort serial)
			{
				Controller = new CycleController(serial);
				LastSentPhase = null;
			}

			public void WriteSelf(NetworkWriter writer)
			{
				writer.WriteUShort(Controller.Serial);
				writer.WriteByte((byte)Controller.Phase);
				if (Controller.Phase != MicroHidPhase.Standby)
				{
					writer.WriteByte((byte)Controller.LastFiringMode);
				}
			}
		}

		private static readonly List<SyncedCycleController> SyncControllers = new List<SyncedCycleController>();

		private CycleController _instCycleController;

		public static CycleController GetCycleController(ushort serial)
		{
			foreach (SyncedCycleController syncController in SyncControllers)
			{
				if (syncController.Controller.Serial == serial)
				{
					return syncController.Controller;
				}
			}
			SyncedCycleController syncedCycleController = new SyncedCycleController(serial);
			SyncControllers.Add(syncedCycleController);
			return syncedCycleController.Controller;
		}

		public static MicroHidPhase GetPhase(ushort serial)
		{
			return GetCycleController(serial).Phase;
		}

		public static MicroHidFiringMode GetFiringMode(ushort serial)
		{
			return GetCycleController(serial).LastFiringMode;
		}

		public static void ForEachController(Action<CycleController> action)
		{
			foreach (SyncedCycleController syncController in SyncControllers)
			{
				action(syncController.Controller);
			}
		}

		internal override void OnClientReady()
		{
			base.OnClientReady();
			SyncControllers.Clear();
		}

		internal override void TemplateUpdate()
		{
			base.TemplateUpdate();
			if (!NetworkServer.active)
			{
				return;
			}
			foreach (SyncedCycleController syncController in SyncControllers)
			{
				if (syncController.NeedsResync)
				{
					SendRpc(ServerWriteAllDelta);
					break;
				}
			}
		}

		internal override void ServerOnPlayerConnected(ReferenceHub hub, bool firstSubcomponent)
		{
			base.ServerOnPlayerConnected(hub, firstSubcomponent);
			SendRpc(hub, ServerWriteAllActive);
		}

		public override void ClientProcessRpcTemplate(NetworkReader reader, ushort serial)
		{
			base.ClientProcessRpcTemplate(reader, serial);
			if (NetworkServer.active)
			{
				return;
			}
			while (reader.Remaining > 0)
			{
				CycleController cycleController = GetCycleController(reader.ReadUShort());
				cycleController.Phase = (MicroHidPhase)reader.ReadByte();
				if (cycleController.Phase != MicroHidPhase.Standby)
				{
					cycleController.LastFiringMode = (MicroHidFiringMode)reader.ReadByte();
				}
			}
		}

		private void Update()
		{
			if (base.IsServer)
			{
				if (_instCycleController == null)
				{
					_instCycleController = GetCycleController(base.ItemSerial);
				}
				_instCycleController.ServerUpdateHeldItem(base.MicroHid);
			}
		}

		private void ServerWriteAllDelta(NetworkWriter writer)
		{
			foreach (SyncedCycleController syncController in SyncControllers)
			{
				if (syncController.NeedsResync)
				{
					syncController.WriteSelf(writer);
					syncController.LastSentPhase = syncController.Controller.Phase;
				}
			}
		}

		private void ServerWriteAllActive(NetworkWriter writer)
		{
			foreach (SyncedCycleController syncController in SyncControllers)
			{
				if (syncController.Controller.Phase != MicroHidPhase.Standby)
				{
					syncController.WriteSelf(writer);
				}
			}
		}
	}
}
