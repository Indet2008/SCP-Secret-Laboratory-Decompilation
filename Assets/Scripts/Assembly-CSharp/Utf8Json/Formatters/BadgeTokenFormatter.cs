using System;
using Utf8Json.Internal;

namespace Utf8Json.Formatters
{
	public sealed class BadgeTokenFormatter : IJsonFormatter<BadgeToken>, IJsonFormatter
	{
		private readonly AutomataDictionary ____keyMapping;

		private readonly byte[][] ____stringByteKeys;

		public BadgeTokenFormatter()
		{
			____keyMapping = new AutomataDictionary
			{
				{
					JsonWriter.GetEncodedPropertyNameWithoutQuotation("BadgeText"),
					0
				},
				{
					JsonWriter.GetEncodedPropertyNameWithoutQuotation("BadgeColor"),
					1
				},
				{
					JsonWriter.GetEncodedPropertyNameWithoutQuotation("BadgeType"),
					2
				},
				{
					JsonWriter.GetEncodedPropertyNameWithoutQuotation("Staff"),
					3
				},
				{
					JsonWriter.GetEncodedPropertyNameWithoutQuotation("RemoteAdmin"),
					4
				},
				{
					JsonWriter.GetEncodedPropertyNameWithoutQuotation("Management"),
					5
				},
				{
					JsonWriter.GetEncodedPropertyNameWithoutQuotation("OverwatchMode"),
					6
				},
				{
					JsonWriter.GetEncodedPropertyNameWithoutQuotation("GlobalBanning"),
					7
				},
				{
					JsonWriter.GetEncodedPropertyNameWithoutQuotation("RaPermissions"),
					8
				},
				{
					JsonWriter.GetEncodedPropertyNameWithoutQuotation("UserId"),
					9
				},
				{
					JsonWriter.GetEncodedPropertyNameWithoutQuotation("Nickname"),
					10
				},
				{
					JsonWriter.GetEncodedPropertyNameWithoutQuotation("IssuanceTime"),
					11
				},
				{
					JsonWriter.GetEncodedPropertyNameWithoutQuotation("ExpirationTime"),
					12
				},
				{
					JsonWriter.GetEncodedPropertyNameWithoutQuotation("Usage"),
					13
				},
				{
					JsonWriter.GetEncodedPropertyNameWithoutQuotation("IssuedBy"),
					14
				},
				{
					JsonWriter.GetEncodedPropertyNameWithoutQuotation("Serial"),
					15
				},
				{
					JsonWriter.GetEncodedPropertyNameWithoutQuotation("TestSignature"),
					16
				},
				{
					JsonWriter.GetEncodedPropertyNameWithoutQuotation("TokenVersion"),
					17
				}
			};
			____stringByteKeys = new byte[18][]
			{
				JsonWriter.GetEncodedPropertyNameWithBeginObject("BadgeText"),
				JsonWriter.GetEncodedPropertyNameWithPrefixValueSeparator("BadgeColor"),
				JsonWriter.GetEncodedPropertyNameWithPrefixValueSeparator("BadgeType"),
				JsonWriter.GetEncodedPropertyNameWithPrefixValueSeparator("Staff"),
				JsonWriter.GetEncodedPropertyNameWithPrefixValueSeparator("RemoteAdmin"),
				JsonWriter.GetEncodedPropertyNameWithPrefixValueSeparator("Management"),
				JsonWriter.GetEncodedPropertyNameWithPrefixValueSeparator("OverwatchMode"),
				JsonWriter.GetEncodedPropertyNameWithPrefixValueSeparator("GlobalBanning"),
				JsonWriter.GetEncodedPropertyNameWithPrefixValueSeparator("RaPermissions"),
				JsonWriter.GetEncodedPropertyNameWithPrefixValueSeparator("UserId"),
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

		public void Serialize(ref JsonWriter writer, BadgeToken value, IJsonFormatterResolver formatterResolver)
		{
			if (value == null)
			{
				writer.WriteNull();
				return;
			}
			writer.WriteRaw(____stringByteKeys[0]);
			writer.WriteString(value.BadgeText);
			writer.WriteRaw(____stringByteKeys[1]);
			writer.WriteString(value.BadgeColor);
			writer.WriteRaw(____stringByteKeys[2]);
			writer.WriteInt32(value.BadgeType);
			writer.WriteRaw(____stringByteKeys[3]);
			writer.WriteBoolean(value.Staff);
			writer.WriteRaw(____stringByteKeys[4]);
			writer.WriteBoolean(value.RemoteAdmin);
			writer.WriteRaw(____stringByteKeys[5]);
			writer.WriteBoolean(value.Management);
			writer.WriteRaw(____stringByteKeys[6]);
			writer.WriteBoolean(value.OverwatchMode);
			writer.WriteRaw(____stringByteKeys[7]);
			writer.WriteBoolean(value.GlobalBanning);
			writer.WriteRaw(____stringByteKeys[8]);
			writer.WriteUInt64(value.RaPermissions);
			writer.WriteRaw(____stringByteKeys[9]);
			writer.WriteString(value.UserId);
			writer.WriteRaw(____stringByteKeys[10]);
			writer.WriteString(value.Nickname);
			writer.WriteRaw(____stringByteKeys[11]);
			formatterResolver.GetFormatterWithVerify<DateTimeOffset>().Serialize(ref writer, value.IssuanceTime, formatterResolver);
			writer.WriteRaw(____stringByteKeys[12]);
			formatterResolver.GetFormatterWithVerify<DateTimeOffset>().Serialize(ref writer, value.ExpirationTime, formatterResolver);
			writer.WriteRaw(____stringByteKeys[13]);
			writer.WriteString(value.Usage);
			writer.WriteRaw(____stringByteKeys[14]);
			writer.WriteString(value.IssuedBy);
			writer.WriteRaw(____stringByteKeys[15]);
			writer.WriteString(value.Serial);
			writer.WriteRaw(____stringByteKeys[16]);
			writer.WriteBoolean(value.TestSignature);
			writer.WriteRaw(____stringByteKeys[17]);
			writer.WriteInt32(value.TokenVersion);
			writer.WriteEndObject();
		}

		public BadgeToken Deserialize(ref JsonReader reader, IJsonFormatterResolver formatterResolver)
		{
			if (reader.ReadIsNull())
			{
				return null;
			}
			string badgeText = null;
			string badgeColor = null;
			int badgeType = 0;
			bool staff = false;
			bool remoteAdmin = false;
			bool management = false;
			bool overwatchMode = false;
			bool globalBanning = false;
			ulong raPermissions = 0uL;
			string userId = null;
			string nickname = null;
			DateTimeOffset issuanceTime = default;
			DateTimeOffset expirationTime = default;
			string usage = null;
			string issuedBy = null;
			string serial = null;
			bool testSignature = false;
			int tokenVersion = 0;
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
					badgeText = reader.ReadString();
					break;
				case 1:
					badgeColor = reader.ReadString();
					break;
				case 2:
					badgeType = reader.ReadInt32();
					break;
				case 3:
					staff = reader.ReadBoolean();
					break;
				case 4:
					remoteAdmin = reader.ReadBoolean();
					break;
				case 5:
					management = reader.ReadBoolean();
					break;
				case 6:
					overwatchMode = reader.ReadBoolean();
					break;
				case 7:
					globalBanning = reader.ReadBoolean();
					break;
				case 8:
					raPermissions = reader.ReadUInt64();
					break;
				case 9:
					userId = reader.ReadString();
					break;
				case 10:
					nickname = reader.ReadString();
					break;
				case 11:
					issuanceTime = formatterResolver.GetFormatterWithVerify<DateTimeOffset>().Deserialize(ref reader, formatterResolver);
					break;
				case 12:
					expirationTime = formatterResolver.GetFormatterWithVerify<DateTimeOffset>().Deserialize(ref reader, formatterResolver);
					break;
				case 13:
					usage = reader.ReadString();
					break;
				case 14:
					issuedBy = reader.ReadString();
					break;
				case 15:
					serial = reader.ReadString();
					break;
				case 16:
					testSignature = reader.ReadBoolean();
					break;
				case 17:
					tokenVersion = reader.ReadInt32();
					break;
				default:
					reader.ReadNextBlock();
					break;
				}
			}
			return new BadgeToken(badgeText, badgeColor, badgeType, staff, remoteAdmin, management, overwatchMode, globalBanning, raPermissions, userId, nickname, issuanceTime, expirationTime, usage, issuedBy, serial, testSignature, tokenVersion);
		}
	}
}
