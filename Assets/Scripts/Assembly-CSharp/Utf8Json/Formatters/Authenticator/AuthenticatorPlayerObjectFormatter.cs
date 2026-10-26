using System;
using Authenticator;
using Utf8Json.Internal;

namespace Utf8Json.Formatters.Authenticator
{
	public sealed class AuthenticatorPlayerObjectFormatter : IJsonFormatter<AuthenticatorPlayerObject>, IJsonFormatter
	{
		private readonly AutomataDictionary ____keyMapping;

		private readonly byte[][] ____stringByteKeys;

		public AuthenticatorPlayerObjectFormatter()
		{
			____keyMapping = new AutomataDictionary
			{
				{
					JsonWriter.GetEncodedPropertyNameWithoutQuotation("Id"),
					0
				},
				{
					JsonWriter.GetEncodedPropertyNameWithoutQuotation("Ip"),
					1
				},
				{
					JsonWriter.GetEncodedPropertyNameWithoutQuotation("RequestIp"),
					2
				},
				{
					JsonWriter.GetEncodedPropertyNameWithoutQuotation("Asn"),
					3
				},
				{
					JsonWriter.GetEncodedPropertyNameWithoutQuotation("AuthSerial"),
					4
				},
				{
					JsonWriter.GetEncodedPropertyNameWithoutQuotation("VacSession"),
					5
				}
			};
			____stringByteKeys = new byte[6][]
			{
				JsonWriter.GetEncodedPropertyNameWithBeginObject("Id"),
				JsonWriter.GetEncodedPropertyNameWithPrefixValueSeparator("Ip"),
				JsonWriter.GetEncodedPropertyNameWithPrefixValueSeparator("RequestIp"),
				JsonWriter.GetEncodedPropertyNameWithPrefixValueSeparator("Asn"),
				JsonWriter.GetEncodedPropertyNameWithPrefixValueSeparator("AuthSerial"),
				JsonWriter.GetEncodedPropertyNameWithPrefixValueSeparator("VacSession")
			};
		}

		public void Serialize(ref JsonWriter writer, AuthenticatorPlayerObject value, IJsonFormatterResolver formatterResolver)
		{
			writer.WriteRaw(____stringByteKeys[0]);
			writer.WriteString(value.Id);
			writer.WriteRaw(____stringByteKeys[1]);
			writer.WriteString(value.Ip);
			writer.WriteRaw(____stringByteKeys[2]);
			writer.WriteString(value.RequestIp);
			writer.WriteRaw(____stringByteKeys[3]);
			writer.WriteString(value.Asn);
			writer.WriteRaw(____stringByteKeys[4]);
			writer.WriteString(value.AuthSerial);
			writer.WriteRaw(____stringByteKeys[5]);
			writer.WriteString(value.VacSession);
			writer.WriteEndObject();
		}

		public AuthenticatorPlayerObject Deserialize(ref JsonReader reader, IJsonFormatterResolver formatterResolver)
		{
			if (reader.ReadIsNull())
			{
				throw new InvalidOperationException("typecode is null, struct not supported");
			}
			string id = null;
			string ip = null;
			string requestIp = null;
			string asn = null;
			string authSerial = null;
			string vacSession = null;
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
					id = reader.ReadString();
					break;
				case 1:
					ip = reader.ReadString();
					break;
				case 2:
					requestIp = reader.ReadString();
					break;
				case 3:
					asn = reader.ReadString();
					break;
				case 4:
					authSerial = reader.ReadString();
					break;
				case 5:
					vacSession = reader.ReadString();
					break;
				default:
					reader.ReadNextBlock();
					break;
				}
			}
			return new AuthenticatorPlayerObject(id, ip, requestIp, asn, authSerial, vacSession);
		}
	}
}
