namespace InventorySystem.Items.Keycards.Snake
{
	public class SnakeEngine
	{
		private static readonly global::UnityEngine.Vector2Int StartMoveDir = global::UnityEngine.Vector2Int.right;

		private static readonly global::System.Random Rng = new global::System.Random();

		private const int MaxInputs = 3;

		private readonly global::UnityEngine.Vector2Int _startPos;

		private readonly global::UnityEngine.Vector2Int _areaSize;

		private readonly int _startLength;

		private readonly byte _maxLength;

		private readonly float _minGameoverTime;

		private readonly global::System.Collections.Generic.List<global::UnityEngine.Vector2Int> _segments;

		private readonly global::System.Collections.Generic.Queue<global::UnityEngine.Vector2Int> _inputQueue;

		private readonly global::System.Diagnostics.Stopwatch _gameoverSw;

		private readonly global::System.Action<global::InventorySystem.Items.Keycards.Snake.SnakeNetworkMessage> _deltaSender;

		private global::UnityEngine.Vector2Int _curMovDir;

		private global::UnityEngine.Vector2Int? _foodPosition;

		private bool _displayDirty;

		public int CurLength => _segments.Count;

		public int Score { get; private set; }

		public SnakeEngine(global::UnityEngine.Vector2Int startPosition, int startLength, byte maxLength, global::UnityEngine.Vector2Int areaSize, float minGameoverTime, global::System.Action<global::InventorySystem.Items.Keycards.Snake.SnakeNetworkMessage> deltaSender)
		{
			_startPos = startPosition;
			_startLength = startLength;
			_maxLength = maxLength;
			_areaSize = areaSize;
			_minGameoverTime = minGameoverTime;
			_deltaSender = deltaSender;
			_segments = new global::System.Collections.Generic.List<global::UnityEngine.Vector2Int>();
			_inputQueue = new global::System.Collections.Generic.Queue<global::UnityEngine.Vector2Int>();
			_gameoverSw = new global::System.Diagnostics.Stopwatch();
			ResetSnake();
		}

		private void ResetSnake(bool fromNetworkMessage = false)
		{
			_segments.Clear();
			for (int i = 1; i <= _startLength; i++)
			{
				_segments.Add(_startPos - StartMoveDir * i);
			}
			Score = 0;
			_curMovDir = StartMoveDir;
			_gameoverSw.Reset();
			_foodPosition = (fromNetworkMessage ? ((global::UnityEngine.Vector2Int?)null) : GetNextFoodPosition());
			_displayDirty = true;
			_deltaSender?.Invoke(global::InventorySystem.Items.Keycards.Snake.SnakeNetworkMessage.NewReset(_foodPosition));
			Move();
		}

		private bool ValidateFoodPosition(global::UnityEngine.Vector2Int potentialPos)
		{
			if (_segments.Contains(potentialPos))
			{
				return false;
			}
			global::UnityEngine.Vector2Int vector2Int = _segments[0];
			global::UnityEngine.Vector2Int vector2Int2 = potentialPos - vector2Int;
			if (vector2Int2.y != 0)
			{
				return vector2Int2.x != 0;
			}
			return false;
		}

		private global::UnityEngine.Vector2Int? GetNextFoodPosition()
		{
			int x = Rng.Next(_areaSize.x);
			int y = Rng.Next(_areaSize.y);
			global::UnityEngine.Vector2Int vector2Int = new global::UnityEngine.Vector2Int(x, y);
			for (int i = 0; i < _areaSize.x; i++)
			{
				for (int j = 0; j < _areaSize.y; j++)
				{
					global::UnityEngine.Vector2Int input = vector2Int + new global::UnityEngine.Vector2Int(i, j);
					global::UnityEngine.Vector2Int vector2Int2 = ConfineToPlayableArea(input);
					if (ValidateFoodPosition(vector2Int2))
					{
						return vector2Int2;
					}
				}
			}
			return null;
		}

		private global::UnityEngine.Vector2Int ConfineToPlayableArea(global::UnityEngine.Vector2Int input)
		{
			int i = input.x;
			int j = input.y;
			for (; i < 0; i += _areaSize.x)
			{
			}
			for (; j < 0; j += _areaSize.y)
			{
			}
			return new global::UnityEngine.Vector2Int(i % _areaSize.x, j % _areaSize.y);
		}

