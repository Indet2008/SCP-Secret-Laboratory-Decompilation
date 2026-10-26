using Mirror;

namespace UserSettings.ServerSpecific
{
	public static class SSSNetworkMessageFunctions
	{
		public static void SerializeSSSEntriesPack(this NetworkWriter writer, SSSEntriesPack value)
		{
			value.Serialize(writer);
		}

		public static SSSEntriesPack DeserializeSSSEntriesPack(this NetworkReader reader)
		{
			return new SSSEntriesPack(reader);
		}

		public static void SerializeSSSClientResponse(this NetworkWriter writer, SSSClientResponse value)
		{
			value.Serialize(writer);
		}

		public static SSSClientResponse DeserializeSSSClientResponse(this NetworkReader reader)
		{
			return new SSSClientResponse(reader);
		}

		public static void SerializeSSSVersionSelfReport(this NetworkWriter writer, SSSUserStatusReport value)
		{
			value.Serialize(writer);
		}

		public static SSSUserStatusReport DeserializeSSSVersionSelfReport(this NetworkReader reader)
		{
			return new SSSUserStatusReport(reader);
		}

		public static void SerializeSSSUpdateMessage(this NetworkWriter writer, SSSUpdateMessage value)
		{
			value.Serialize(writer);
		}

		public static SSSUpdateMessage DeserializeSSSUpdateMessage(this NetworkReader reader)
		{
			return new SSSUpdateMessage(reader);
		}
	}
}
