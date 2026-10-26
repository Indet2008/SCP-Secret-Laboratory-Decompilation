namespace Mirror
{
	public static class NetworkMessageId<T> where T : struct, global::Mirror.NetworkMessage
	{
		public static readonly ushort Id = (ushort)typeof(T).FullName.GetStableHashCode();
	}
}
