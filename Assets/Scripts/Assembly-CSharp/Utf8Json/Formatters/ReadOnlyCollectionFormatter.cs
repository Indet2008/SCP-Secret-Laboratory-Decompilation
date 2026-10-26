using System.Collections.ObjectModel;
using Utf8Json.Internal;

namespace Utf8Json.Formatters
{
	public sealed class ReadOnlyCollectionFormatter<T> : CollectionFormatterBase<T, ArrayBuffer<T>, ReadOnlyCollection<T>>
	{
		protected override void Add(ref ArrayBuffer<T> collection, int index, T value)
		{
			collection.Add(value);
		}

		protected override ReadOnlyCollection<T> Complete(ref ArrayBuffer<T> intermediateCollection)
		{
			return new ReadOnlyCollection<T>(intermediateCollection.ToArray());
		}

		protected override ArrayBuffer<T> Create()
		{
			return new ArrayBuffer<T>(4);
		}
	}
}
