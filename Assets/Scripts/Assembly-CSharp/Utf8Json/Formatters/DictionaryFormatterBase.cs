using System;
using System.Collections.Generic;

namespace Utf8Json.Formatters
{
	public abstract class DictionaryFormatterBase<TKey, TValue, TIntermediate, TEnumerator, TDictionary> : IJsonFormatter<TDictionary>, IJsonFormatter where TEnumerator : IEnumerator<KeyValuePair<TKey, TValue>> where TDictionary : class, IEnumerable<KeyValuePair<TKey, TValue>>
	{
		public void Serialize(ref JsonWriter writer, TDictionary value, IJsonFormatterResolver formatterResolver)
		{
			if (value == null)
			{
				writer.WriteNull();
				return;
			}
			IObjectPropertyNameFormatter<TKey> objectPropertyNameFormatter = formatterResolver.GetFormatterWithVerify<TKey>() as IObjectPropertyNameFormatter<TKey>;
			IJsonFormatter<TValue> formatterWithVerify = formatterResolver.GetFormatterWithVerify<TValue>();
			writer.WriteBeginObject();
			TEnumerator sourceEnumerator = GetSourceEnumerator(value);
			try
			{
				if (objectPropertyNameFormatter != null)
				{
					if (sourceEnumerator.MoveNext())
					{
						KeyValuePair<TKey, TValue> current = sourceEnumerator.Current;
						objectPropertyNameFormatter.SerializeToPropertyName(ref writer, current.Key, formatterResolver);
						writer.WriteNameSeparator();
						formatterWithVerify.Serialize(ref writer, current.Value, formatterResolver);
						while (sourceEnumerator.MoveNext())
						{
							writer.WriteValueSeparator();
							KeyValuePair<TKey, TValue> current2 = sourceEnumerator.Current;
							objectPropertyNameFormatter.SerializeToPropertyName(ref writer, current2.Key, formatterResolver);
							writer.WriteNameSeparator();
							formatterWithVerify.Serialize(ref writer, current2.Value, formatterResolver);
						}
					}
				}
				else if (sourceEnumerator.MoveNext())
				{
					KeyValuePair<TKey, TValue> current3 = sourceEnumerator.Current;
					writer.WriteString(current3.Key.ToString());
					writer.WriteNameSeparator();
					formatterWithVerify.Serialize(ref writer, current3.Value, formatterResolver);
					while (sourceEnumerator.MoveNext())
					{
						writer.WriteValueSeparator();
						KeyValuePair<TKey, TValue> current4 = sourceEnumerator.Current;
						writer.WriteString(current4.Key.ToString());
						writer.WriteNameSeparator();
						formatterWithVerify.Serialize(ref writer, current4.Value, formatterResolver);
					}
				}
			}
			finally
			{
				sourceEnumerator.Dispose();
			}
			writer.WriteEndObject();
		}

		public TDictionary Deserialize(ref JsonReader reader, IJsonFormatterResolver formatterResolver)
		{
			if (reader.ReadIsNull())
			{
				return null;
			}
			if (!(formatterResolver.GetFormatterWithVerify<TKey>() is IObjectPropertyNameFormatter<TKey> objectPropertyNameFormatter))
			{
				throw new InvalidOperationException(typeof(TKey)?.ToString() + " does not support dictionary key deserialize.");
			}
			IJsonFormatter<TValue> formatterWithVerify = formatterResolver.GetFormatterWithVerify<TValue>();
			reader.ReadIsBeginObjectWithVerify();
			TIntermediate collection = Create();
			int count = 0;
			while (!reader.ReadIsEndObjectWithSkipValueSeparator(ref count))
			{
				TKey key = objectPropertyNameFormatter.DeserializeFromPropertyName(ref reader, formatterResolver);
				reader.ReadIsNameSeparatorWithVerify();
				TValue value = formatterWithVerify.Deserialize(ref reader, formatterResolver);
				Add(ref collection, count - 1, key, value);
			}
			return Complete(ref collection);
		}

		protected abstract TEnumerator GetSourceEnumerator(TDictionary source);

		protected abstract TIntermediate Create();

		protected abstract void Add(ref TIntermediate collection, int index, TKey key, TValue value);

		protected abstract TDictionary Complete(ref TIntermediate intermediateCollection);
	}
	public abstract class DictionaryFormatterBase<TKey, TValue, TIntermediate, TDictionary> : DictionaryFormatterBase<TKey, TValue, TIntermediate, IEnumerator<KeyValuePair<TKey, TValue>>, TDictionary> where TDictionary : class, IEnumerable<KeyValuePair<TKey, TValue>>
	{
		protected override IEnumerator<KeyValuePair<TKey, TValue>> GetSourceEnumerator(TDictionary source)
		{
			return source.GetEnumerator();
		}
	}
	public abstract class DictionaryFormatterBase<TKey, TValue, TDictionary> : DictionaryFormatterBase<TKey, TValue, TDictionary, TDictionary> where TDictionary : class, IDictionary<TKey, TValue>
	{
		protected override TDictionary Complete(ref TDictionary intermediateCollection)
		{
			return intermediateCollection;
		}
	}
}
