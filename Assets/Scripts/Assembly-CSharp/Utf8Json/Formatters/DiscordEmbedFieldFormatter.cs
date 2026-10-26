using System;
using Utf8Json.Internal;

namespace Utf8Json.Formatters
{
	public sealed class DiscordEmbedFieldFormatter : IJsonFormatter<DiscordEmbedField>, IJsonFormatter
	{
		private readonly AutomataDictionary ____keyMapping;

		private readonly byte[][] ____stringByteKeys;

		public DiscordEmbedFieldFormatter()
		{
			____keyMapping = new AutomataDictionary
			{
				{
					JsonWriter.GetEncodedPropertyNameWithoutQuotation("name"),
					0
				},
				{
					JsonWriter.GetEncodedPropertyNameWithoutQuotation("value"),
					1
				},
				{
					JsonWriter.GetEncodedPropertyNameWithoutQuotation("inline"),
					2
				}
			};
			____stringByteKeys = new byte[3][]
			{
				JsonWriter.GetEncodedPropertyNameWithBeginObject("name"),
				JsonWriter.GetEncodedPropertyNameWithPrefixValueSeparator("value"),
				JsonWriter.GetEncodedPropertyNameWithPrefixValueSeparator("inline")
			};
		}

		public void Serialize(ref JsonWriter writer, DiscordEmbedField value, IJsonFormatterResolver formatterResolver)
		{
			writer.WriteRaw(____stringByteKeys[0]);
			writer.WriteString(value.name);
			writer.WriteRaw(____stringByteKeys[1]);
			writer.WriteString(value.value);
			writer.WriteRaw(____stringByteKeys[2]);
			writer.WriteBoolean(value.inline);
			writer.WriteEndObject();
		}

		public DiscordEmbedField Deserialize(ref JsonReader reader, IJsonFormatterResolver formatterResolver)
		{
			if (reader.ReadIsNull())
			{
				throw new InvalidOperationException("typecode is null, struct not supported");
			}
			string name = null;
			string value = null;
			bool inline = false;
			int count = 0;
			reader.ReadIsBeginObjectWithVerify();
			while (!reader.ReadIsEndObjectWithSkipValueSeparator(ref count))
			{
				ArraySegment<byte> key = reader.ReadPropertyNameSegmentRaw();
				if (!____keyMapping.TryGetValueSafe(key, out var value2))
				{
					reader.ReadNextBlock();
					continue;
				}
				switch (value2)
				{
				case 0:
					name = reader.ReadString();
					break;
				case 1:
					value = reader.ReadString();
					break;
				case 2:
					inline = reader.ReadBoolean();
					break;
				default:
					reader.ReadNextBlock();
					break;
				}
			}
			return new DiscordEmbedField(name, value, inline);
		}
	}
}
