using System;
using System.Collections;
using System.Collections.Generic;

namespace Utf8Json.Formatters
{
	public sealed class NonGenericInterfaceDictionaryFormatter : IJsonFormatter<IDictionary>, IJsonFormatter
	{
		public static readonly IJsonFormatter<IDictionary> Default = new NonGenericInterfaceDictionaryFormatter();

		public void Serialize(ref JsonWriter writer, IDictionary value, IJsonFormatterResolver formatterResolver)
		{
			if (value == null)
			{
				writer.WriteNull();
				return;
			}
			IJsonFormatter<object> formatterWithVerify = formatterResolver.GetFormatterWithVerify<object>();
			writer.WriteBeginObject();
			IDictionaryEnumerator dictionaryEnumerator = value.GetEnumerator();
			try
			{
				if (dictionaryEnumerator.MoveNext())
				{
					DictionaryEntry dictionaryEntry = (DictionaryEntry)dictionaryEnumerator.Current;
					writer.WritePropertyName(dictionaryEntry.Key.ToString());
					formatterWithVerify.Serialize(ref writer, dictionaryEntry.Value, formatterResolver);
					while (dictionaryEnumerator.MoveNext())
					{
						writer.WriteValueSeparator();
						DictionaryEntry dictionaryEntry2 = (DictionaryEntry)dictionaryEnumerator.Current;
						writer.WritePropertyName(dictionaryEntry2.Key.ToString());
						formatterWithVerify.Serialize(ref writer, dictionaryEntry2.Value, formatterResolver);
					}
				}
			}
			finally
			{
				IDisposable disposable = dictionaryEnumerator as IDisposable;
				if (disposable != null)
				{
					disposable.Dispose();
				}
			}
			writer.WriteEndObject();
		}

		public IDictionary Deserialize(ref JsonReader reader, IJsonFormatterResolver formatterResolver)
		{
			if (reader.ReadIsNull())
			{
				return null;
			}
			IJsonFormatter<object> formatterWithVerify = formatterResolver.GetFormatterWithVerify<object>();
			reader.ReadIsBeginObjectWithVerify();
			Dictionary<object, object> dictionary = new Dictionary<object, object>();
			int count = 0;
			while (!reader.ReadIsEndObjectWithSkipValueSeparator(ref count))
			{
				string key = reader.ReadPropertyName();
				object value = formatterWithVerify.Deserialize(ref reader, formatterResolver);
				dictionary.Add(key, value);
			}
			return dictionary;
		}
	}
}
