using Mirror;

namespace Hints
{
	public abstract class NetworkObject<TData> : NetworkMessage
	{
		public abstract void Deserialize(NetworkReader reader);

		public abstract void Serialize(NetworkWriter writer);
	}
}
