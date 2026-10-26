using System;
using Utf8Json.Internal;

namespace Utf8Json.Formatters
{
	public sealed class ServerListSignedFormatter : IJsonFormatter<ServerListSigned>, IJsonFormatter
	{
		private readonly AutomataDictionary ____keyMapping;

		private readonly byte[][] ____stringByteKeys;

		public ServerListSignedFormatter()
		{
			____keyMapping = new AutomataDictionary
			{
				{
					JsonWriter.GetEncodedPropertyNameWithoutQuotation("payload"),
					0
				},
				{
					JsonWriter.GetEncodedPropertyNameWithoutQuotation("timestamp"),
					1
				},
				{
					JsonWriter.GetEncodedPropertyNameWithoutQuotation("signature"),
					2
				},
				{
					JsonWriter.GetEncodedPropertyNameWithoutQuotation("nonce"),
					3
				},
				{
					JsonWriter.GetEncodedPropertyNameWithoutQuotation("error"),
					4
				}
			};
			____stringByteKeys = new byte[5][]
			{
				JsonWriter.GetEncodedPropertyNameWithBeginObject("payload"),
				JsonWriter.GetEncodedPropertyNameWithPrefixValueSeparator("timestamp"),
				JsonWriter.GetEncodedPropertyNameWithPrefixValueSeparator("signature"),
				JsonWriter.GetEncodedPropertyNameWithPrefixValueSeparator("nonce"),
				JsonWriter.GetEncodedPropertyNameWithPrefixValueSeparator("error")
			};
		}

		public void Serialize(ref JsonWriter writer, ServerListSigned value, IJsonFormatterResolver formatterResolver)
		{
			writer.WriteRaw(____stringByteKeys[0]);
			writer.WriteString(value.payload);
			writer.WriteRaw(____stringByteKeys[1]);
			writer.WriteInt64(value.timestamp);
			writer.WriteRaw(____stringByteKeys[2]);
			writer.WriteString(value.signature);
			writer.WriteRaw(____stringByteKeys[3]);
			writer.WriteString(value.nonce);
			writer.WriteRaw(____stringByteKeys[4]);
			writer.WriteString(value.error);
			writer.WriteEndObject();
		}

		public ServerListSigned Deserialize(ref JsonReader reader, IJsonFormatterResolver formatterResolver)
		{
			if (reader.ReadIsNull())
			{
				throw new InvalidOperationException("typecode is null, struct not supported");
			}
			string payload = null;
			long timestamp = 0L;
			string signature = null;
			string nonce = null;
			string error = null;
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
					payload = reader.ReadString();
					break;
				case 1:
					timestamp = reader.ReadInt64();
					break;
				case 2:
					signature = reader.ReadString();
					break;
				case 3:
					nonce = reader.ReadString();
					break;
				case 4:
					error = reader.ReadString();
					break;
				default:
					reader.ReadNextBlock();
					break;
				}
			}
			return new ServerListSigned(payload, timestamp, signature, nonce, error);
		}
	}
}
