namespace InventorySystem.Items.Keycards.Snake
{
	public class SnakeDisplay : global::UnityEngine.MonoBehaviour
	{
		private const float GameOverBlinkFrequency = 3f;

		private readonly global::System.Collections.Generic.List<global::InventorySystem.Items.Keycards.Snake.SnakeSegment> _allSegments = new global::System.Collections.Generic.List<global::InventorySystem.Items.Keycards.Snake.SnakeSegment>();

		private readonly global::System.Collections.Generic.List<global::UnityEngine.Vector2Int> _eatenPositions = new global::System.Collections.Generic.List<global::UnityEngine.Vector2Int>();

		private int _activeSegmentsCnt;

		private global::UnityEngine.Vector2Int? _lastFoodPos;

		private float? _gameoverTime;

		[field: global::UnityEngine.SerializeField]
		public global::InventorySystem.Items.Keycards.Snake.SnakeIconCollection IconCollection { get; private set; }

		[field: global::UnityEngine.SerializeField]
		public global::UnityEngine.Vector2Int AreaSize { get; private set; }

		[field: global::UnityEngine.SerializeField]
		public global::UnityEngine.UI.Image SegmentTemplate { get; private set; }

		[field: global::UnityEngine.SerializeField]
		public global::UnityEngine.UI.Image FoodIcon { get; private set; }

		[field: global::UnityEngine.SerializeField]
		public int DistanceOpenMouth { get; private set; }

		[field: global::UnityEngine.SerializeField]
		public global::TMPro.TMP_Text ScoreText { get; private set; }

		[field: global::UnityEngine.SerializeField]
		public string ScoreFormat { get; private set; }

		public void SetDisplay(global::System.Collections.Generic.List<global::UnityEngine.Vector2Int> positions, global::UnityEngine.Vector2Int nextMove, global::UnityEngine.Vector2Int? nextFood, int score, bool gameover)
		{
			if (nextFood.HasValue)
			{
				if (nextFood != _lastFoodPos)
				{
					_eatenPositions.Add(nextFood.Value);
				}
				FoodIcon.enabled = true;
				global::UnityEngine.RectTransform rectTransform = FoodIcon.rectTransform;
				rectTransform.anchoredPosition = nextFood.Value * rectTransform.sizeDelta;
			}
			else
			{
				FoodIcon.enabled = false;
			}
			_lastFoodPos = nextFood;
			ScoreText.text = score.ToString(ScoreFormat);
			if (_gameoverTime.HasValue != gameover)
			{
				if (gameover)
				{
					_gameoverTime = global::UnityEngine.Time.time;
				}
				else
				{
					_gameoverTime = null;
					_eatenPositions.Clear();
				}
			}
			RenderAll(positions, nextMove);
		}

		private void RenderAll(global::System.Collections.Generic.List<global::UnityEngine.Vector2Int> positions, global::UnityEngine.Vector2Int moveDir)
		{
			DeactivateAllSegments();
			if (positions.Count < 2)
			{
				global::UnityEngine.Debug.LogError("Rendering failed: Snake needs to be at least 2 elements long.");
				return;
			}
			RenderHead(positions, moveDir);
			RenderMiddle(positions);
			RenderTail(positions);
		}

		private void RenderHead(global::System.Collections.Generic.List<global::UnityEngine.Vector2Int> positions, global::UnityEngine.Vector2Int moveDir)
		{
			global::UnityEngine.Vector2Int vector2Int = positions[0];
			global::InventorySystem.Items.Keycards.Snake.SnakeSegmentType type = global::InventorySystem.Items.Keycards.Snake.SnakeSegmentType.HeadRegular;
			for (int i = 0; i < DistanceOpenMouth; i++)
			{
				global::UnityEngine.Vector2Int value = vector2Int + moveDir * i;
				global::UnityEngine.Vector2Int? lastFoodPos = _lastFoodPos;
				if (!(value != lastFoodPos))
				{
					type = global::InventorySystem.Items.Keycards.Snake.SnakeSegmentType.HeadOpen;
					break;
				}
			}
			global::UnityEngine.Vector2Int relativeNeighbor = GetRelativeNeighbor(vector2Int, positions[1]);
			SetNewSegment(type, vector2Int, null, relativeNeighbor);
		}

