using System;
using Mirror;

namespace InventorySystem.Items.MicroHID.Modules
{
	public class InputSyncModule : MicroHidModuleBase
	{
		[Flags]
		private enum SyncData : byte
		{
			None = 0,
			Primary = 1,
			Secondary = 2
		}

		private SyncData? _lastSent;

		private SyncData _lastReceived;

		public bool Primary
		{
			get
			{
				if (!base.Item.PrimaryActionBlocked)
				{
					return (_lastReceived & SyncData.Primary) != 0;
				}
				return false;
			}
		}

		public bool Secondary
		{
			get
			{
				if (!base.Item.PrimaryActionBlocked)
				{
					return (_lastReceived & SyncData.Secondary) != 0;
				}
				return false;
			}
		}

		public override void ServerProcessCmd(NetworkReader reader)
		{
			base.ServerProcessCmd(reader);
			_lastReceived = (SyncData)reader.ReadByte();
		}

		internal override void OnHolstered()
		{
			base.OnHolstered();
			_lastSent = null;
			_lastReceived = SyncData.None;
		}

		internal override void EquipUpdate()
		{
			base.EquipUpdate();
			if (base.IsControllable)
			{
				SyncData syncData = SyncData.None;
				if (GetAction(ActionName.Shoot))
				{
					syncData |= SyncData.Primary;
				}
				if (GetAction(ActionName.Zoom))
				{
					syncData |= SyncData.Secondary;
				}
				if (syncData != _lastSent)
				{
					_lastSent = syncData;
					SendCmd(SerializeCmd);
				}
			}
		}

		private void SerializeCmd(NetworkWriter writer)
		{
			writer.WriteByte((byte)_lastSent.Value);
		}
	}
}
