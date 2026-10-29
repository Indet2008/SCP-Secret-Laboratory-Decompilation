[global::System.Runtime.CompilerServices.CompilerGenerated]
internal sealed class _003C_003Ez__ReadOnlySingleElementList<T> : global::System.Collections.IEnumerable, global::System.Collections.ICollection, global::System.Collections.IList, global::System.Collections.Generic.IEnumerable<T>, global::System.Collections.Generic.IReadOnlyCollection<T>, global::System.Collections.Generic.IReadOnlyList<T>, global::System.Collections.Generic.ICollection<T>, global::System.Collections.Generic.IList<T>
{
	private sealed class Enumerator : global::System.IDisposable, global::System.Collections.IEnumerator, global::System.Collections.Generic.IEnumerator<T>
	{
		[global::System.Runtime.CompilerServices.CompilerGenerated]
		private readonly T _item;

		[global::System.Runtime.CompilerServices.CompilerGenerated]
		private bool _moveNextCalled;

		object global::System.Collections.IEnumerator.Current => _item;

		T global::System.Collections.Generic.IEnumerator<T>.Current => _item;

		public Enumerator(T item)
		{
			_item = item;
		}

		bool global::System.Collections.IEnumerator.MoveNext()
		{
			if (!_moveNextCalled)
			{
				return _moveNextCalled = true;
			}
			return false;
		}

		void global::System.Collections.IEnumerator.Reset()
		{
			_moveNextCalled = false;
		}

		void global::System.IDisposable.Dispose()
		{
		}
	}

	[global::System.Runtime.CompilerServices.CompilerGenerated]
	private readonly T _item;

	int global::System.Collections.ICollection.Count => 1;

	bool global::System.Collections.ICollection.IsSynchronized => false;

	object global::System.Collections.ICollection.SyncRoot => this;

	object global::System.Collections.IList.this[int index]
	{
		get
		{
			if (index != 0)
			{
				throw new global::System.IndexOutOfRangeException();
			}
			return _item;
		}
		set
		{
			throw new global::System.NotSupportedException();
		}
	}

	bool global::System.Collections.IList.IsFixedSize => true;

	bool global::System.Collections.IList.IsReadOnly => true;

	int global::System.Collections.Generic.IReadOnlyCollection<T>.Count => 1;

	T global::System.Collections.Generic.IReadOnlyList<T>.this[int index]
	{
		get
		{
			if (index != 0)
			{
				throw new global::System.IndexOutOfRangeException();
			}
			return _item;
		}
	}

	int global::System.Collections.Generic.ICollection<T>.Count => 1;

	bool global::System.Collections.Generic.ICollection<T>.IsReadOnly => true;

	T global::System.Collections.Generic.IList<T>.this[int index]
	{
		get
		{
			if (index != 0)
			{
				throw new global::System.IndexOutOfRangeException();
			}
			return _item;
		}
		set
		{
			throw new global::System.NotSupportedException();
		}
	}

	public _003C_003Ez__ReadOnlySingleElementList(T item)
	{
		_item = item;
	}

	global::System.Collections.IEnumerator global::System.Collections.IEnumerable.GetEnumerator()
	{
		return new _003C_003Ez__ReadOnlySingleElementList<T>.Enumerator(_item);
	}

	void global::System.Collections.ICollection.CopyTo(global::System.Array array, int index)
	{
		array.SetValue(_item, index);
	}

	int global::System.Collections.IList.Add(object value)
	{
		throw new global::System.NotSupportedException();
	}

	void global::System.Collections.IList.Clear()
	{
		throw new global::System.NotSupportedException();
	}

	bool global::System.Collections.IList.Contains(object value)
	{
		return global::System.Collections.Generic.EqualityComparer<T>.Default.Equals(_item, (T)value);
	}

	int global::System.Collections.IList.IndexOf(object value)
	{
		if (!global::System.Collections.Generic.EqualityComparer<T>.Default.Equals(_item, (T)value))
		{
			return -1;
		}
		return 0;
	}

	void global::System.Collections.IList.Insert(int index, object value)
	{
		throw new global::System.NotSupportedException();
	}

	void global::System.Collections.IList.Remove(object value)
	{
		throw new global::System.NotSupportedException();
	}

	void global::System.Collections.IList.RemoveAt(int index)
	{
		throw new global::System.NotSupportedException();
	}

	global::System.Collections.Generic.IEnumerator<T> global::System.Collections.Generic.IEnumerable<T>.GetEnumerator()
	{
		return new _003C_003Ez__ReadOnlySingleElementList<T>.Enumerator(_item);
	}

	void global::System.Collections.Generic.ICollection<T>.Add(T item)
	{
		throw new global::System.NotSupportedException();
	}

	void global::System.Collections.Generic.ICollection<T>.Clear()
	{
		throw new global::System.NotSupportedException();
	}

	bool global::System.Collections.Generic.ICollection<T>.Contains(T item)
	{
		return global::System.Collections.Generic.EqualityComparer<T>.Default.Equals(_item, item);
	}

	void global::System.Collections.Generic.ICollection<T>.CopyTo(T[] array, int arrayIndex)
	{
		array[arrayIndex] = _item;
	}

	bool global::System.Collections.Generic.ICollection<T>.Remove(T item)
	{
		throw new global::System.NotSupportedException();
	}

	int global::System.Collections.Generic.IList<T>.IndexOf(T item)
	{
		if (!global::System.Collections.Generic.EqualityComparer<T>.Default.Equals(_item, item))
		{
			return -1;
		}
		return 0;
	}

	void global::System.Collections.Generic.IList<T>.Insert(int index, T item)
	{
		throw new global::System.NotSupportedException();
	}

	void global::System.Collections.Generic.IList<T>.RemoveAt(int index)
	{
		throw new global::System.NotSupportedException();
	}
}
