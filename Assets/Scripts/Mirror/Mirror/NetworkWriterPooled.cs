namespace Mirror
{
	public class NetworkWriterPooled : global::Mirror.NetworkWriter, global::System.IDisposable
	{
		public void Dispose()
		{
			global::Mirror.NetworkWriterPool.Return(this);
		}
	}
}
