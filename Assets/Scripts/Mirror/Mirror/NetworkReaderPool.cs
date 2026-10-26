namespace Mirror
{
	public static class NetworkReaderPool
	{
		private static readonly global::Mirror.Pool<global::Mirror.NetworkReaderPooled> Pool = new global::Mirror.Pool<global::Mirror.NetworkReaderPooled>(() => new global::Mirror.NetworkReaderPooled(new byte[0]), 1000);

		public static global::Mirror.NetworkReaderPooled Get(byte[] bytes)
		{
			global::Mirror.NetworkReaderPooled networkReaderPooled = Pool.Get();
			networkReaderPooled.SetBuffer(bytes);
			return networkReaderPooled;
		}

		public static global::Mirror.NetworkReaderPooled Get(global::System.ArraySegment<byte> segment)
		{
			global::Mirror.NetworkReaderPooled networkReaderPooled = Pool.Get();
			networkReaderPooled.SetBuffer(segment);
			return networkReaderPooled;
		}

		[global::System.Runtime.CompilerServices.MethodImpl(global::System.Runtime.CompilerServices.MethodImplOptions.AggressiveInlining)]
		public static void Return(global::Mirror.NetworkReaderPooled reader)
		{
			Pool.Return(reader);
		}
	}
}
