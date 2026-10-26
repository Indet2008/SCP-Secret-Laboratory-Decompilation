using System;
using Utf8Json.Internal;

namespace Utf8Json.Formatters
{
	public sealed class CreditsListCategoryFormatter : IJsonFormatter<CreditsListCategory>, IJsonFormatter
	{
		private readonly AutomataDictionary ____keyMapping;

		private readonly byte[][] ____stringByteKeys;

		public CreditsListCategoryFormatter()
		{
			____keyMapping = new AutomataDictionary
			{
				{
					JsonWriter.GetEncodedPropertyNameWithoutQuotation("category"),
					0
				},
				{
					JsonWriter.GetEncodedPropertyNameWithoutQuotation("members"),
					1
				}
			};
			____stringByteKeys = new byte[2][]
			{
				JsonWriter.GetEncodedPropertyNameWithBeginObject("category"),
				JsonWriter.GetEncodedPropertyNameWithPrefixValueSeparator("members")
			};
		}

		public void Serialize(ref JsonWriter writer, CreditsListCategory value, IJsonFormatterResolver formatterResolver)
		{
			writer.WriteRaw(____stringByteKeys[0]);
			writer.WriteString(value.category);
			writer.WriteRaw(____stringByteKeys[1]);
			formatterResolver.GetFormatterWithVerify<CreditsListMember[]>().Serialize(ref writer, value.members, formatterResolver);
			writer.WriteEndObject();
		}

		public CreditsListCategory Deserialize(ref JsonReader reader, IJsonFormatterResolver formatterResolver)
		{
			if (reader.ReadIsNull())
			{
				throw new InvalidOperationException("typecode is null, struct not supported");
			}
			string category = null;
			CreditsListMember[] members = null;
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
					category = reader.ReadString();
					break;
				case 1:
					members = formatterResolver.GetFormatterWithVerify<CreditsListMember[]>().Deserialize(ref reader, formatterResolver);
					break;
				default:
					reader.ReadNextBlock();
					break;
				}
			}
			return new CreditsListCategory(category, members);
		}
	}
}
