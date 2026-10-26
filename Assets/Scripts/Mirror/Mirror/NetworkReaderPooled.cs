namespace Mirror
{
	public class NetworkReaderPooled : global::Mirror.NetworkReader, global::System.IDisposable
	{
		internal NetworkReaderPooled(byte[] bytes)
			: base(bytes)
		{
		}

		internal NetworkReaderPooled(global::System.ArraySegment<byte> segment)
			: base(segment)
		{
		}

		public void Dispose()
		{
			global::Mirror.NetworkReaderPool.Return(this);
		}
	}
}
