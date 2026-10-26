namespace Mirror
{
	public class Unbatcher
	{
		private readonly global::System.Collections.Generic.Queue<global::Mirror.NetworkWriterPooled> batches = new global::System.Collections.Generic.Queue<global::Mirror.NetworkWriterPooled>();

		private readonly global::Mirror.NetworkReader reader = new global::Mirror.NetworkReader(new byte[0]);

		private double readerRemoteTimeStamp;

		public int BatchesCount => batches.Count;

		private void StartReadingBatch(global::Mirror.NetworkWriterPooled batch)
		{
			reader.SetBuffer(batch.ToArraySegment());
			readerRemoteTimeStamp = reader.ReadDouble();
		}

		public bool AddBatch(global::System.ArraySegment<byte> batch)
		{
			if (batch.Count < 8)
			{
				return false;
			}
			global::Mirror.NetworkWriterPooled networkWriterPooled = global::Mirror.NetworkWriterPool.Get();
			networkWriterPooled.WriteBytes(batch.Array, batch.Offset, batch.Count);
			if (batches.Count == 0)
			{
				StartReadingBatch(networkWriterPooled);
			}
			batches.Enqueue(networkWriterPooled);
			return true;
		}

		public bool GetNextMessage(out global::System.ArraySegment<byte> message, out double remoteTimeStamp)
		{
			message = default;
			remoteTimeStamp = 0.0;
			if (batches.Count == 0)
			{
				return false;
			}
			if (reader.Capacity == 0)
			{
				return false;
			}
			if (reader.Remaining == 0)
			{
				global::Mirror.NetworkWriterPool.Return(batches.Dequeue());
				if (batches.Count <= 0)
				{
					return false;
				}
				global::Mirror.NetworkWriterPooled batch = batches.Peek();
				StartReadingBatch(batch);
			}
			remoteTimeStamp = readerRemoteTimeStamp;
			if (reader.Remaining == 0)
			{
				return false;
			}
			int num = (int)global::Mirror.Compression.DecompressVarUInt(reader);
			if (reader.Remaining < num)
			{
				return false;
			}
			message = reader.ReadBytesSegment(num);
			return true;
		}
	}
}
