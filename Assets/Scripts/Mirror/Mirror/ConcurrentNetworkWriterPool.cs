namespace Mirror
{
	public static class ConcurrentNetworkWriterPool
	{
		public const int InitialCapacity = 1000;

		private static readonly global::Mirror.ConcurrentPool<global::Mirror.ConcurrentNetworkWriterPooled> pool = new global::Mirror.ConcurrentPool<global::Mirror.ConcurrentNetworkWriterPooled>(() => new global::Mirror.ConcurrentNetworkWriterPooled(), 1000);

		public static int Count => pool.Count;

		public static global::Mirror.ConcurrentNetworkWriterPooled Get()
		{
			global::Mirror.ConcurrentNetworkWriterPooled concurrentNetworkWriterPooled = pool.Get();
			concurrentNetworkWriterPooled.Position = 0;
			return concurrentNetworkWriterPooled;
		}

		[global::System.Runtime.CompilerServices.MethodImpl(global::System.Runtime.CompilerServices.MethodImplOptions.AggressiveInlining)]
		public static void Return(global::Mirror.ConcurrentNetworkWriterPooled writer)
		{
			pool.Return(writer);
		}
	}
}
