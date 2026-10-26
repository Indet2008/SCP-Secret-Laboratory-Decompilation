using System;
using Utf8Json.Internal;

namespace Utf8Json.Formatters
{
	public sealed class ServerListItemFormatter : IJsonFormatter<ServerListItem>, IJsonFormatter
	{
		private readonly AutomataDictionary ____keyMapping;

		private readonly byte[][] ____stringByteKeys;

		public ServerListItemFormatter()
		{
			____keyMapping = new AutomataDictionary
			{
				{
					JsonWriter.GetEncodedPropertyNameWithoutQuotation("accountId"),
					0
				},
				{
					JsonWriter.GetEncodedPropertyNameWithoutQuotation("serverId"),
					1
				},
				{
					JsonWriter.GetEncodedPropertyNameWithoutQuotation("ip"),
					2
				},
				{
					JsonWriter.GetEncodedPropertyNameWithoutQuotation("port"),
					3
				},
				{
					JsonWriter.GetEncodedPropertyNameWithoutQuotation("players"),
					4
				},
				{
					JsonWriter.GetEncodedPropertyNameWithoutQuotation("info"),
					5
				},
				{
					JsonWriter.GetEncodedPropertyNameWithoutQuotation("pastebin"),
					6
				},
				{
					JsonWriter.GetEncodedPropertyNameWithoutQuotation("version"),
					7
				},
				{
					JsonWriter.GetEncodedPropertyNameWithoutQuotation("friendlyFire"),
					8
				},
				{
					JsonWriter.GetEncodedPropertyNameWithoutQuotation("modded"),
					9
				},
				{
					JsonWriter.GetEncodedPropertyNameWithoutQuotation("whitelist"),
					10
				},
				{
					JsonWriter.GetEncodedPropertyNameWithoutQuotation("officialCode"),
					11
				},
				{
					JsonWriter.GetEncodedPropertyNameWithoutQuotation("NameFilterPoints"),
					12
				}
			};
			____stringByteKeys = new byte[13][]
			{
				JsonWriter.GetEncodedPropertyNameWithBeginObject("accountId"),
				JsonWriter.GetEncodedPropertyNameWithPrefixValueSeparator("serverId"),
				JsonWriter.GetEncodedPropertyNameWithPrefixValueSeparator("ip"),
				JsonWriter.GetEncodedPropertyNameWithPrefixValueSeparator("port"),
				JsonWriter.GetEncodedPropertyNameWithPrefixValueSeparator("players"),
				JsonWriter.GetEncodedPropertyNameWithPrefixValueSeparator("info"),
				JsonWriter.GetEncodedPropertyNameWithPrefixValueSeparator("pastebin"),
				JsonWriter.GetEncodedPropertyNameWithPrefixValueSeparator("version"),
				JsonWriter.GetEncodedPropertyNameWithPrefixValueSeparator("friendlyFire"),
				JsonWriter.GetEncodedPropertyNameWithPrefixValueSeparator("modded"),
				JsonWriter.GetEncodedPropertyNameWithPrefixValueSeparator("whitelist"),
				JsonWriter.GetEncodedPropertyNameWithPrefixValueSeparator("officialCode"),
				JsonWriter.GetEncodedPropertyNameWithPrefixValueSeparator("NameFilterPoints")
			};
		}

		public void Serialize(ref JsonWriter writer, ServerListItem value, IJsonFormatterResolver formatterResolver)
		{
			writer.WriteRaw(____stringByteKeys[0]);
			writer.WriteUInt32(value.accountId);
			writer.WriteRaw(____stringByteKeys[1]);
			writer.WriteUInt32(value.serverId);
			writer.WriteRaw(____stringByteKeys[2]);
			writer.WriteString(value.ip);
			writer.WriteRaw(____stringByteKeys[3]);
			writer.WriteUInt16(value.port);
			writer.WriteRaw(____stringByteKeys[4]);
			writer.WriteString(value.players);
			writer.WriteRaw(____stringByteKeys[5]);
			writer.WriteString(value.info);
			writer.WriteRaw(____stringByteKeys[6]);
			writer.WriteString(value.pastebin);
			writer.WriteRaw(____stringByteKeys[7]);
			writer.WriteString(value.version);
			writer.WriteRaw(____stringByteKeys[8]);
			writer.WriteBoolean(value.friendlyFire);
			writer.WriteRaw(____stringByteKeys[9]);
			writer.WriteBoolean(value.modded);
			writer.WriteRaw(____stringByteKeys[10]);
			writer.WriteBoolean(value.whitelist);
			writer.WriteRaw(____stringByteKeys[11]);
			writer.WriteByte(value.officialCode);
			writer.WriteRaw(____stringByteKeys[12]);
			writer.WriteInt32(value.NameFilterPoints);
			writer.WriteEndObject();
		}

		public ServerListItem Deserialize(ref JsonReader reader, IJsonFormatterResolver formatterResolver)
		{
			if (reader.ReadIsNull())
			{
				throw new InvalidOperationException("typecode is null, struct not supported");
			}
			uint accountId = 0u;
			uint serverId = 0u;
			string ip = null;
			ushort port = 0;
			string players = null;
			string info = null;
			string pastebin = null;
			string version = null;
			bool friendlyFire = false;
			bool modded = false;
			bool whitelist = false;
			byte officialCode = 0;
			int nameFilterPoints = 0;
			bool flag = false;
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
					accountId = reader.ReadUInt32();
					break;
				case 1:
					serverId = reader.ReadUInt32();
					break;
				case 2:
					ip = reader.ReadString();
					break;
				case 3:
					port = reader.ReadUInt16();
					break;
				case 4:
					players = reader.ReadString();
					break;
				case 5:
					info = reader.ReadString();
					break;
				case 6:
					pastebin = reader.ReadString();
					break;
				case 7:
					version = reader.ReadString();
					break;
				case 8:
					friendlyFire = reader.ReadBoolean();
					break;
				case 9:
					modded = reader.ReadBoolean();
					break;
				case 10:
					whitelist = reader.ReadBoolean();
					break;
				case 11:
					officialCode = reader.ReadByte();
					break;
				case 12:
					nameFilterPoints = reader.ReadInt32();
					flag = true;
					break;
				default:
					reader.ReadNextBlock();
					break;
				}
			}
			ServerListItem result = new ServerListItem(accountId, serverId, ip, port, players, info, pastebin, version, friendlyFire, modded, whitelist, officialCode);
			if (flag)
			{
				result.NameFilterPoints = nameFilterPoints;
			}
			return result;
		}
	}
}
