using System;
using Utf8Json.Internal;

namespace Utf8Json.Formatters
{
	public sealed class AuthenticateResponseFormatter : IJsonFormatter<AuthenticateResponse>, IJsonFormatter
	{
		private readonly AutomataDictionary ____keyMapping;

		private readonly byte[][] ____stringByteKeys;

		public AuthenticateResponseFormatter()
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
					JsonWriter.GetEncodedPropertyNameWithoutQuotation("token"),
					2
				},
				{
					JsonWriter.GetEncodedPropertyNameWithoutQuotation("id"),
					3
				},
				{
					JsonWriter.GetEncodedPropertyNameWithoutQuotation("nonce"),
					4
				},
				{
					JsonWriter.GetEncodedPropertyNameWithoutQuotation("country"),
					5
				},
				{
					JsonWriter.GetEncodedPropertyNameWithoutQuotation("flags"),
					6
				},
				{
					JsonWriter.GetEncodedPropertyNameWithoutQuotation("expiration"),
					7
				},
				{
					JsonWriter.GetEncodedPropertyNameWithoutQuotation("preauth"),
					8
				},
				{
					JsonWriter.GetEncodedPropertyNameWithoutQuotation("globalBan"),
					9
				},
				{
					JsonWriter.GetEncodedPropertyNameWithoutQuotation("lifetime"),
					10
				},
				{
					JsonWriter.GetEncodedPropertyNameWithoutQuotation("NoWatermarking"),
					11
				}
			};
			____stringByteKeys = new byte[12][]
			{
				JsonWriter.GetEncodedPropertyNameWithBeginObject("success"),
				JsonWriter.GetEncodedPropertyNameWithPrefixValueSeparator("error"),
				JsonWriter.GetEncodedPropertyNameWithPrefixValueSeparator("token"),
				JsonWriter.GetEncodedPropertyNameWithPrefixValueSeparator("id"),
				JsonWriter.GetEncodedPropertyNameWithPrefixValueSeparator("nonce"),
				JsonWriter.GetEncodedPropertyNameWithPrefixValueSeparator("country"),
				JsonWriter.GetEncodedPropertyNameWithPrefixValueSeparator("flags"),
				JsonWriter.GetEncodedPropertyNameWithPrefixValueSeparator("expiration"),
				JsonWriter.GetEncodedPropertyNameWithPrefixValueSeparator("preauth"),
				JsonWriter.GetEncodedPropertyNameWithPrefixValueSeparator("globalBan"),
				JsonWriter.GetEncodedPropertyNameWithPrefixValueSeparator("lifetime"),
				JsonWriter.GetEncodedPropertyNameWithPrefixValueSeparator("NoWatermarking")
			};
		}

		public void Serialize(ref JsonWriter writer, AuthenticateResponse value, IJsonFormatterResolver formatterResolver)
		{
			writer.WriteRaw(____stringByteKeys[0]);
			writer.WriteBoolean(value.success);
			writer.WriteRaw(____stringByteKeys[1]);
			writer.WriteString(value.error);
			writer.WriteRaw(____stringByteKeys[2]);
			writer.WriteString(value.token);
			writer.WriteRaw(____stringByteKeys[3]);
			writer.WriteString(value.id);
			writer.WriteRaw(____stringByteKeys[4]);
			writer.WriteString(value.nonce);
			writer.WriteRaw(____stringByteKeys[5]);
			writer.WriteString(value.country);
			writer.WriteRaw(____stringByteKeys[6]);
			writer.WriteByte(value.flags);
			writer.WriteRaw(____stringByteKeys[7]);
			writer.WriteInt64(value.expiration);
			writer.WriteRaw(____stringByteKeys[8]);
			writer.WriteString(value.preauth);
			writer.WriteRaw(____stringByteKeys[9]);
			writer.WriteString(value.globalBan);
			writer.WriteRaw(____stringByteKeys[10]);
			writer.WriteUInt16(value.lifetime);
			writer.WriteRaw(____stringByteKeys[11]);
			writer.WriteBoolean(value.NoWatermarking);
			writer.WriteEndObject();
		}

		public AuthenticateResponse Deserialize(ref JsonReader reader, IJsonFormatterResolver formatterResolver)
		{
			if (reader.ReadIsNull())
			{
				throw new InvalidOperationException("typecode is null, struct not supported");
			}
			bool success = false;
			string error = null;
			string token = null;
			string id = null;
			string nonce = null;
			string country = null;
			byte flags = 0;
			long expiration = 0L;
			string preauth = null;
			string globalBan = null;
			ushort lifetime = 0;
			bool noWatermarking = false;
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
					token = reader.ReadString();
					break;
				case 3:
					id = reader.ReadString();
					break;
				case 4:
					nonce = reader.ReadString();
					break;
				case 5:
					country = reader.ReadString();
					break;
				case 6:
					flags = reader.ReadByte();
					break;
				case 7:
					expiration = reader.ReadInt64();
					break;
				case 8:
					preauth = reader.ReadString();
					break;
				case 9:
					globalBan = reader.ReadString();
					break;
				case 10:
					lifetime = reader.ReadUInt16();
					break;
				case 11:
					noWatermarking = reader.ReadBoolean();
					break;
				default:
					reader.ReadNextBlock();
					break;
				}
			}
			return new AuthenticateResponse(success, error, token, id, nonce, country, flags, expiration, preauth, globalBan, lifetime, noWatermarking);
		}
	}
}
