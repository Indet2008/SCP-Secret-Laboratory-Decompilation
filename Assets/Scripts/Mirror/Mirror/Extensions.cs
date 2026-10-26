namespace Mirror
{
	public static class Extensions
	{
		public static string ToHexString(this global::System.ArraySegment<byte> segment)
		{
			return global::System.BitConverter.ToString(segment.Array, segment.Offset, segment.Count);
		}

		public static int GetStableHashCode(this string text)
		{
			int num = 23;
			foreach (char c in text)
			{
				num = num * 31 + c;
			}
			return num;
		}

		internal static string GetMethodName(this global::System.Delegate func)
		{
			return func.Method.Name;
		}

		[global::System.Runtime.CompilerServices.MethodImpl(global::System.Runtime.CompilerServices.MethodImplOptions.AggressiveInlining)]
		public static void CopyTo<T>(this global::System.Collections.Generic.IEnumerable<T> source, global::System.Collections.Generic.List<T> destination)
		{
			destination.AddRange(source);
		}

		public static bool TryDequeue<T>(this global::System.Collections.Generic.Queue<T> source, out T element)
		{
			if (source.Count > 0)
			{
				element = source.Dequeue();
				return true;
			}
			element = default;
			return false;
		}

		public static void Clear<T>(this global::System.Collections.Concurrent.ConcurrentQueue<T> source)
		{
			int count = source.Count;
			for (int i = 0; i < count; i++)
			{
				source.TryDequeue(out var _);
			}
		}
	}
}
