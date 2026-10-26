using System;
using Utf8Json.Internal;

namespace Utf8Json.Formatters
{
	public sealed class TokenFormatter : IJsonFormatter<Token>, IJsonFormatter
	{
		private readonly AutomataDictionary ____keyMapping;

		private readonly byte[][] ____stringByteKeys;

		public TokenFormatter()
		{
			____keyMapping = new AutomataDictionary
			{
				{
					JsonWriter.GetEncodedPropertyNameWithoutQuotation("UserId"),
					0
				},
				{
					JsonWriter.GetEncodedPropertyNameWithoutQuotation("Nickname"),
					1
				},
				{
					JsonWriter.GetEncodedPropertyNameWithoutQuotation("IssuanceTime"),
					2
				},
				{
					JsonWriter.GetEncodedPropertyNameWithoutQuotation("ExpirationTime"),
					3
				},
				{
					JsonWriter.GetEncodedPropertyNameWithoutQuotation("Usage"),
					4
				},
				{
					JsonWriter.GetEncodedPropertyNameWithoutQuotation("IssuedBy"),
					5
				},
				{
					JsonWriter.GetEncodedPropertyNameWithoutQuotation("Serial"),
					6
				},
				{
					JsonWriter.GetEncodedPropertyNameWithoutQuotation("TestSignature"),
					7
				},
				{
					JsonWriter.GetEncodedPropertyNameWithoutQuotation("TokenVersion"),
					8
				}
			};
			____stringByteKeys = new byte[9][]
			{
				JsonWriter.GetEncodedPropertyNameWithBeginObject("UserId"),
				JsonWriter.GetEncodedPropertyNameWithPrefixValueSeparator("Nickname"),
				JsonWriter.GetEncodedPropertyNameWithPrefixValueSeparator("IssuanceTime"),
				JsonWriter.GetEncodedPropertyNameWithPrefixValueSeparator("ExpirationTime"),
				JsonWriter.GetEncodedPropertyNameWithPrefixValueSeparator("Usage"),
				JsonWriter.GetEncodedPropertyNameWithPrefixValueSeparator("IssuedBy"),
				JsonWriter.GetEncodedPropertyNameWithPrefixValueSeparator("Serial"),
				JsonWriter.GetEncodedPropertyNameWithPrefixValueSeparator("TestSignature"),
				JsonWriter.GetEncodedPropertyNameWithPrefixValueSeparator("TokenVersion")
			};
		}

		public void Serialize(ref JsonWriter writer, Token value, IJsonFormatterResolver formatterResolver)
		{
			if (value == null)
			{
				writer.WriteNull();
				return;
			}
			writer.WriteRaw(____stringByteKeys[0]);
			writer.WriteString(value.UserId);
			writer.WriteRaw(____stringByteKeys[1]);
			writer.WriteString(value.Nickname);
			writer.WriteRaw(____stringByteKeys[2]);
			formatterResolver.GetFormatterWithVerify<DateTimeOffset>().Serialize(ref writer, value.IssuanceTime, formatterResolver);
			writer.WriteRaw(____stringByteKeys[3]);
			formatterResolver.GetFormatterWithVerify<DateTimeOffset>().Serialize(ref writer, value.ExpirationTime, formatterResolver);
			writer.WriteRaw(____stringByteKeys[4]);
			writer.WriteString(value.Usage);
			writer.WriteRaw(____stringByteKeys[5]);
			writer.WriteString(value.IssuedBy);
			writer.WriteRaw(____stringByteKeys[6]);
			writer.WriteString(value.Serial);
			writer.WriteRaw(____stringByteKeys[7]);
			writer.WriteBoolean(value.TestSignature);
			writer.WriteRaw(____stringByteKeys[8]);
			writer.WriteInt32(value.TokenVersion);
			writer.WriteEndObject();
		}

		public Token Deserialize(ref JsonReader reader, IJsonFormatterResolver formatterResolver)
		{
			if (reader.ReadIsNull())
			{
				return null;
			}
			throw new InvalidOperationException("generated serializer for IInterface does not support deserialize.");
		}
	}
}
