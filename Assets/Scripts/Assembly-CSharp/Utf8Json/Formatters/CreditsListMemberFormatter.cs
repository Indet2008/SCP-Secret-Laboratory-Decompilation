using System;
using Utf8Json.Internal;

namespace Utf8Json.Formatters
{
	public sealed class CreditsListMemberFormatter : IJsonFormatter<CreditsListMember>, IJsonFormatter
	{
		private readonly AutomataDictionary ____keyMapping;

		private readonly byte[][] ____stringByteKeys;

		public CreditsListMemberFormatter()
		{
			____keyMapping = new AutomataDictionary
			{
				{
					JsonWriter.GetEncodedPropertyNameWithoutQuotation("name"),
					0
				},
				{
					JsonWriter.GetEncodedPropertyNameWithoutQuotation("title"),
					1
				},
				{
					JsonWriter.GetEncodedPropertyNameWithoutQuotation("color"),
					2
				}
			};
			____stringByteKeys = new byte[3][]
			{
				JsonWriter.GetEncodedPropertyNameWithBeginObject("name"),
				JsonWriter.GetEncodedPropertyNameWithPrefixValueSeparator("title"),
				JsonWriter.GetEncodedPropertyNameWithPrefixValueSeparator("color")
			};
		}

		public void Serialize(ref JsonWriter writer, CreditsListMember value, IJsonFormatterResolver formatterResolver)
		{
			writer.WriteRaw(____stringByteKeys[0]);
			writer.WriteString(value.name);
			writer.WriteRaw(____stringByteKeys[1]);
			writer.WriteString(value.title);
			writer.WriteRaw(____stringByteKeys[2]);
			writer.WriteString(value.color);
			writer.WriteEndObject();
		}

		public CreditsListMember Deserialize(ref JsonReader reader, IJsonFormatterResolver formatterResolver)
		{
			if (reader.ReadIsNull())
			{
				throw new InvalidOperationException("typecode is null, struct not supported");
			}
			string name = null;
			string title = null;
			string color = null;
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
					name = reader.ReadString();
					break;
				case 1:
					title = reader.ReadString();
					break;
				case 2:
					color = reader.ReadString();
					break;
				default:
					reader.ReadNextBlock();
					break;
				}
			}
			return new CreditsListMember(name, title, color);
		}
	}
}
