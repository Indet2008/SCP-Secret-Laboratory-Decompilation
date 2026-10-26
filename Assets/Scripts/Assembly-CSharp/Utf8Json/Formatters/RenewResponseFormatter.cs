using System;
using Utf8Json.Internal;

namespace Utf8Json.Formatters
{
	public sealed class RenewResponseFormatter : IJsonFormatter<RenewResponse>, IJsonFormatter
	{
		private readonly AutomataDictionary ____keyMapping;

		private readonly byte[][] ____stringByteKeys;

		public RenewResponseFormatter()
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
					JsonWriter.GetEncodedPropertyNameWithoutQuotation("id"),
					2
				},
				{
					JsonWriter.GetEncodedPropertyNameWithoutQuotation("nonce"),
					3
				},
				{
					JsonWriter.GetEncodedPropertyNameWithoutQuotation("country"),
					4
				},
				{
					JsonWriter.GetEncodedPropertyNameWithoutQuotation("flags"),
					5
				},
				{
					JsonWriter.GetEncodedPropertyNameWithoutQuotation("expiration"),
					6
				},
				{
					JsonWriter.GetEncodedPropertyNameWithoutQuotation("preauth"),
					7
				},
				{
					JsonWriter.GetEncodedPropertyNameWithoutQuotation("globalBan"),
					8
				},
				{
					JsonWriter.GetEncodedPropertyNameWithoutQuotation("lifetime"),
					9
				}
			};
			____stringByteKeys = new byte[10][]
			{
				JsonWriter.GetEncodedPropertyNameWithBeginObject("success"),
				JsonWriter.GetEncodedPropertyNameWithPrefixValueSeparator("error"),
				JsonWriter.GetEncodedPropertyNameWithPrefixValueSeparator("id"),
				JsonWriter.GetEncodedPropertyNameWithPrefixValueSeparator("nonce"),
				JsonWriter.GetEncodedPropertyNameWithPrefixValueSeparator("country"),
				JsonWriter.GetEncodedPropertyNameWithPrefixValueSeparator("flags"),
				JsonWriter.GetEncodedPropertyNameWithPrefixValueSeparator("expiration"),
				JsonWriter.GetEncodedPropertyNameWithPrefixValueSeparator("preauth"),
				JsonWriter.GetEncodedPropertyNameWithPrefixValueSeparator("globalBan"),
				JsonWriter.GetEncodedPropertyNameWithPrefixValueSeparator("lifetime")
			};
		}

		public void Serialize(ref JsonWriter writer, RenewResponse value, IJsonFormatterResolver formatterResolver)
		{
			writer.WriteRaw(____stringByteKeys[0]);
			writer.WriteBoolean(value.success);
			writer.WriteRaw(____stringByteKeys[1]);
			writer.WriteString(value.error);
			writer.WriteRaw(____stringByteKeys[2]);
			writer.WriteString(value.id);
			writer.WriteRaw(____stringByteKeys[3]);
			writer.WriteString(value.nonce);
			writer.WriteRaw(____stringByteKeys[4]);
			writer.WriteString(value.country);
			writer.WriteRaw(____stringByteKeys[5]);
			writer.WriteByte(value.flags);
			writer.WriteRaw(____stringByteKeys[6]);
			writer.WriteInt64(value.expiration);
			writer.WriteRaw(____stringByteKeys[7]);
			writer.WriteString(value.preauth);
			writer.WriteRaw(____stringByteKeys[8]);
			writer.WriteString(value.globalBan);
			writer.WriteRaw(____stringByteKeys[9]);
			writer.WriteUInt16(value.lifetime);
			writer.WriteEndObject();
		}

		public RenewResponse Deserialize(ref JsonReader reader, IJsonFormatterResolver formatterResolver)
		{
			if (reader.ReadIsNull())
			{
				throw new InvalidOperationException("typecode is null, struct not supported");
			}
			bool success = false;
			string error = null;
			string id = null;
			string nonce = null;
			string country = null;
			byte flags = 0;
			long expiration = 0L;
			string preauth = null;
			string globalBan = null;
			ushort lifetime = 0;
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
					id = reader.ReadString();
					break;
				case 3:
					nonce = reader.ReadString();
					break;
				case 4:
					country = reader.ReadString();
					break;
				case 5:
					flags = reader.ReadByte();
					break;
				case 6:
					expiration = reader.ReadInt64();
					break;
				case 7:
					preauth = reader.ReadString();
					break;
				case 8:
					globalBan = reader.ReadString();
					break;
				case 9:
					lifetime = reader.ReadUInt16();
					break;
				default:
					reader.ReadNextBlock();
					break;
				}
			}
			return new RenewResponse(success, error, id, nonce, country, flags, expiration, preauth, globalBan, lifetime);
		}
	}
}
