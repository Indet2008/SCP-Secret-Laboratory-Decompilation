using Mirror;

namespace InventorySystem.Items.Firearms.Modules.Misc
{
	public static class ShotBacktrackDataSerializer
	{
		public static void WriteBacktrackData(this NetworkWriter writer, ShotBacktrackData value)
		{
			value.WriteSelf(writer);
		}

		public static ShotBacktrackData ReadBacktrackData(this NetworkReader reader)
		{
			return new ShotBacktrackData(reader);
		}
	}
}
