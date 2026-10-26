using System;
using Utf8Json.Internal;

namespace Utf8Json.Formatters
{
	public sealed class NewsListFormatter : IJsonFormatter<NewsList>, IJsonFormatter
	{
		private readonly AutomataDictionary ____keyMapping;

		private readonly byte[][] ____stringByteKeys;

		public NewsListFormatter()
		{
			____keyMapping = new AutomataDictionary
			{
				{
					JsonWriter.GetEncodedPropertyNameWithoutQuotation("appid"),
					0
				},
				{
					JsonWriter.GetEncodedPropertyNameWithoutQuotation("newsitems"),
					1
				},
				{
					JsonWriter.GetEncodedPropertyNameWithoutQuotation("count"),
					2
				}
			};
			____stringByteKeys = new byte[3][]
			{
				JsonWriter.GetEncodedPropertyNameWithBeginObject("appid"),
				JsonWriter.GetEncodedPropertyNameWithPrefixValueSeparator("newsitems"),
				JsonWriter.GetEncodedPropertyNameWithPrefixValueSeparator("count")
			};
		}

		public void Serialize(ref JsonWriter writer, NewsList value, IJsonFormatterResolver formatterResolver)
		{
			writer.WriteRaw(____stringByteKeys[0]);
			writer.WriteInt32(value.appid);
			writer.WriteRaw(____stringByteKeys[1]);
			formatterResolver.GetFormatterWithVerify<NewsListItem[]>().Serialize(ref writer, value.newsitems, formatterResolver);
			writer.WriteRaw(____stringByteKeys[2]);
			writer.WriteInt32(value.count);
			writer.WriteEndObject();
		}

		public NewsList Deserialize(ref JsonReader reader, IJsonFormatterResolver formatterResolver)
		{
			if (reader.ReadIsNull())
			{
				throw new InvalidOperationException("typecode is null, struct not supported");
			}
			int appid = 0;
			NewsListItem[] newsitems = null;
			int count = 0;
			int count2 = 0;
			reader.ReadIsBeginObjectWithVerify();
			while (!reader.ReadIsEndObjectWithSkipValueSeparator(ref count2))
			{
				ArraySegment<byte> key = reader.ReadPropertyNameSegmentRaw();
				if (!____keyMapping.TryGetValueSafe(key, out var value))
				{
					reader.ReadNextBlock();
					continue;
				}
				switch (value)
				{
				case 0:
					appid = reader.ReadInt32();
					break;
				case 1:
					newsitems = formatterResolver.GetFormatterWithVerify<NewsListItem[]>().Deserialize(ref reader, formatterResolver);
					break;
				case 2:
					count = reader.ReadInt32();
					break;
				default:
					reader.ReadNextBlock();
					break;
				}
			}
			return new NewsList(appid, newsitems, count);
		}
	}
}
