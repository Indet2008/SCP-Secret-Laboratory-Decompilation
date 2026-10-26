namespace Mirror
{
	public struct NetworkBehaviourSyncVar : global::System.IEquatable<global::Mirror.NetworkBehaviourSyncVar>
	{
		public uint netId;

		public byte componentIndex;

		public NetworkBehaviourSyncVar(uint netId, int componentIndex)
		{
			this = default;
			this.netId = netId;
			this.componentIndex = (byte)componentIndex;
		}

		public bool Equals(global::Mirror.NetworkBehaviourSyncVar other)
		{
			if (other.netId == netId)
			{
				return other.componentIndex == componentIndex;
			}
			return false;
		}

		public bool Equals(uint netId, int componentIndex)
		{
			if (this.netId == netId)
			{
				return this.componentIndex == componentIndex;
			}
			return false;
		}

		public override string ToString()
		{
			return $"[netId:{netId} compIndex:{componentIndex}]";
		}
	}
}