		private void RenderMiddle(global::System.Collections.Generic.List<global::UnityEngine.Vector2Int> positions)
		{
			for (int i = 1; i < positions.Count - 1; i++)
			{
				global::UnityEngine.Vector2Int vector2Int = positions[i];
				global::InventorySystem.Items.Keycards.Snake.SnakeSegmentType type = (_eatenPositions.Contains(vector2Int) ? global::InventorySystem.Items.Keycards.Snake.SnakeSegmentType.MiddleEaten : global::InventorySystem.Items.Keycards.Snake.SnakeSegmentType.MiddleRegular);
				global::UnityEngine.Vector2Int relativeNeighbor = GetRelativeNeighbor(vector2Int, positions[i - 1]);
				global::UnityEngine.Vector2Int relativeNeighbor2 = GetRelativeNeighbor(vector2Int, positions[i + 1]);
				SetNewSegment(type, vector2Int, relativeNeighbor, relativeNeighbor2);
			}
		}

		private void RenderTail(global::System.Collections.Generic.List<global::UnityEngine.Vector2Int> positions)
		{
			global::UnityEngine.Vector2Int vector2Int = positions[positions.Count - 1];
			global::UnityEngine.Vector2Int relativeNeighbor = GetRelativeNeighbor(vector2Int, positions[positions.Count - 2]);
			_eatenPositions.Remove(vector2Int);
			SetNewSegment(global::InventorySystem.Items.Keycards.Snake.SnakeSegmentType.Tail, vector2Int, relativeNeighbor, null);
		}

		private void Update()
		{
			if (_gameoverTime.HasValue)
			{
				bool flag = (int)((global::UnityEngine.Time.time - _gameoverTime.Value) * 3f) % 2 == 0;
				for (int i = 0; i < _activeSegmentsCnt; i++)
				{
					_allSegments[i].SetActive(!flag);
				}
			}
		}

		private void DeactivateAllSegments()
		{
			for (int i = 0; i < _activeSegmentsCnt; i++)
			{
				_allSegments[i].SetActive(val: false);
			}
			_activeSegmentsCnt = 0;
		}

		private void SetNewSegment(global::InventorySystem.Items.Keycards.Snake.SnakeSegmentType type, global::UnityEngine.Vector2Int pos, global::UnityEngine.Vector2Int? prevPos, global::UnityEngine.Vector2Int? nextPos)
		{
			global::InventorySystem.Items.Keycards.Snake.SnakeSegment snakeSegment;
			if (_activeSegmentsCnt >= _allSegments.Count)
			{
				snakeSegment = new global::InventorySystem.Items.Keycards.Snake.SnakeSegment(SegmentTemplate, IconCollection);
				_allSegments.Add(snakeSegment);
			}
			else
			{
				snakeSegment = _allSegments[_activeSegmentsCnt];
			}
			_activeSegmentsCnt++;
			snakeSegment.SetActive(val: true);
			snakeSegment.SetVisuals(type, pos, prevPos, nextPos);
		}

		private static global::UnityEngine.Vector2Int GetRelativeNeighbor(global::UnityEngine.Vector2Int ours, global::UnityEngine.Vector2Int neighbor)
		{
			global::UnityEngine.Vector2Int vector2Int = ours - neighbor;
			if (vector2Int.sqrMagnitude == 1)
			{
				return neighbor;
			}
			if (vector2Int.x == 0)
			{
				return new global::UnityEngine.Vector2Int(ours.x, ours.y + (int)global::UnityEngine.Mathf.Sign(vector2Int.y));
			}
			if (vector2Int.y == 0)
			{
				return new global::UnityEngine.Vector2Int(ours.x + (int)global::UnityEngine.Mathf.Sign(vector2Int.x), ours.y);
			}
			global::UnityEngine.Debug.LogError($"{neighbor} is not a valid neighbor to {ours}. The snake will appear detached.");
			return neighbor;
		}
	}
}
