using System;
using Utf8Json.Internal;

namespace Utf8Json.Formatters
{
	public sealed class SignedTokenFormatter : IJsonFormatter<SignedToken>, IJsonFormatter
	{
		private readonly AutomataDictionary ____keyMapping;

		private readonly byte[][] ____stringByteKeys;

		public SignedTokenFormatter()
		{
			____keyMapping = new AutomataDictionary
			{
				{
					JsonWriter.GetEncodedPropertyNameWithoutQuotation("token"),
					0
				},
				{
					JsonWriter.GetEncodedPropertyNameWithoutQuotation("signature"),
					1
				}
			};
			____stringByteKeys = new byte[2][]
			{
				JsonWriter.GetEncodedPropertyNameWithBeginObject("token"),
				JsonWriter.GetEncodedPropertyNameWithPrefixValueSeparator("signature")
			};
		}

		public void Serialize(ref JsonWriter writer, SignedToken value, IJsonFormatterResolver formatterResolver)
		{
			if (value == null)
			{
				writer.WriteNull();
				return;
			}
			writer.WriteRaw(____stringByteKeys[0]);
			writer.WriteString(value.token);
			writer.WriteRaw(____stringByteKeys[1]);
			writer.WriteString(value.signature);
			writer.WriteEndObject();
		}

		public SignedToken Deserialize(ref JsonReader reader, IJsonFormatterResolver formatterResolver)
		{
			if (reader.ReadIsNull())
			{
				return null;
			}
			string token = null;
			string signature = null;
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
					token = reader.ReadString();
					break;
				case 1:
					signature = reader.ReadString();
					break;
				default:
					reader.ReadNextBlock();
					break;
				}
			}
			return new SignedToken(token, signature);
		}
	}
}
