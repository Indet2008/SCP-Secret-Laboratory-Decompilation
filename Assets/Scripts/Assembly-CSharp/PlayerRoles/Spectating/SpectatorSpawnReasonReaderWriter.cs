using Mirror;

namespace PlayerRoles.Spectating
{
	public static class SpectatorSpawnReasonReaderWriter
	{
		public static void WriteSpawnReason(this NetworkWriter writer, SpectatorSpawnReason reason)
		{
			writer.WriteByte((byte)reason);
		}

		public static SpectatorSpawnReason ReadSpawnReason(this NetworkReader reader)
		{
			return (SpectatorSpawnReason)reader.ReadByte();
		}
	}
}
