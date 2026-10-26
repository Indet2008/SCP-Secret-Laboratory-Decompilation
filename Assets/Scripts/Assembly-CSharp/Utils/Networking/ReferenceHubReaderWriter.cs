using Mirror;

namespace Utils.Networking
{
	public static class ReferenceHubReaderWriter
	{
		public static void WriteReferenceHub(this NetworkWriter writer, ReferenceHub hub)
		{
			writer.WriteRecyclablePlayerId(new RecyclablePlayerId((!(hub == null)) ? hub.PlayerId : 0));
		}

		public static ReferenceHub ReadReferenceHub(this NetworkReader reader)
		{
			reader.TryReadReferenceHub(out var hub);
			return hub;
		}

		public static bool TryReadReferenceHub(this NetworkReader reader, out ReferenceHub hub)
		{
			int value = reader.ReadRecyclablePlayerId().Value;
			if (value == 0)
			{
				hub = null;
				return false;
			}
			return ReferenceHub.TryGetHub(value, out hub);
		}
	}
}
