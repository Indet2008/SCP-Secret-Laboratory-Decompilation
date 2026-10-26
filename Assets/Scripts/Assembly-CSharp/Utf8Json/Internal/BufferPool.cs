namespace Utf8Json.Internal
{
	internal sealed class BufferPool : ArrayPool<byte>
	{
		public static readonly BufferPool Default = new BufferPool(65535);

		public BufferPool(int bufferLength)
			: base(bufferLength)
		{
		}
	}
}
