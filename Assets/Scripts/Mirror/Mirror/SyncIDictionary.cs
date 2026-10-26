namespace Mirror
{
	public class SyncIDictionary<TKey, TValue> : global::Mirror.SyncObject, global::System.Collections.Generic.IDictionary<TKey, TValue>, global::System.Collections.Generic.ICollection<global::System.Collections.Generic.KeyValuePair<TKey, TValue>>, global::System.Collections.Generic.IEnumerable<global::System.Collections.Generic.KeyValuePair<TKey, TValue>>, global::System.Collections.IEnumerable, global::System.Collections.Generic.IReadOnlyDictionary<TKey, TValue>, global::System.Collections.Generic.IReadOnlyCollection<global::System.Collections.Generic.KeyValuePair<TKey, TValue>>
	{
		public delegate void SyncDictionaryChanged(global::Mirror.SyncIDictionary<TKey, TValue>.Operation op, TKey key, TValue item);

		public enum Operation : byte
		{
			OP_ADD = 0,
			OP_CLEAR = 1,
			OP_REMOVE = 2,
			OP_SET = 3
		}

		private struct Change
		{
			internal global::Mirror.SyncIDictionary<TKey, TValue>.Operation operation;

			internal TKey key;

			internal TValue item;
		}

		protected readonly global::System.Collections.Generic.IDictionary<TKey, TValue> objects;

		private readonly global::System.Collections.Generic.List<global::Mirror.SyncIDictionary<TKey, TValue>.Change> changes = new global::System.Collections.Generic.List<global::Mirror.SyncIDictionary<TKey, TValue>.Change>();

		private int changesAhead;

		public int Count => objects.Count;

		public bool IsReadOnly => !IsWritable();

		public global::System.Collections.Generic.ICollection<TKey> Keys => objects.Keys;

		public global::System.Collections.Generic.ICollection<TValue> Values => objects.Values;

		global::System.Collections.Generic.IEnumerable<TKey> global::System.Collections.Generic.IReadOnlyDictionary<TKey, TValue>.Keys => objects.Keys;

		global::System.Collections.Generic.IEnumerable<TValue> global::System.Collections.Generic.IReadOnlyDictionary<TKey, TValue>.Values => objects.Values;

		public TValue this[TKey i]
		{
			get
			{
				return objects[i];
			}
			set
			{
				if (ContainsKey(i))
				{
					objects[i] = value;
					AddOperation(global::Mirror.SyncIDictionary<TKey, TValue>.Operation.OP_SET, i, value, checkAccess: true);
				}
				else
				{
					objects[i] = value;
					AddOperation(global::Mirror.SyncIDictionary<TKey, TValue>.Operation.OP_ADD, i, value, checkAccess: true);
				}
			}
		}

		public event global::Mirror.SyncIDictionary<TKey, TValue>.SyncDictionaryChanged Callback;

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

		public SyncIDictionary(global::System.Collections.Generic.IDictionary<TKey, TValue> objects)
		{
			this.objects = objects;
		}

		private void AddOperation(global::Mirror.SyncIDictionary<TKey, TValue>.Operation op, TKey key, TValue item, bool checkAccess)
		{
			if (checkAccess && IsReadOnly)
			{
				throw new global::System.InvalidOperationException("SyncDictionaries can only be modified by the owner.");
			}
			global::Mirror.SyncIDictionary<TKey, TValue>.Change item2 = new global::Mirror.SyncIDictionary<TKey, TValue>.Change
			{
				operation = op,
				key = key,
				item = item
			};
			if (IsRecording())
			{
				changes.Add(item2);
				OnDirty?.Invoke();
			}
			Callback?.Invoke(op, key, item);
		}

		public override void OnSerializeAll(global::Mirror.NetworkWriter writer)
		{
			writer.WriteUInt((uint)objects.Count);
			foreach (global::System.Collections.Generic.KeyValuePair<TKey, TValue> @object in objects)
			{
				writer.Write(@object.Key);
				writer.Write(@object.Value);
			}
			writer.WriteUInt((uint)changes.Count);
		}

		public override void OnSerializeDelta(global::Mirror.NetworkWriter writer)
		{
			writer.WriteUInt((uint)changes.Count);
			for (int i = 0; i < changes.Count; i++)
			{
				global::Mirror.SyncIDictionary<TKey, TValue>.Change change = changes[i];
				writer.WriteByte((byte)change.operation);
				switch (change.operation)
				{
				case global::Mirror.SyncIDictionary<TKey, TValue>.Operation.OP_ADD:
				case global::Mirror.SyncIDictionary<TKey, TValue>.Operation.OP_SET:
					writer.Write(change.key);
					writer.Write(change.item);
					break;
				case global::Mirror.SyncIDictionary<TKey, TValue>.Operation.OP_REMOVE:
					writer.Write(change.key);
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
				TKey key = reader.Read<TKey>();
				TValue value = reader.Read<TValue>();
				objects.Add(key, value);
			}
			changesAhead = (int)reader.ReadUInt();
		}

		public override void OnDeserializeDelta(global::Mirror.NetworkReader reader)
		{
			int num = (int)reader.ReadUInt();
			for (int i = 0; i < num; i++)
			{
				global::Mirror.SyncIDictionary<TKey, TValue>.Operation operation = (global::Mirror.SyncIDictionary<TKey, TValue>.Operation)reader.ReadByte();
				bool flag = changesAhead == 0;
				TKey val = default;
				TValue value = default;
				switch (operation)
				{
				case global::Mirror.SyncIDictionary<TKey, TValue>.Operation.OP_ADD:
				case global::Mirror.SyncIDictionary<TKey, TValue>.Operation.OP_SET:
					val = reader.Read<TKey>();
					value = reader.Read<TValue>();
					if (flag)
					{
						if (ContainsKey(val))
						{
							objects[val] = value;
							AddOperation(global::Mirror.SyncIDictionary<TKey, TValue>.Operation.OP_SET, val, value, checkAccess: false);
						}
						else
						{
							objects[val] = value;
							AddOperation(global::Mirror.SyncIDictionary<TKey, TValue>.Operation.OP_ADD, val, value, checkAccess: false);
						}
					}
					break;
				case global::Mirror.SyncIDictionary<TKey, TValue>.Operation.OP_CLEAR:
					if (flag)
					{
						objects.Clear();
						AddOperation(global::Mirror.SyncIDictionary<TKey, TValue>.Operation.OP_CLEAR, default, default, checkAccess: false);
					}
					break;
				case global::Mirror.SyncIDictionary<TKey, TValue>.Operation.OP_REMOVE:
					val = reader.Read<TKey>();
					if (flag && objects.TryGetValue(val, out value))
					{
						objects.Remove(val);
						AddOperation(global::Mirror.SyncIDictionary<TKey, TValue>.Operation.OP_REMOVE, val, value, checkAccess: false);
					}
					break;
				}
				if (!flag)
				{
					changesAhead--;
				}
			}
		}

		public void Clear()
		{
			objects.Clear();
			AddOperation(global::Mirror.SyncIDictionary<TKey, TValue>.Operation.OP_CLEAR, default, default, checkAccess: true);
		}

		public bool ContainsKey(TKey key)
		{
			return objects.ContainsKey(key);
		}

		public bool Remove(TKey key)
		{
			if (objects.TryGetValue(key, out var value) && objects.Remove(key))
			{
				AddOperation(global::Mirror.SyncIDictionary<TKey, TValue>.Operation.OP_REMOVE, key, value, checkAccess: true);
				return true;
			}
			return false;
		}

		public bool TryGetValue(TKey key, out TValue value)
		{
			return objects.TryGetValue(key, out value);
		}

		public void Add(TKey key, TValue value)
		{
			objects.Add(key, value);
			AddOperation(global::Mirror.SyncIDictionary<TKey, TValue>.Operation.OP_ADD, key, value, checkAccess: true);
		}

		public void Add(global::System.Collections.Generic.KeyValuePair<TKey, TValue> item)
		{
			Add(item.Key, item.Value);
		}

		public bool Contains(global::System.Collections.Generic.KeyValuePair<TKey, TValue> item)
		{
			if (TryGetValue(item.Key, out var value))
			{
				return global::System.Collections.Generic.EqualityComparer<TValue>.Default.Equals(value, item.Value);
			}
			return false;
		}

		public void CopyTo(global::System.Collections.Generic.KeyValuePair<TKey, TValue>[] array, int arrayIndex)
		{
			if (arrayIndex < 0 || arrayIndex > array.Length)
			{
				throw new global::System.ArgumentOutOfRangeException("arrayIndex", "Array Index Out of Range");
			}
			if (array.Length - arrayIndex < Count)
			{
				throw new global::System.ArgumentException("The number of items in the SyncDictionary is greater than the available space from arrayIndex to the end of the destination array");
			}
			int num = arrayIndex;
			foreach (global::System.Collections.Generic.KeyValuePair<TKey, TValue> @object in objects)
			{
				array[num] = @object;
				num++;
			}
		}

		public bool Remove(global::System.Collections.Generic.KeyValuePair<TKey, TValue> item)
		{
			bool num = objects.Remove(item.Key);
			if (num)
			{
				AddOperation(global::Mirror.SyncIDictionary<TKey, TValue>.Operation.OP_REMOVE, item.Key, item.Value, checkAccess: true);
			}
			return num;
		}

		public global::System.Collections.Generic.IEnumerator<global::System.Collections.Generic.KeyValuePair<TKey, TValue>> GetEnumerator()
		{
			return objects.GetEnumerator();
		}

		global::System.Collections.IEnumerator global::System.Collections.IEnumerable.GetEnumerator()
		{
			return objects.GetEnumerator();
		}
	}
}
