namespace Mirror
{
	public class Batcher
	{
		private readonly int threshold;

		public const int TimestampSize = 8;

		private readonly global::System.Collections.Generic.Queue<global::Mirror.NetworkWriterPooled> batches = new global::System.Collections.Generic.Queue<global::Mirror.NetworkWriterPooled>();

		private global::Mirror.NetworkWriterPooled batch;

		public static int MessageHeaderSize(int messageSize)
		{
			return global::Mirror.Compression.VarUIntSize((ulong)messageSize);
		}

		public static int MaxMessageOverhead(int messageSize)
		{
			return 8 + MessageHeaderSize(messageSize);
		}

		public Batcher(int threshold)
		{
			this.threshold = threshold;
		}

		public void AddMessage(global::System.ArraySegment<byte> message, double timeStamp)
		{
			int num = global::Mirror.Compression.VarUIntSize((ulong)message.Count) + message.Count;
			if (batch != null && batch.Position + num > threshold)
			{
				batches.Enqueue(batch);
				batch = null;
			}
			if (batch == null)
			{
				batch = global::Mirror.NetworkWriterPool.Get();
				batch.WriteDouble(timeStamp);
			}
			global::Mirror.Compression.CompressVarUInt(batch, (ulong)message.Count);
			batch.WriteBytes(message.Array, message.Offset, message.Count);
		}

		private static void CopyAndReturn(global::Mirror.NetworkWriterPooled batch, global::Mirror.NetworkWriter writer)
		{
			if (writer.Position != 0)
			{
				throw new global::System.ArgumentException("GetBatch needs a fresh writer!");
			}
			global::System.ArraySegment<byte> arraySegment = batch.ToArraySegment();
			writer.WriteBytes(arraySegment.Array, arraySegment.Offset, arraySegment.Count);
			global::Mirror.NetworkWriterPool.Return(batch);
		}

		public bool GetBatch(global::Mirror.NetworkWriter writer)
		{
			if (batches.TryDequeue(out var result))
			{
				CopyAndReturn(result, writer);
				return true;
			}
			if (batch != null)
			{
				CopyAndReturn(batch, writer);
				batch = null;
				return true;
			}
			return false;
		}
	}
}
