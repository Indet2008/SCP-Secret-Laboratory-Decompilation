namespace InventorySystem.Items.Keycards.Snake
{
	public class SnakeSegment
	{
		private readonly global::UnityEngine.UI.Image _img;

		private readonly global::InventorySystem.Items.Keycards.Snake.SnakeIconCollection _icons;

		private global::UnityEngine.Vector2Int _position;

		public global::InventorySystem.Items.Keycards.Snake.SnakeSegmentType Type { get; private set; }

		public global::UnityEngine.Vector2Int Position
		{
			get
			{
				return _position;
			}
			private set
			{
				if (!(_position == value))
				{
					global::UnityEngine.RectTransform rectTransform = _img.rectTransform;
					_position = value;
					rectTransform.anchoredPosition = value * rectTransform.sizeDelta;
				}
			}
		}

		public void SetActive(bool val)
		{
			_img.gameObject.SetActive(val);
		}

		public void SetVisuals(global::InventorySystem.Items.Keycards.Snake.SnakeSegmentType type, global::UnityEngine.Vector2Int position, global::UnityEngine.Vector2Int? prevPos, global::UnityEngine.Vector2Int? nextPos)
		{
			Type = type;
			Position = position;
			global::UnityEngine.Vector2Int prevPos2 = (prevPos ?? position) - position;
			global::UnityEngine.Vector2Int nextPos2 = (nextPos ?? position) - position;
			_img.sprite = _icons.GetIcon(type, prevPos2, nextPos2);
		}

		public SnakeSegment(global::UnityEngine.UI.Image template, global::InventorySystem.Items.Keycards.Snake.SnakeIconCollection icons)
		{
			_img = global::UnityEngine.Object.Instantiate(template, template.rectTransform.parent);
			_icons = icons;
		}
	}
}
