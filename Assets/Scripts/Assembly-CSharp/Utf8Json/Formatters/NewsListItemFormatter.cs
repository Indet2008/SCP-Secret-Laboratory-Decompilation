using System;
using Utf8Json.Internal;

namespace Utf8Json.Formatters
{
	public sealed class NewsListItemFormatter : IJsonFormatter<NewsListItem>, IJsonFormatter
	{
		private readonly AutomataDictionary ____keyMapping;

		private readonly byte[][] ____stringByteKeys;

		public NewsListItemFormatter()
		{
			____keyMapping = new AutomataDictionary
			{
				{
					JsonWriter.GetEncodedPropertyNameWithoutQuotation("gid"),
					0
				},
				{
					JsonWriter.GetEncodedPropertyNameWithoutQuotation("title"),
					1
				},
				{
					JsonWriter.GetEncodedPropertyNameWithoutQuotation("url"),
					2
				},
				{
					JsonWriter.GetEncodedPropertyNameWithoutQuotation("is_external_url"),
					3
				},
				{
					JsonWriter.GetEncodedPropertyNameWithoutQuotation("author"),
					4
				},
				{
					JsonWriter.GetEncodedPropertyNameWithoutQuotation("contents"),
					5
				},
				{
					JsonWriter.GetEncodedPropertyNameWithoutQuotation("feedlabel"),
					6
				},
				{
					JsonWriter.GetEncodedPropertyNameWithoutQuotation("date"),
					7
				},
				{
					JsonWriter.GetEncodedPropertyNameWithoutQuotation("feedname"),
					8
				},
				{
					JsonWriter.GetEncodedPropertyNameWithoutQuotation("feedtype"),
					9
				}
			};
			____stringByteKeys = new byte[10][]
			{
				JsonWriter.GetEncodedPropertyNameWithBeginObject("gid"),
				JsonWriter.GetEncodedPropertyNameWithPrefixValueSeparator("title"),
				JsonWriter.GetEncodedPropertyNameWithPrefixValueSeparator("url"),
				JsonWriter.GetEncodedPropertyNameWithPrefixValueSeparator("is_external_url"),
				JsonWriter.GetEncodedPropertyNameWithPrefixValueSeparator("author"),
				JsonWriter.GetEncodedPropertyNameWithPrefixValueSeparator("contents"),
				JsonWriter.GetEncodedPropertyNameWithPrefixValueSeparator("feedlabel"),
				JsonWriter.GetEncodedPropertyNameWithPrefixValueSeparator("date"),
				JsonWriter.GetEncodedPropertyNameWithPrefixValueSeparator("feedname"),
				JsonWriter.GetEncodedPropertyNameWithPrefixValueSeparator("feedtype")
			};
		}

		public void Serialize(ref JsonWriter writer, NewsListItem value, IJsonFormatterResolver formatterResolver)
		{
			writer.WriteRaw(____stringByteKeys[0]);
			writer.WriteString(value.gid);
			writer.WriteRaw(____stringByteKeys[1]);
			writer.WriteString(value.title);
			writer.WriteRaw(____stringByteKeys[2]);
			writer.WriteString(value.url);
			writer.WriteRaw(____stringByteKeys[3]);
			writer.WriteBoolean(value.is_external_url);
			writer.WriteRaw(____stringByteKeys[4]);
			writer.WriteString(value.author);
			writer.WriteRaw(____stringByteKeys[5]);
			writer.WriteString(value.contents);
			writer.WriteRaw(____stringByteKeys[6]);
			writer.WriteString(value.feedlabel);
			writer.WriteRaw(____stringByteKeys[7]);
			writer.WriteInt64(value.date);
			writer.WriteRaw(____stringByteKeys[8]);
			writer.WriteString(value.feedname);
			writer.WriteRaw(____stringByteKeys[9]);
			writer.WriteInt32(value.feedtype);
			writer.WriteEndObject();
		}

		public NewsListItem Deserialize(ref JsonReader reader, IJsonFormatterResolver formatterResolver)
		{
			if (reader.ReadIsNull())
			{
				throw new InvalidOperationException("typecode is null, struct not supported");
			}
			string gid = null;
			string title = null;
			string url = null;
			bool is_external_url = false;
			string author = null;
			string contents = null;
			string feedlabel = null;
			long date = 0L;
			string feedname = null;
			int feedtype = 0;
			int count = 0;
			reader.ReadIsBeginObjectWithVerify();
			while (!reader.ReadIsEndObjectWithSkipValueSeparator(ref count))
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
					gid = reader.ReadString();
					break;
				case 1:
					title = reader.ReadString();
					break;
				case 2:
					url = reader.ReadString();
					break;
				case 3:
					is_external_url = reader.ReadBoolean();
					break;
				case 4:
					author = reader.ReadString();
					break;
				case 5:
					contents = reader.ReadString();
					break;
				case 6:
					feedlabel = reader.ReadString();
					break;
				case 7:
					date = reader.ReadInt64();
					break;
				case 8:
					feedname = reader.ReadString();
					break;
				case 9:
					feedtype = reader.ReadInt32();
					break;
				default:
					reader.ReadNextBlock();
					break;
				}
			}
			return new NewsListItem(gid, title, url, is_external_url, author, contents, feedlabel, date, feedname, feedtype);
		}
	}
}
