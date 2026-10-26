using System;
using Utf8Json.Internal;

namespace Utf8Json.Formatters
{
	public sealed class PublicKeyResponseFormatter : IJsonFormatter<PublicKeyResponse>, IJsonFormatter
	{
		private readonly AutomataDictionary ____keyMapping;

		private readonly byte[][] ____stringByteKeys;

		public PublicKeyResponseFormatter()
		{
			____keyMapping = new AutomataDictionary
			{
				{
					JsonWriter.GetEncodedPropertyNameWithoutQuotation("key"),
					0
				},
				{
					JsonWriter.GetEncodedPropertyNameWithoutQuotation("signature"),
					1
				},
				{
					JsonWriter.GetEncodedPropertyNameWithoutQuotation("credits"),
					2
				}
			};
			____stringByteKeys = new byte[3][]
			{
				JsonWriter.GetEncodedPropertyNameWithBeginObject("key"),
				JsonWriter.GetEncodedPropertyNameWithPrefixValueSeparator("signature"),
				JsonWriter.GetEncodedPropertyNameWithPrefixValueSeparator("credits")
			};
		}

		public void Serialize(ref JsonWriter writer, PublicKeyResponse value, IJsonFormatterResolver formatterResolver)
		{
			writer.WriteRaw(____stringByteKeys[0]);
			writer.WriteString(value.key);
			writer.WriteRaw(____stringByteKeys[1]);
			writer.WriteString(value.signature);
			writer.WriteRaw(____stringByteKeys[2]);
			writer.WriteString(value.credits);
			writer.WriteEndObject();
		}

		public PublicKeyResponse Deserialize(ref JsonReader reader, IJsonFormatterResolver formatterResolver)
		{
			if (reader.ReadIsNull())
			{
				throw new InvalidOperationException("typecode is null, struct not supported");
			}
			string key = null;
			string signature = null;
			string credits = null;
			int count = 0;
			reader.ReadIsBeginObjectWithVerify();
			while (!reader.ReadIsEndObjectWithSkipValueSeparator(ref count))
			{
				ArraySegment<byte> key2 = reader.ReadPropertyNameSegmentRaw();
				if (!____keyMapping.TryGetValueSafe(key2, out var value))
				{
					reader.ReadNextBlock();
					continue;
				}
				switch (value)
				{
				case 0:
					key = reader.ReadString();
					break;
				case 1:
					signature = reader.ReadString();
					break;
				case 2:
					credits = reader.ReadString();
					break;
				default:
					reader.ReadNextBlock();
					break;
				}
			}
			return new PublicKeyResponse(key, signature, credits);
		}
	}
}
