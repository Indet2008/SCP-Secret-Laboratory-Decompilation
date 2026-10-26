using System.Collections.Generic;

namespace Utf8Json.Formatters
{
	public sealed class QeueueFormatter<T> : CollectionFormatterBase<T, Queue<T>, Queue<T>.Enumerator, Queue<T>>
	{
		private readonly CollectionDeserializeToBehaviour deserializeToBehaviour;

		protected override CollectionDeserializeToBehaviour? SupportedOverwriteBehaviour => deserializeToBehaviour;

		public QeueueFormatter()
			: this(CollectionDeserializeToBehaviour.Add)
		{
		}

		public QeueueFormatter(CollectionDeserializeToBehaviour deserializeToBehaviour)
		{
			this.deserializeToBehaviour = deserializeToBehaviour;
		}

		protected override void Add(ref Queue<T> collection, int index, T value)
		{
			collection.Enqueue(value);
		}

		protected override Queue<T> Create()
		{
			return new Queue<T>();
		}

		protected override Queue<T>.Enumerator GetSourceEnumerator(Queue<T> source)
		{
			return source.GetEnumerator();
		}

		protected override Queue<T> Complete(ref Queue<T> intermediateCollection)
		{
			return intermediateCollection;
		}

		protected override void AddOnOverwriteDeserialize(ref Queue<T> collection, int index, T value)
		{
			collection.Enqueue(value);
		}

		protected override void ClearOnOverwriteDeserialize(ref Queue<T> value)
		{
			value.Clear();
		}
	}
}
