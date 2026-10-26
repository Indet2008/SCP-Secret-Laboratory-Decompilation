using System;
using System.Collections.Generic;

namespace Utils.Networking
{
	public class OrderedBufferQueue<T>
	{
		private T _newestSoFar;

		private long _newestItem;

		private long _oldestItem;

		private T[] _buffer;

		private int _capacity;

		private readonly List<T> _reorganizer;

		private readonly Func<T, T, bool> _isNewer;

		public int Count => (int)(_newestItem - _oldestItem + 1);

		public OrderedBufferQueue(Func<T, T, bool> isNewerComparer)
		{
			_reorganizer = new List<T>();
			_capacity = 64;
			_buffer = new T[64];
			_newestItem = -1L;
			_oldestItem = -1L;
			_isNewer = isNewerComparer;
		}

		public bool TryDequeue(out T data)
		{
			data = _buffer[GetBufferIndex(_oldestItem + 1)];
			if (_oldestItem >= _newestItem)
			{
				return false;
			}
			_oldestItem++;
			return true;
		}

		public void Enqueue(T itemToAdd)
		{
			if (_isNewer(itemToAdd, _newestSoFar))
			{
				AddToBuffer(itemToAdd);
				_newestSoFar = itemToAdd;
				return;
			}
			for (int i = 0; i < _capacity; i++)
			{
				int bufferIndex = GetBufferIndex(_newestItem - i);
				T val = _buffer[bufferIndex];
				if (_isNewer(val, itemToAdd))
				{
					_buffer[bufferIndex] = itemToAdd;
					_reorganizer.Add(val);
					continue;
				}
				_newestItem -= i - 1;
				while (i-- > 0)
				{
					AddToBuffer(_reorganizer[i]);
				}
				_reorganizer.Clear();
				break;
			}
		}

		private void EnsureCapacity()
		{
			if (Count == _capacity)
			{
				int bufferIndex = GetBufferIndex(_oldestItem);
				int num = _capacity * 2;
				if (bufferIndex == 0)
				{
					Array.Resize(ref _buffer, num);
				}
				else
				{
					T[] array = new T[num];
					Array.Copy(_buffer, bufferIndex, array, 0, _capacity - bufferIndex);
					Array.Copy(_buffer, 0, array, _capacity - bufferIndex, bufferIndex);
					_buffer = array;
				}
				_newestItem -= _oldestItem;
				_oldestItem = 0L;
				_capacity = _buffer.Length;
			}
		}

		private void AddToBuffer(T nb)
		{
			EnsureCapacity();
			_buffer[GetBufferIndex(++_newestItem)] = nb;
		}

		private int GetBufferIndex(long position)
		{
			return (int)(position % _capacity + _capacity) % _capacity;
		}
	}
}
