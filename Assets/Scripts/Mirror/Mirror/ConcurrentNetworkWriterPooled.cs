namespace Mirror
{
	public class ConcurrentNetworkWriterPooled : global::Mirror.NetworkWriter, global::System.IDisposable
	{
		public void Dispose()
		{
			global::Mirror.ConcurrentNetworkWriterPool.Return(this);
		}
	}
}
