namespace LabApi.Features.Extensions
{
	public class PriorityQueue<T>
	{
		private readonly global::System.Collections.Generic.List<(int, T)> _elements;

		public int Count => _elements.Count;

		public PriorityQueue()
		{
			_elements = new global::System.Collections.Generic.List<(int, T)>();
		}

		public void Enqueue(T item, int priority)
		{
			(int, T) item2 = (priority, item);
			_elements.Add(item2);
			HeapifyUp(_elements.Count - 1);
		}

		public T Dequeue()
		{
			if (Count == 0)
			{
				throw new global::System.InvalidOperationException("The queue is empty.");
			}
			T item = _elements[0].Item2;
			int index = _elements.Count - 1;
			_elements[0] = _elements[index];
			_elements.RemoveAt(index);
			if (Count > 0)
			{
				HeapifyDown(0);
			}
			return item;
		}

		public void Clear()
		{
			_elements.Clear();
		}

		private void HeapifyUp(int index)
		{
			int num = (index - 1) / 2;
			while (index > 0 && _elements[index].Item1 < _elements[num].Item1)
			{
				Swap(index, num);
				index = num;
				num = (index - 1) / 2;
			}
		}

		private void HeapifyDown(int index)
		{
			while (true)
			{
				int num = 2 * index + 1;
				int num2 = 2 * index + 2;
				int num3 = index;
				if (num < Count && _elements[num].Item1 < _elements[num3].Item1)
				{
					num3 = num;
				}
				if (num2 < Count && _elements[num2].Item1 < _elements[num3].Item1)
				{
					num3 = num2;
				}
				if (num3 != index)
				{
					Swap(index, num3);
					index = num3;
					continue;
				}
				break;
			}
		}

		private void Swap(int index1, int index2)
		{
			global::System.Collections.Generic.List<(int, T)> elements = _elements;
			global::System.Collections.Generic.List<(int, T)> elements2 = _elements;
			(int, T) value = _elements[index2];
			(int, T) value2 = _elements[index1];
			elements[index1] = value;
			elements2[index2] = value2;
		}
	}
}
