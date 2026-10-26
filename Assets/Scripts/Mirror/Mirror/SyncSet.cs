namespace Mirror
{
	public class SyncSet<T> : global::Mirror.SyncObject, global::System.Collections.Generic.ISet<T>, global::System.Collections.Generic.ICollection<T>, global::System.Collections.Generic.IEnumerable<T>, global::System.Collections.IEnumerable
	{
		public delegate void SyncSetChanged(global::Mirror.SyncSet<T>.Operation op, T item);

		public enum Operation : byte
		{
			OP_ADD = 0,
			OP_CLEAR = 1,
			OP_REMOVE = 2
		}

		private struct Change
		{
			internal global::Mirror.SyncSet<T>.Operation operation;

			internal T item;
		}

		protected readonly global::System.Collections.Generic.ISet<T> objects;

		private readonly global::System.Collections.Generic.List<global::Mirror.SyncSet<T>.Change> changes = new global::System.Collections.Generic.List<global::Mirror.SyncSet<T>.Change>();

		private int changesAhead;

		public int Count => objects.Count;

		public bool IsReadOnly => !IsWritable();

		public event global::Mirror.SyncSet<T>.SyncSetChanged Callback;

		public SyncSet(global::System.Collections.Generic.ISet<T> objects)
		{
			this.objects = objects;
		}

		public override void Reset()
		{
			changes.Clear();
			changesAhead = 0;
			objects.Clear();
		}

		public override void ClearChanges()
		{
			changes.Clear();
		}

		private void AddOperation(global::Mirror.SyncSet<T>.Operation op, T item, bool checkAccess)
		{
			if (checkAccess && IsReadOnly)
			{
				throw new global::System.InvalidOperationException("SyncSets can only be modified by the owner.");
			}
			global::Mirror.SyncSet<T>.Change item2 = new global::Mirror.SyncSet<T>.Change
			{
				operation = op,
				item = item
			};
			if (IsRecording())
			{
				changes.Add(item2);
				OnDirty?.Invoke();
			}
			Callback?.Invoke(op, item);
		}

		private void AddOperation(global::Mirror.SyncSet<T>.Operation op, bool checkAccess)
		{
			AddOperation(op, default, checkAccess);
		}

		public override void OnSerializeAll(global::Mirror.NetworkWriter writer)
		{
			writer.WriteUInt((uint)objects.Count);
			foreach (T @object in objects)
			{
				writer.Write(@object);
			}
			writer.WriteUInt((uint)changes.Count);
		}

		public override void OnSerializeDelta(global::Mirror.NetworkWriter writer)
		{
			writer.WriteUInt((uint)changes.Count);
			for (int i = 0; i < changes.Count; i++)
			{
				global::Mirror.SyncSet<T>.Change change = changes[i];
				writer.WriteByte((byte)change.operation);
				switch (change.operation)
				{
				case global::Mirror.SyncSet<T>.Operation.OP_ADD:
					writer.Write(change.item);
					break;
				case global::Mirror.SyncSet<T>.Operation.OP_REMOVE:
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
		}

		public override void OnDeserializeDelta(global::Mirror.NetworkReader reader)
		{
			int num = (int)reader.ReadUInt();
			for (int i = 0; i < num; i++)
			{
				global::Mirror.SyncSet<T>.Operation operation = (global::Mirror.SyncSet<T>.Operation)reader.ReadByte();
				bool flag = changesAhead == 0;
				T val = default;
				switch (operation)
				{
				case global::Mirror.SyncSet<T>.Operation.OP_ADD:
					val = reader.Read<T>();
					if (flag)
					{
						objects.Add(val);
						AddOperation(global::Mirror.SyncSet<T>.Operation.OP_ADD, val, checkAccess: false);
					}
					break;
				case global::Mirror.SyncSet<T>.Operation.OP_CLEAR:
					if (flag)
					{
						objects.Clear();
						AddOperation(global::Mirror.SyncSet<T>.Operation.OP_CLEAR, checkAccess: false);
					}
					break;
				case global::Mirror.SyncSet<T>.Operation.OP_REMOVE:
					val = reader.Read<T>();
					if (flag)
					{
						objects.Remove(val);
						AddOperation(global::Mirror.SyncSet<T>.Operation.OP_REMOVE, val, checkAccess: false);
					}
					break;
				}
				if (!flag)
				{
					changesAhead--;
				}
			}
		}

		public bool Add(T item)
		{
			if (objects.Add(item))
			{
				AddOperation(global::Mirror.SyncSet<T>.Operation.OP_ADD, item, checkAccess: true);
				return true;
			}
			return false;
		}

		void global::System.Collections.Generic.ICollection<T>.Add(T item)
		{
			if (objects.Add(item))
			{
				AddOperation(global::Mirror.SyncSet<T>.Operation.OP_ADD, item, checkAccess: true);
			}
		}

		public void Clear()
		{
			objects.Clear();
			AddOperation(global::Mirror.SyncSet<T>.Operation.OP_CLEAR, checkAccess: true);
		}

		public bool Contains(T item)
		{
			return objects.Contains(item);
		}

		public void CopyTo(T[] array, int index)
		{
			objects.CopyTo(array, index);
		}

		public bool Remove(T item)
		{
			if (objects.Remove(item))
			{
				AddOperation(global::Mirror.SyncSet<T>.Operation.OP_REMOVE, item, checkAccess: true);
				return true;
			}
			return false;
		}

		public global::System.Collections.Generic.IEnumerator<T> GetEnumerator()
		{
			return objects.GetEnumerator();
		}

		global::System.Collections.IEnumerator global::System.Collections.IEnumerable.GetEnumerator()
		{
			return GetEnumerator();
		}

		public void ExceptWith(global::System.Collections.Generic.IEnumerable<T> other)
		{
			if (other == this)
			{
				Clear();
				return;
			}
			foreach (T item in other)
			{
				Remove(item);
			}
		}

		public void IntersectWith(global::System.Collections.Generic.IEnumerable<T> other)
		{
			if (other is global::System.Collections.Generic.ISet<T> otherSet)
			{
				IntersectWithSet(otherSet);
				return;
			}
			global::System.Collections.Generic.HashSet<T> otherSet2 = new global::System.Collections.Generic.HashSet<T>(other);
			IntersectWithSet(otherSet2);
		}

		private void IntersectWithSet(global::System.Collections.Generic.ISet<T> otherSet)
		{
			foreach (T item in new global::System.Collections.Generic.List<T>(objects))
			{
				if (!otherSet.Contains(item))
				{
					Remove(item);
				}
			}
		}

		public bool IsProperSubsetOf(global::System.Collections.Generic.IEnumerable<T> other)
		{
			return objects.IsProperSubsetOf(other);
		}

		public bool IsProperSupersetOf(global::System.Collections.Generic.IEnumerable<T> other)
		{
			return objects.IsProperSupersetOf(other);
		}

		public bool IsSubsetOf(global::System.Collections.Generic.IEnumerable<T> other)
		{
			return objects.IsSubsetOf(other);
		}

		public bool IsSupersetOf(global::System.Collections.Generic.IEnumerable<T> other)
		{
			return objects.IsSupersetOf(other);
		}

		public bool Overlaps(global::System.Collections.Generic.IEnumerable<T> other)
		{
			return objects.Overlaps(other);
		}

		public bool SetEquals(global::System.Collections.Generic.IEnumerable<T> other)
		{
			return objects.SetEquals(other);
		}

		public void SymmetricExceptWith(global::System.Collections.Generic.IEnumerable<T> other)
		{
			if (other == this)
			{
				Clear();
				return;
			}
			foreach (T item in other)
			{
				if (!Remove(item))
				{
					Add(item);
				}
			}
		}

		public void UnionWith(global::System.Collections.Generic.IEnumerable<T> other)
		{
			if (other == this)
			{
				return;
			}
			foreach (T item in other)
			{
				Add(item);
			}
		}
	}
}
