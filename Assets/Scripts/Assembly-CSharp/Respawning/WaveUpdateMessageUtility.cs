using Mirror;

namespace Respawning
{
	public static class WaveUpdateMessageUtility
	{
		public static void WriteUpdateMessage(this NetworkWriter writer, WaveUpdateMessage msg)
		{
			msg.Write(writer);
		}

		public static WaveUpdateMessage ReadUpdateMessage(this NetworkReader reader)
		{
			return new WaveUpdateMessage(reader);
		}
	}
}
