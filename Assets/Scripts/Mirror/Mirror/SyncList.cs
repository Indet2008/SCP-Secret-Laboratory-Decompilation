namespace Mirror
{
	public class SyncList<T> : global::Mirror.SyncObject, global::System.Collections.Generic.IList<T>, global::System.Collections.Generic.ICollection<T>, global::System.Collections.Generic.IEnumerable<T>, global::System.Collections.IEnumerable, global::System.Collections.Generic.IReadOnlyList<T>, global::System.Collections.Generic.IReadOnlyCollection<T>
	{
		public delegate void SyncListChanged(global::Mirror.SyncList<T>.Operation op, int itemIndex, T oldItem, T newItem);

		public enum Operation : byte
		{
			OP_ADD = 0,
			OP_CLEAR = 1,
			OP_INSERT = 2,
			OP_REMOVEAT = 3,
			OP_SET = 4
		}

		private struct Change
		{
			internal global::Mirror.SyncList<T>.Operation operation;

			internal int index;

			internal T item;
		}

		public struct Enumerator : global::System.Collections.Generic.IEnumerator<T>, global::System.Collections.IEnumerator, global::System.IDisposable
		{
			private readonly global::Mirror.SyncList<T> list;

			private int index;

			public T Current { get; private set; }

			object global::System.Collections.IEnumerator.Current => Current;

			public Enumerator(global::Mirror.SyncList<T> list)
			{
				this.list = list;
				index = -1;
				Current = default;
			}

			public bool MoveNext()
			{
				if (++index >= list.Count)
				{
					return false;
				}
				Current = list[index];
				return true;
			}

			public void Reset()
			{
				index = -1;
			}

			public void Dispose()
			{
			}
		}

		private readonly global::System.Collections.Generic.IList<T> objects;

		private readonly global::System.Collections.Generic.IEqualityComparer<T> comparer;

		private readonly global::System.Collections.Generic.List<global::Mirror.SyncList<T>.Change> changes = new global::System.Collections.Generic.List<global::Mirror.SyncList<T>.Change>();

		private int changesAhead;

		public int Count => objects.Count;

		public bool IsReadOnly => !IsWritable();

		public T this[int i]
		{
			get
			{
				return objects[i];
			}
			set
			{
				if (!comparer.Equals(objects[i], value))
				{
					T oldItem = objects[i];
					objects[i] = value;
					AddOperation(global::Mirror.SyncList<T>.Operation.OP_SET, i, oldItem, value, checkAccess: true);
				}
			}
		}

		public event global::Mirror.SyncList<T>.SyncListChanged Callback;

		public event global::System.Action OnModified;

		public SyncList()
			: this((global::System.Collections.Generic.IEqualityComparer<T>)global::System.Collections.Generic.EqualityComparer<T>.Default)
		{
		}

		public SyncList(global::System.Collections.Generic.IEqualityComparer<T> comparer)
		{
			this.comparer = comparer ?? global::System.Collections.Generic.EqualityComparer<T>.Default;
			objects = new global::System.Collections.Generic.List<T>();
		}

		public SyncList(global::System.Collections.Generic.IList<T> objects, global::System.Collections.Generic.IEqualityComparer<T> comparer = null)
		{
			this.comparer = comparer ?? global::System.Collections.Generic.EqualityComparer<T>.Default;
			this.objects = objects;
		}

		public override void ClearChanges()
		{
			changes.Clear();
		}

		public override void Reset()
		{
			changes.Clear();
			changesAhead = 0;
			objects.Clear();
		}

		private void AddOperation(global::Mirror.SyncList<T>.Operation op, int itemIndex, T oldItem, T newItem, bool checkAccess)
		{
			if (checkAccess && IsReadOnly)
			{
				throw new global::System.InvalidOperationException("Synclists can only be modified by the owner.");
			}
			global::Mirror.SyncList<T>.Change item = new global::Mirror.SyncList<T>.Change
			{
				operation = op,
				index = itemIndex,
				item = newItem
			};
			if (IsRecording())
			{
				changes.Add(item);
				OnDirty?.Invoke();
			}
			Callback?.Invoke(op, itemIndex, oldItem, newItem);
		}

		public override void OnSerializeAll(global::Mirror.NetworkWriter writer)
		{
			writer.WriteUInt((uint)objects.Count);
			for (int i = 0; i < objects.Count; i++)
			{
				T value = objects[i];
				writer.Write(value);
			}
			writer.WriteUInt((uint)changes.Count);
		}

		public override void OnSerializeDelta(global::Mirror.NetworkWriter writer)
		{
			writer.WriteUInt((uint)changes.Count);
			for (int i = 0; i < changes.Count; i++)
			{
				global::Mirror.SyncList<T>.Change change = changes[i];
				writer.WriteByte((byte)change.operation);
				switch (change.operation)
				{
				case global::Mirror.SyncList<T>.Operation.OP_ADD:
					writer.Write(change.item);
					break;
				case global::Mirror.SyncList<T>.Operation.OP_REMOVEAT:
					writer.WriteUInt((uint)change.index);
					break;
				case global::Mirror.SyncList<T>.Operation.OP_INSERT:
				case global::Mirror.SyncList<T>.Operation.OP_SET:
					writer.WriteUInt((uint)change.index);
					writer.Write(change.item);
					break;
				}
			}
		}

		public override void OnDeserializeAll(global::Mirror.NetworkReader reader)
		{
			int num = (int)reader.ReadUInt();
			objects.Clear();
			changes.Clear();
			for (int i = 0; i < num; i++)
			{
				T item = reader.Read<T>();
				objects.Add(item);
			}
			changesAhead = (int)reader.ReadUInt();
			OnModified?.Invoke();
		}

		public override void OnDeserializeDelta(global::Mirror.NetworkReader reader)
		{
			int num = (int)reader.ReadUInt();
			for (int i = 0; i < num; i++)
			{
				global::Mirror.SyncList<T>.Operation operation = (global::Mirror.SyncList<T>.Operation)reader.ReadByte();
				bool flag = changesAhead == 0;
				int num2 = 0;
				T val = default;
				T val2 = default;
				switch (operation)
				{
				case global::Mirror.SyncList<T>.Operation.OP_ADD:
					val2 = reader.Read<T>();
					if (flag)
					{
						num2 = objects.Count;
						objects.Add(val2);
						AddOperation(global::Mirror.SyncList<T>.Operation.OP_ADD, objects.Count - 1, default, val2, checkAccess: false);
					}
					break;
				case global::Mirror.SyncList<T>.Operation.OP_CLEAR:
					if (flag)
					{
						objects.Clear();
						AddOperation(global::Mirror.SyncList<T>.Operation.OP_CLEAR, 0, default, default, checkAccess: false);
					}
					break;
				case global::Mirror.SyncList<T>.Operation.OP_INSERT:
					num2 = (int)reader.ReadUInt();
					val2 = reader.Read<T>();
					if (flag)
					{
						objects.Insert(num2, val2);
						AddOperation(global::Mirror.SyncList<T>.Operation.OP_INSERT, num2, default, val2, checkAccess: false);
					}
					break;
				case global::Mirror.SyncList<T>.Operation.OP_REMOVEAT:
					num2 = (int)reader.ReadUInt();
					if (flag)
					{
						val = objects[num2];
						objects.RemoveAt(num2);
						AddOperation(global::Mirror.SyncList<T>.Operation.OP_REMOVEAT, num2, val, default, checkAccess: false);
					}
					break;
				case global::Mirror.SyncList<T>.Operation.OP_SET:
					num2 = (int)reader.ReadUInt();
					val2 = reader.Read<T>();
					if (flag)
					{
						val = objects[num2];
						objects[num2] = val2;
						AddOperation(global::Mirror.SyncList<T>.Operation.OP_SET, num2, val, val2, checkAccess: false);
					}
					break;
				}
				if (!flag)
				{
					changesAhead--;
				}
			}
			if (num > 0)
			{
				OnModified?.Invoke();
			}
		}

		public void Add(T item)
		{
			objects.Add(item);
			AddOperation(global::Mirror.SyncList<T>.Operation.OP_ADD, objects.Count - 1, default, item, checkAccess: true);
		}

		public void AddRange(global::System.Collections.Generic.IEnumerable<T> range)
		{
			foreach (T item in range)
			{
				Add(item);
			}
		}

		public void Clear()
		{
			objects.Clear();
			AddOperation(global::Mirror.SyncList<T>.Operation.OP_CLEAR, 0, default, default, checkAccess: true);
		}

		public bool Contains(T item)
		{
			return IndexOf(item) >= 0;
		}

		public void CopyTo(T[] array, int index)
		{
			objects.CopyTo(array, index);
		}

		public int IndexOf(T item)
		{
			for (int i = 0; i < objects.Count; i++)
			{
				if (comparer.Equals(item, objects[i]))
				{
					return i;
				}
			}
			return -1;
		}

		public int FindIndex(global::System.Predicate<T> match)
		{
			for (int i = 0; i < objects.Count; i++)
			{
				if (match(objects[i]))
				{
					return i;
				}
			}
			return -1;
		}

		public T Find(global::System.Predicate<T> match)
		{
			int num = FindIndex(match);
			if (num == -1)
			{
				return default;
			}
			return objects[num];
		}

		public global::System.Collections.Generic.List<T> FindAll(global::System.Predicate<T> match)
		{
			global::System.Collections.Generic.List<T> list = new global::System.Collections.Generic.List<T>();
			for (int i = 0; i < objects.Count; i++)
			{
				if (match(objects[i]))
				{
					list.Add(objects[i]);
				}
			}
			return list;
		}

		public void Insert(int index, T item)
		{
			objects.Insert(index, item);
			AddOperation(global::Mirror.SyncList<T>.Operation.OP_INSERT, index, default, item, checkAccess: true);
		}

		public void InsertRange(int index, global::System.Collections.Generic.IEnumerable<T> range)
		{
			foreach (T item in range)
			{
				Insert(index, item);
				index++;
			}
		}

		public bool Remove(T item)
		{
			int num = IndexOf(item);
			bool num2 = num >= 0;
			if (num2)
			{
				RemoveAt(num);
			}
			return num2;
		}

		public void RemoveAt(int index)
		{
			T oldItem = objects[index];
			objects.RemoveAt(index);
			AddOperation(global::Mirror.SyncList<T>.Operation.OP_REMOVEAT, index, oldItem, default, checkAccess: true);
		}

		public int RemoveAll(global::System.Predicate<T> match)
		{
			global::System.Collections.Generic.List<T> list = new global::System.Collections.Generic.List<T>();
			for (int i = 0; i < objects.Count; i++)
			{
				if (match(objects[i]))
				{
					list.Add(objects[i]);
				}
			}
			foreach (T item in list)
			{
				Remove(item);
			}
			return list.Count;
		}

		public global::Mirror.SyncList<T>.Enumerator GetEnumerator()
		{
			return new global::Mirror.SyncList<T>.Enumerator(this);
		}

		global::System.Collections.Generic.IEnumerator<T> global::System.Collections.Generic.IEnumerable<T>.GetEnumerator()
		{
			return new global::Mirror.SyncList<T>.Enumerator(this);
		}

		global::System.Collections.IEnumerator global::System.Collections.IEnumerable.GetEnumerator()
		{
			return new global::Mirror.SyncList<T>.Enumerator(this);
		}
	}
}
