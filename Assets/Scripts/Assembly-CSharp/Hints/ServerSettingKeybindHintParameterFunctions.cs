using Mirror;

namespace Hints
{
	public static class ServerSettingKeybindHintParameterFunctions
	{
		public static void Serialize(this NetworkWriter writer, SSKeybindHintParameter value)
		{
			value.Serialize(writer);
		}

		public static SSKeybindHintParameter Deserialize(this NetworkReader reader)
		{
			return SSKeybindHintParameter.FromNetwork(reader);
		}
	}
}
