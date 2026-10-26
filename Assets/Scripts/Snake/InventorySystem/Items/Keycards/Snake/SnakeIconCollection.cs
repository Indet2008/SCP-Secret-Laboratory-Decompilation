namespace InventorySystem.Items.Keycards.Snake
{
	[global::UnityEngine.CreateAssetMenu(fileName = "New Snake Icon Collection", menuName = "ScriptableObject/Items/Snake Icon Collection")]
	public class SnakeIconCollection : global::UnityEngine.ScriptableObject
	{
		[global::System.Serializable]
		private class IconDefinition
		{
			public global::InventorySystem.Items.Keycards.Snake.SnakeSegmentType Type;

			public global::InventorySystem.Items.Keycards.Snake.SnakeIconCollection.SegmentOrientation[] Orientations;

			public global::UnityEngine.Sprite Fallback;
		}

		[global::System.Serializable]
		private class SegmentOrientation
		{
			public global::UnityEngine.Vector2Int PreviousNeighbor;

			public global::UnityEngine.Vector2Int NextNeighbor;

			public global::UnityEngine.Sprite Sprite;

			public bool AllowInverting;
		}

		[global::UnityEngine.SerializeField]
		private global::InventorySystem.Items.Keycards.Snake.SnakeIconCollection.IconDefinition[] _icons;

		public global::UnityEngine.Sprite GetIcon(global::InventorySystem.Items.Keycards.Snake.SnakeSegmentType type, global::UnityEngine.Vector2Int prevPos, global::UnityEngine.Vector2Int nextPos)
		{
			if (!TryGetDefinition(type, out var ret))
			{
				return null;
			}
			global::InventorySystem.Items.Keycards.Snake.SnakeIconCollection.SegmentOrientation[] orientations = ret.Orientations;
			foreach (global::InventorySystem.Items.Keycards.Snake.SnakeIconCollection.SegmentOrientation segmentOrientation in orientations)
			{
				if (CheckNeighbors(segmentOrientation, prevPos, nextPos) || (segmentOrientation.AllowInverting && CheckNeighbors(segmentOrientation, nextPos, prevPos)))
				{
					return segmentOrientation.Sprite;
				}
			}
			return ret.Fallback;
		}

		private bool TryGetDefinition(global::InventorySystem.Items.Keycards.Snake.SnakeSegmentType type, out global::InventorySystem.Items.Keycards.Snake.SnakeIconCollection.IconDefinition ret)
		{
			global::InventorySystem.Items.Keycards.Snake.SnakeIconCollection.IconDefinition[] icons = _icons;
			foreach (global::InventorySystem.Items.Keycards.Snake.SnakeIconCollection.IconDefinition iconDefinition in icons)
			{
				if (type == iconDefinition.Type)
				{
					ret = iconDefinition;
					return true;
				}
			}
			ret = null;
			return false;
		}

		private static bool CheckNeighbors(global::InventorySystem.Items.Keycards.Snake.SnakeIconCollection.SegmentOrientation orientation, global::UnityEngine.Vector2Int prevPos, global::UnityEngine.Vector2Int nextPos)
		{
			if (orientation.PreviousNeighbor == prevPos)
			{
				return orientation.NextNeighbor == nextPos;
			}
			return false;
		}
	}
}
