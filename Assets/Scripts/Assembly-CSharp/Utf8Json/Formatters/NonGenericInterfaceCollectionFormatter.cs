using System;
using System.Collections;
using System.Collections.Generic;

namespace Utf8Json.Formatters
{
	public sealed class NonGenericInterfaceCollectionFormatter : IJsonFormatter<ICollection>, IJsonFormatter
	{
		public static readonly IJsonFormatter<ICollection> Default = new NonGenericInterfaceCollectionFormatter();

		public void Serialize(ref JsonWriter writer, ICollection value, IJsonFormatterResolver formatterResolver)
		{
			if (value == null)
			{
				writer.WriteNull();
				return;
			}
			IJsonFormatter<object> formatterWithVerify = formatterResolver.GetFormatterWithVerify<object>();
			writer.WriteBeginArray();
			IEnumerator enumerator = value.GetEnumerator();
			try
			{
				if (enumerator.MoveNext())
				{
					formatterWithVerify.Serialize(ref writer, enumerator.Current, formatterResolver);
					while (enumerator.MoveNext())
					{
						writer.WriteValueSeparator();
						formatterWithVerify.Serialize(ref writer, enumerator.Current, formatterResolver);
					}
				}
			}
			finally
			{
				IDisposable disposable = enumerator as IDisposable;
				if (disposable != null)
				{
					disposable.Dispose();
				}
			}
			writer.WriteEndArray();
		}

		public ICollection Deserialize(ref JsonReader reader, IJsonFormatterResolver formatterResolver)
		{
			if (reader.ReadIsNull())
			{
				return null;
			}
			int count = 0;
			IJsonFormatter<object> formatterWithVerify = formatterResolver.GetFormatterWithVerify<object>();
			List<object> list = new List<object>();
			reader.ReadIsBeginArrayWithVerify();
			while (!reader.ReadIsEndArrayWithSkipValueSeparator(ref count))
			{
				list.Add(formatterWithVerify.Deserialize(ref reader, formatterResolver));
			}
			return list;
		}
	}
}
