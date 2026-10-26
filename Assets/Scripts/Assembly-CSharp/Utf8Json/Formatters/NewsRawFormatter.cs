using System;
using Utf8Json.Internal;

namespace Utf8Json.Formatters
{
	public sealed class NewsRawFormatter : IJsonFormatter<NewsRaw>, IJsonFormatter
	{
		private readonly AutomataDictionary ____keyMapping;

		private readonly byte[][] ____stringByteKeys;

		public NewsRawFormatter()
		{
			____keyMapping = new AutomataDictionary { 
			{
				JsonWriter.GetEncodedPropertyNameWithoutQuotation("appnews"),
				0
			} };
			____stringByteKeys = new byte[1][] { JsonWriter.GetEncodedPropertyNameWithBeginObject("appnews") };
		}

		public void Serialize(ref JsonWriter writer, NewsRaw value, IJsonFormatterResolver formatterResolver)
		{
			writer.WriteRaw(____stringByteKeys[0]);
			formatterResolver.GetFormatterWithVerify<NewsList>().Serialize(ref writer, value.appnews, formatterResolver);
			writer.WriteEndObject();
		}

		public NewsRaw Deserialize(ref JsonReader reader, IJsonFormatterResolver formatterResolver)
		{
			if (reader.ReadIsNull())
			{
				throw new InvalidOperationException("typecode is null, struct not supported");
			}
			NewsList appnews = default;
			int count = 0;
			reader.ReadIsBeginObjectWithVerify();
			while (!reader.ReadIsEndObjectWithSkipValueSeparator(ref count))
			{
				ArraySegment<byte> key = reader.ReadPropertyNameSegmentRaw();
				if (!____keyMapping.TryGetValueSafe(key, out var value))
				{
					reader.ReadNextBlock();
				}
				else if (value == 0)
				{
					appnews = formatterResolver.GetFormatterWithVerify<NewsList>().Deserialize(ref reader, formatterResolver);
				}
				else
				{
					reader.ReadNextBlock();
				}
			}
			return new NewsRaw(appnews);
		}
	}
}
