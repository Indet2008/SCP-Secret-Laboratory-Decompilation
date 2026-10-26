namespace Mirror
{
	public class NetworkReader
	{
		public global::System.ArraySegment<byte> buffer;

		public int Position;

		internal readonly global::System.Text.UTF8Encoding encoding = new global::System.Text.UTF8Encoding(encoderShouldEmitUTF8Identifier: false, throwOnInvalidBytes: true);

		public const int AllocationLimit = 16777216;

		public int Remaining => buffer.Count - Position;

		public int Capacity => buffer.Count;

		public NetworkReader(global::System.ArraySegment<byte> segment)
		{
			buffer = segment;
		}

		[global::System.Runtime.CompilerServices.MethodImpl(global::System.Runtime.CompilerServices.MethodImplOptions.AggressiveInlining)]
		public void SetBuffer(global::System.ArraySegment<byte> segment)
		{
			buffer = segment;
			Position = 0;
		}

		internal unsafe T ReadBlittable<T>() where T : unmanaged
		{
			int num = sizeof(T);
			if (Remaining < num)
			{
				throw new global::System.IO.EndOfStreamException($"ReadBlittable<{typeof(T)}> not enough data in buffer to read {num} bytes: {ToString()}");
			}
			T result;
			fixed (byte* ptr = &buffer.Array[buffer.Offset + Position])
			{
				result = *(T*)ptr;
			}
			Position += num;
			return result;
		}

		[global::System.Runtime.CompilerServices.MethodImpl(global::System.Runtime.CompilerServices.MethodImplOptions.AggressiveInlining)]
		internal T? ReadBlittableNullable<T>() where T : unmanaged
		{
			if (ReadByte() == 0)
			{
				return null;
			}
			return ReadBlittable<T>();
		}

		public byte ReadByte()
		{
			return ReadBlittable<byte>();
		}

		public byte[] ReadBytes(byte[] bytes, int count)
		{
			if (count < 0)
			{
				throw new global::System.ArgumentOutOfRangeException("ReadBytes requires count >= 0");
			}
			if (count > bytes.Length)
			{
				throw new global::System.IO.EndOfStreamException($"ReadBytes can't read {count} + bytes because the passed byte[] only has length {bytes.Length}");
			}
			if (Remaining < count)
			{
				throw new global::System.IO.EndOfStreamException($"ReadBytesSegment can't read {count} bytes because it would read past the end of the stream. {ToString()}");
			}
			global::System.Array.Copy(buffer.Array, buffer.Offset + Position, bytes, 0, count);
			Position += count;
			return bytes;
		}

		public global::System.ArraySegment<byte> ReadBytesSegment(int count)
		{
			if (count < 0)
			{
				throw new global::System.ArgumentOutOfRangeException("ReadBytesSegment requires count >= 0");
			}
			if (Remaining < count)
			{
				throw new global::System.IO.EndOfStreamException($"ReadBytesSegment can't read {count} bytes because it would read past the end of the stream. {ToString()}");
			}
			global::System.ArraySegment<byte> result = new global::System.ArraySegment<byte>(buffer.Array, buffer.Offset + Position, count);
			Position += count;
			return result;
		}

		public T Read<T>()
		{
			global::System.Func<global::Mirror.NetworkReader, T> read = global::Mirror.Reader<T>.read;
			if (read == null)
			{
				global::UnityEngine.Debug.LogError($"No reader found for {typeof(T)}. Use a type supported by Mirror or define a custom reader extension for {typeof(T)}.");
				return default;
			}
			return read(this);
		}

		public override string ToString()
		{
			return $"[{buffer.ToHexString()} @ {Position}/{Capacity}]";
		}
	}
}
