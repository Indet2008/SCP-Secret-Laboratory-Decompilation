using Mirror;

namespace UserSettings.ServerSpecific
{
	public readonly struct SSSUserStatusReport : NetworkMessage
	{
		public readonly int Version;

		public readonly bool TabOpen;

		public SSSUserStatusReport(NetworkReader reader)
		{
			Version = reader.ReadInt();
			TabOpen = reader.ReadBool();
		}

		public SSSUserStatusReport(int ver, bool tabOpen)
		{
			Version = ver;
			TabOpen = tabOpen;
		}

		public void Serialize(NetworkWriter writer)
		{
			writer.WriteInt(Version);
			writer.WriteBool(TabOpen);
		}
	}
}
