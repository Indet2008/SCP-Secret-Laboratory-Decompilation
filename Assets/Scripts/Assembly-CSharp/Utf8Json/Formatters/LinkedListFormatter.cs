using System.Collections.Generic;

namespace Utf8Json.Formatters
{
	public sealed class LinkedListFormatter<T> : CollectionFormatterBase<T, LinkedList<T>, LinkedList<T>.Enumerator, LinkedList<T>>
	{
		private readonly CollectionDeserializeToBehaviour deserializeToBehaviour;

		protected override CollectionDeserializeToBehaviour? SupportedOverwriteBehaviour => deserializeToBehaviour;

		public LinkedListFormatter()
			: this(CollectionDeserializeToBehaviour.Add)
		{
		}

		public LinkedListFormatter(CollectionDeserializeToBehaviour deserializeToBehaviour)
		{
			this.deserializeToBehaviour = deserializeToBehaviour;
		}

		protected override void Add(ref LinkedList<T> collection, int index, T value)
		{
			collection.AddLast(value);
		}

		protected override LinkedList<T> Complete(ref LinkedList<T> intermediateCollection)
		{
			return intermediateCollection;
		}

		protected override LinkedList<T> Create()
		{
			return new LinkedList<T>();
		}

		protected override LinkedList<T>.Enumerator GetSourceEnumerator(LinkedList<T> source)
		{
			return source.GetEnumerator();
		}

		protected override void AddOnOverwriteDeserialize(ref LinkedList<T> collection, int index, T value)
		{
			collection.AddLast(value);
		}

		protected override void ClearOnOverwriteDeserialize(ref LinkedList<T> value)
		{
			value.Clear();
		}
	}
}
