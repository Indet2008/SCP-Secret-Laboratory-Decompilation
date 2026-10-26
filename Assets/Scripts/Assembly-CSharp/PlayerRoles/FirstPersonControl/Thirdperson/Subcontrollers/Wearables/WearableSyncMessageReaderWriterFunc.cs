using Mirror;

namespace PlayerRoles.FirstPersonControl.Thirdperson.Subcontrollers.Wearables
{
	public static class WearableSyncMessageReaderWriterFunc
	{
		public static void WriteWearableSyncMessage(this NetworkWriter writer, WearableSyncMessage msg)
		{
			msg.SerializeAndFree(writer);
		}

		public static WearableSyncMessage ReadWearableSyncMessage(this NetworkReader reader)
		{
			return new WearableSyncMessage(reader);
		}
	}
}
