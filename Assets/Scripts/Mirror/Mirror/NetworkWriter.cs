namespace Mirror
{
	public class NetworkWriter
	{
		public const ushort MaxStringLength = 65534;

		public const int DefaultCapacity = 1500;

		public byte[] buffer = new byte[1500];

		public int Position;

		internal readonly global::System.Text.UTF8Encoding encoding = new global::System.Text.UTF8Encoding(encoderShouldEmitUTF8Identifier: false, throwOnInvalidBytes: true);

		public int Capacity => buffer.Length;

		[global::System.Runtime.CompilerServices.MethodImpl(global::System.Runtime.CompilerServices.MethodImplOptions.AggressiveInlining)]
		public void Reset()
		{
			Position = 0;
		}

		[global::System.Runtime.CompilerServices.MethodImpl(global::System.Runtime.CompilerServices.MethodImplOptions.AggressiveInlining)]
		public void EnsureLength(int value)
		{
			EnsureCapacity(Position + value);
		}

		[global::System.Runtime.CompilerServices.MethodImpl(global::System.Runtime.CompilerServices.MethodImplOptions.AggressiveInlining)]
		internal void EnsureCapacity(int value)
		{
			if (buffer.Length < value)
			{
				int newSize = global::System.Math.Max(value, buffer.Length * 2);
				global::System.Array.Resize(ref buffer, newSize);
			}
		}

		public byte[] ToArray()
		{
			byte[] array = new byte[Position];
			global::System.Array.ConstrainedCopy(buffer, 0, array, 0, Position);
			return array;
		}

		[global::System.Runtime.CompilerServices.MethodImpl(global::System.Runtime.CompilerServices.MethodImplOptions.AggressiveInlining)]
		public global::System.ArraySegment<byte> ToArraySegment()
		{
			return new global::System.ArraySegment<byte>(buffer, 0, Position);
		}

		[global::System.Runtime.CompilerServices.MethodImpl(global::System.Runtime.CompilerServices.MethodImplOptions.AggressiveInlining)]
		public static implicit operator global::System.ArraySegment<byte>(global::Mirror.NetworkWriter w)
		{
			return w.ToArraySegment();
		}

		internal unsafe void WriteBlittable<T>(T value) where T : unmanaged
		{
			int num = sizeof(T);
			EnsureCapacity(Position + num);
			fixed (byte* ptr = &buffer[Position])
			{
				*(T*)ptr = value;
			}
			Position += num;
		}

		[global::System.Runtime.CompilerServices.MethodImpl(global::System.Runtime.CompilerServices.MethodImplOptions.AggressiveInlining)]
		internal void WriteBlittableNullable<T>(T? value) where T : unmanaged
		{
			WriteByte((byte)(value.HasValue ? 1u : 0u));
			if (value.HasValue)
			{
				WriteBlittable(value.Value);
			}
		}

		public void WriteByte(byte value)
		{
			WriteBlittable(value);
		}

		public void WriteBytes(byte[] array, int offset, int count)
		{
			EnsureCapacity(Position + count);
			global::System.Array.ConstrainedCopy(array, offset, buffer, Position, count);
			Position += count;
		}

		public unsafe bool WriteBytes(byte* ptr, int offset, int size)
		{
			EnsureCapacity(Position + size);
			fixed (byte* destination = &buffer[Position])
			{
				global::Unity.Collections.LowLevel.Unsafe.UnsafeUtility.MemCpy(destination, ptr + offset, size);
			}
			Position += size;
			return true;
		}

		public void Write<T>(T value)
		{
			global::System.Action<global::Mirror.NetworkWriter, T> write = global::Mirror.Writer<T>.write;
			if (write == null)
			{
				global::UnityEngine.Debug.LogError($"No writer found for {typeof(T)}. This happens either if you are missing a NetworkWriter extension for your custom type, or if weaving failed. Try to reimport a script to weave again.");
			}
			else
			{
				write(this, value);
			}
		}

		public override string ToString()
		{
			return $"[{ToArraySegment().ToHexString()} @ {Position}/{Capacity}]";
		}
	}
}
