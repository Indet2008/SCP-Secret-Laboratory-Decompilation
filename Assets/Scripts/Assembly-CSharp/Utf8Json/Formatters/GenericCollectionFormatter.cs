using System.Collections.Generic;

namespace Utf8Json.Formatters
{
	public sealed class GenericCollectionFormatter<TElement, TCollection> : CollectionFormatterBase<TElement, TCollection> where TCollection : class, ICollection<TElement>, new()
	{
		protected override TCollection Create()
		{
			return new TCollection();
		}

		protected override void Add(ref TCollection collection, int index, TElement value)
		{
			collection.Add(value);
		}
	}
}
