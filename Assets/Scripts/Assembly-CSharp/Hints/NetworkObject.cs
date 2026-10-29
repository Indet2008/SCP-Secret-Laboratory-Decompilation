using System;
using Mirror;

namespace Hints
{
	public abstract class NetworkObject<TData> : NetworkMessage, IDisposable
	{
		protected TData Data { get; private set; }

		public bool Awoken { get; private set; }

		public abstract void Deserialize(NetworkReader reader);

		public abstract void Serialize(NetworkWriter writer);

		public void Awake(TData data)
		{
			if (Awoken)
			{
				throw new InvalidOperationException("Hint has already been awoken.");
			}
			Data = data;
			Start();
			Awoken = true;
		}

		protected virtual void Start()
		{
		}

		protected virtual void Destroy()
		{
		}

		public void Dispose()
		{
			Destroy();
			Awoken = false;
		}
	}
}
