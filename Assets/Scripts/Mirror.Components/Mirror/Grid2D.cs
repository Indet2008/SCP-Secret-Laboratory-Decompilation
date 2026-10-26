namespace Mirror
{
	public struct Grid2D<T>
	{
		private readonly global::System.Collections.Generic.Dictionary<global::UnityEngine.Vector2Int, global::System.Collections.Generic.HashSet<T>> grid;

		private readonly global::UnityEngine.Vector2Int[] neighbourOffsets;

		public Grid2D(int initialCapacity)
		{
			grid = new global::System.Collections.Generic.Dictionary<global::UnityEngine.Vector2Int, global::System.Collections.Generic.HashSet<T>>(initialCapacity);
			neighbourOffsets = new global::UnityEngine.Vector2Int[9]
			{
				global::UnityEngine.Vector2Int.up,
				global::UnityEngine.Vector2Int.up + global::UnityEngine.Vector2Int.left,
				global::UnityEngine.Vector2Int.up + global::UnityEngine.Vector2Int.right,
				global::UnityEngine.Vector2Int.left,
				global::UnityEngine.Vector2Int.zero,
				global::UnityEngine.Vector2Int.right,
				global::UnityEngine.Vector2Int.down,
				global::UnityEngine.Vector2Int.down + global::UnityEngine.Vector2Int.left,
				global::UnityEngine.Vector2Int.down + global::UnityEngine.Vector2Int.right
			};
		}

		public void Add(global::UnityEngine.Vector2Int position, T value)
		{
			if (!grid.TryGetValue(position, out var value2))
			{
				value2 = new global::System.Collections.Generic.HashSet<T>(128);
				grid[position] = value2;
			}
			value2.Add(value);
		}

		private void GetAt(global::UnityEngine.Vector2Int position, global::System.Collections.Generic.HashSet<T> result)
		{
			if (!grid.TryGetValue(position, out var value))
			{
				return;
			}
			foreach (T item in value)
			{
				result.Add(item);
			}
		}

		public void GetWithNeighbours(global::UnityEngine.Vector2Int position, global::System.Collections.Generic.HashSet<T> result)
		{
			result.Clear();
			global::UnityEngine.Vector2Int[] array = neighbourOffsets;
			foreach (global::UnityEngine.Vector2Int vector2Int in array)
			{
				GetAt(position + vector2Int, result);
			}
		}

		public void ClearNonAlloc()
		{
			foreach (global::System.Collections.Generic.HashSet<T> value in grid.Values)
			{
				value.Clear();
			}
		}
	}
}
