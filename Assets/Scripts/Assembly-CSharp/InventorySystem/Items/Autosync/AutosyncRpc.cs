using System;
using Mirror;
using Utils.Networking;

namespace InventorySystem.Items.Autosync
{
	public class AutosyncRpc : AutosyncWriterBase
	{
		private enum Mode
		{
			SpecificClient = 0,
			AllClients = 1,
			Conditional = 2
		}

		private readonly Mode _mode;

		private readonly Func<ReferenceHub, bool> _predicate;

		private readonly NetworkConnection _specificReceiver;

		public AutosyncRpc(ItemIdentifier item, out NetworkWriter writer)
			: base(item, out writer)
		{
			_mode = Mode.AllClients;
		}

		public AutosyncRpc(ItemIdentifier item, Func<ReferenceHub, bool> predicate, out NetworkWriter writer)
			: base(item, out writer)
		{
			_mode = Mode.Conditional;
			_predicate = predicate;
		}

		public AutosyncRpc(ItemIdentifier item, ReferenceHub specificHub, out NetworkWriter writer)
			: base(item, out writer)
		{
			_mode = Mode.SpecificClient;
			_specificReceiver = specificHub.connectionToClient;
		}

		public AutosyncRpc(ItemIdentifier item)
			: this(item, out var _)
		{
		}

		public AutosyncRpc(ItemIdentifier item, ReferenceHub receiver)
			: this(item, receiver, out var _)
		{
		}

		public AutosyncRpc(ItemIdentifier item, Func<ReferenceHub, bool> predicate)
			: this(item, predicate, out var _)
		{
		}

		protected override void HandleSending(AutosyncMessage msg)
		{
			if (NetworkServer.active)
			{
				switch (_mode)
				{
				case Mode.SpecificClient:
					_specificReceiver.Send(msg);
					break;
				case Mode.AllClients:
					NetworkServer.SendToReady(msg);
					break;
				case Mode.Conditional:
					msg.SendToHubsConditionally(_predicate);
					break;
				}
			}
		}
	}
}
