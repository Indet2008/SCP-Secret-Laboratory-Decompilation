namespace Mirror
{
	public static class NetworkWriterPool
	{
		private static readonly global::Mirror.Pool<global::Mirror.NetworkWriterPooled> Pool = new global::Mirror.Pool<global::Mirror.NetworkWriterPooled>(() => new global::Mirror.NetworkWriterPooled(), 1000);

		public static global::Mirror.NetworkWriterPooled Get()
		{
			global::Mirror.NetworkWriterPooled networkWriterPooled = Pool.Get();
			networkWriterPooled.Reset();
			return networkWriterPooled;
		}

		[global::System.Runtime.CompilerServices.MethodImpl(global::System.Runtime.CompilerServices.MethodImplOptions.AggressiveInlining)]
		public static void Return(global::Mirror.NetworkWriterPooled writer)
		{
			Pool.Return(writer);
		}
	}
}