		public bool ProvideInput(global::UnityEngine.Vector2Int moveDir)
		{
			if (_gameoverSw.IsRunning)
			{
				if (_gameoverSw.Elapsed.TotalSeconds < (double)_minGameoverTime)
				{
					return false;
				}
				ResetSnake();
				return true;
			}
			if (_inputQueue.Count >= 3)
			{
				_inputQueue.Clear();
			}
			_inputQueue.Enqueue(moveDir);
			return true;
		}

		public void Move()
		{
			if (_gameoverSw.IsRunning || _deltaSender == null)
			{
				return;
			}
			global::UnityEngine.Vector2Int result;
			while (_inputQueue.TryDequeue(out result))
			{
				if (!(result == _curMovDir) && !(result == -_curMovDir) && result.sqrMagnitude == 1)
				{
					_curMovDir = result;
					break;
				}
			}
			global::UnityEngine.Vector2Int vector2Int = _segments[0];
			global::UnityEngine.Vector2Int vector2Int2 = ConfineToPlayableArea(vector2Int + _curMovDir);
			if (_segments.LastIndexOf(vector2Int) > 0)
			{
				_displayDirty = true;
				_gameoverSw.Start();
				_deltaSender?.Invoke(global::InventorySystem.Items.Keycards.Snake.SnakeNetworkMessage.NewGameOver());
				return;
			}
			_segments.Insert(0, vector2Int2);
			bool flag = true;
			global::UnityEngine.Vector2Int value = vector2Int2;
			global::UnityEngine.Vector2Int? foodPosition = _foodPosition;
			if (value == foodPosition)
			{
				flag = CurLength >= _maxLength;
				Score++;
				_foodPosition = GetNextFoodPosition();
				_deltaSender(global::InventorySystem.Items.Keycards.Snake.SnakeNetworkMessage.NewEaten(_curMovDir, _foodPosition));
			}
			else
			{
				_deltaSender(global::InventorySystem.Items.Keycards.Snake.SnakeNetworkMessage.NewSimple(_curMovDir));
			}
			if (flag)
			{
				_segments.RemoveAt(_segments.Count - 1);
			}
			_displayDirty = true;
		}

		public void UpdateDisplay(global::InventorySystem.Items.Keycards.Snake.SnakeDisplay display, bool force = false)
		{
			if (force || _displayDirty)
			{
				_displayDirty = false;
				display.SetDisplay(_segments, _curMovDir, _foodPosition, Score, _gameoverSw.IsRunning);
			}
		}

		public void ProcessMessage(global::InventorySystem.Items.Keycards.Snake.SnakeNetworkMessage msg)
		{
			if (_deltaSender != null)
			{
				return;
			}
			_displayDirty = true;
			if (!msg.HasFlag(global::InventorySystem.Items.Keycards.Snake.SnakeNetworkMessage.SyncFlags.Delta))
			{
				_segments.Clear();
				_segments.AddRange(msg.Segments);
				_foodPosition = msg.NextFoodPosition;
				Score = _segments.Count - _startLength;
			}
			if (msg.HasFlag(global::InventorySystem.Items.Keycards.Snake.SnakeNetworkMessage.SyncFlags.GameOver))
			{
				_gameoverSw.Start();
				return;
			}
			_gameoverSw.Stop();
			if (msg.HasFlag(global::InventorySystem.Items.Keycards.Snake.SnakeNetworkMessage.SyncFlags.GameReset))
			{
				ResetSnake(fromNetworkMessage: true);
				_foodPosition = msg.NextFoodPosition;
				return;
			}
			_curMovDir = msg.MoveOffset;
			global::UnityEngine.Vector2Int item = ConfineToPlayableArea(_segments[0] + _curMovDir);
			_segments.Insert(0, item);
			bool flag = true;
			if (msg.HasFlag(global::InventorySystem.Items.Keycards.Snake.SnakeNetworkMessage.SyncFlags.HasNewFood))
			{
				_foodPosition = msg.NextFoodPosition;
				flag = CurLength >= _maxLength;
				Score++;
			}
			if (flag)
			{
				_segments.RemoveAt(_segments.Count - 1);
			}
		}

		public void WriteFullResyncMessage(global::Mirror.NetworkWriter writer)
		{
			global::InventorySystem.Items.Keycards.Snake.SnakeNetworkMessage.NewFullResync(_gameoverSw.IsRunning, _segments, _foodPosition).WriteSelf(writer);
		}
	}
}
