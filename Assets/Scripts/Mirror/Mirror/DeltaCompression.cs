namespace Mirror
{
	public static class DeltaCompression
	{
		[global::System.Runtime.CompilerServices.MethodImpl(global::System.Runtime.CompilerServices.MethodImplOptions.AggressiveInlining)]
		public static void Compress(global::Mirror.NetworkWriter writer, long last, long current)
		{
			global::Mirror.Compression.CompressVarInt(writer, current - last);
		}

		[global::System.Runtime.CompilerServices.MethodImpl(global::System.Runtime.CompilerServices.MethodImplOptions.AggressiveInlining)]
		public static long Decompress(global::Mirror.NetworkReader reader, long last)
		{
			return last + global::Mirror.Compression.DecompressVarInt(reader);
		}

		[global::System.Runtime.CompilerServices.MethodImpl(global::System.Runtime.CompilerServices.MethodImplOptions.AggressiveInlining)]
		public static void Compress(global::Mirror.NetworkWriter writer, global::Mirror.Vector3Long last, global::Mirror.Vector3Long current)
		{
			Compress(writer, last.x, current.x);
			Compress(writer, last.y, current.y);
			Compress(writer, last.z, current.z);
		}

		[global::System.Runtime.CompilerServices.MethodImpl(global::System.Runtime.CompilerServices.MethodImplOptions.AggressiveInlining)]
		public static global::Mirror.Vector3Long Decompress(global::Mirror.NetworkReader reader, global::Mirror.Vector3Long last)
		{
			long x = Decompress(reader, last.x);
			long y = Decompress(reader, last.y);
			long z = Decompress(reader, last.z);
			return new global::Mirror.Vector3Long(x, y, z);
		}
	}
}
