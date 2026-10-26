using System.Collections.Generic;

namespace Utf8Json.Formatters
{
	public sealed class HashSetFormatter<T> : CollectionFormatterBase<T, HashSet<T>, HashSet<T>.Enumerator, HashSet<T>>
	{
		protected override void Add(ref HashSet<T> collection, int index, T value)
		{
			collection.Add(value);
		}

		protected override HashSet<T> Complete(ref HashSet<T> intermediateCollection)
		{
			return intermediateCollection;
		}

		protected override HashSet<T> Create()
		{
			return new HashSet<T>();
		}

		protected override HashSet<T>.Enumerator GetSourceEnumerator(HashSet<T> source)
		{
			return source.GetEnumerator();
		}
	}
}
