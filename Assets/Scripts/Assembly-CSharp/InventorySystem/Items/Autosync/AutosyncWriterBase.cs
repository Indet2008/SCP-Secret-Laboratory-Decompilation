using System;
using Mirror;

namespace InventorySystem.Items.Autosync
{
	public abstract class AutosyncWriterBase : IDisposable
	{
		private readonly NetworkWriterPooled _writer;

		private readonly ItemIdentifier _targetItem;

		private bool _alreadySent;

		public AutosyncWriterBase(ItemIdentifier item, out NetworkWriter writer)
		{
			_alreadySent = false;
			_writer = NetworkWriterPool.Get();
			_targetItem = item;
			writer = _writer;
		}

		public void Dispose()
		{
			Send();
		}

		public void Send()
		{
			if (!_alreadySent)
			{
				_alreadySent = true;
				HandleSending(new AutosyncMessage(_writer, _targetItem));
				_writer.Dispose();
			}
		}

		protected abstract void HandleSending(AutosyncMessage msg);

		public static implicit operator NetworkWriter(AutosyncWriterBase mask)
		{
			return mask._writer;
		}
	}
}
