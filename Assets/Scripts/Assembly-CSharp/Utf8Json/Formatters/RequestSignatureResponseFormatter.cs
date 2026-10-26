using System;
using Utf8Json.Internal;

namespace Utf8Json.Formatters
{
	public sealed class RequestSignatureResponseFormatter : IJsonFormatter<RequestSignatureResponse>, IJsonFormatter
	{
		private readonly AutomataDictionary ____keyMapping;

		private readonly byte[][] ____stringByteKeys;

		public RequestSignatureResponseFormatter()
		{
			____keyMapping = new AutomataDictionary
			{
				{
					JsonWriter.GetEncodedPropertyNameWithoutQuotation("success"),
					0
				},
				{
					JsonWriter.GetEncodedPropertyNameWithoutQuotation("error"),
					1
				},
				{
					JsonWriter.GetEncodedPropertyNameWithoutQuotation("authToken"),
					2
				},
				{
					JsonWriter.GetEncodedPropertyNameWithoutQuotation("badgeToken"),
					3
				},
				{
					JsonWriter.GetEncodedPropertyNameWithoutQuotation("nonce"),
					4
				}
			};
			____stringByteKeys = new byte[5][]
			{
				JsonWriter.GetEncodedPropertyNameWithBeginObject("success"),
				JsonWriter.GetEncodedPropertyNameWithPrefixValueSeparator("error"),
				JsonWriter.GetEncodedPropertyNameWithPrefixValueSeparator("authToken"),
				JsonWriter.GetEncodedPropertyNameWithPrefixValueSeparator("badgeToken"),
				JsonWriter.GetEncodedPropertyNameWithPrefixValueSeparator("nonce")
			};
		}

		public void Serialize(ref JsonWriter writer, RequestSignatureResponse value, IJsonFormatterResolver formatterResolver)
		{
			writer.WriteRaw(____stringByteKeys[0]);
			writer.WriteBoolean(value.success);
			writer.WriteRaw(____stringByteKeys[1]);
			writer.WriteString(value.error);
			writer.WriteRaw(____stringByteKeys[2]);
			formatterResolver.GetFormatterWithVerify<SignedToken>().Serialize(ref writer, value.authToken, formatterResolver);
			writer.WriteRaw(____stringByteKeys[3]);
			formatterResolver.GetFormatterWithVerify<SignedToken>().Serialize(ref writer, value.badgeToken, formatterResolver);
			writer.WriteRaw(____stringByteKeys[4]);
			writer.WriteString(value.nonce);
			writer.WriteEndObject();
		}

		public RequestSignatureResponse Deserialize(ref JsonReader reader, IJsonFormatterResolver formatterResolver)
		{
			if (reader.ReadIsNull())
			{
				throw new InvalidOperationException("typecode is null, struct not supported");
			}
			bool success = false;
			string error = null;
			SignedToken authToken = null;
			SignedToken badgeToken = null;
			string nonce = null;
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
					success = reader.ReadBoolean();
					break;
				case 1:
					error = reader.ReadString();
					break;
				case 2:
					authToken = formatterResolver.GetFormatterWithVerify<SignedToken>().Deserialize(ref reader, formatterResolver);
					break;
				case 3:
					badgeToken = formatterResolver.GetFormatterWithVerify<SignedToken>().Deserialize(ref reader, formatterResolver);
					break;
				case 4:
					nonce = reader.ReadString();
					break;
				default:
					reader.ReadNextBlock();
					break;
				}
			}
			return new RequestSignatureResponse(success, error, authToken, badgeToken, nonce);
		}
	}
}
