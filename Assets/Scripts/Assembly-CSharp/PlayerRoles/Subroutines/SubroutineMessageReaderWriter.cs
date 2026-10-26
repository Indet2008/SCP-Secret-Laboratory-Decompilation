using Mirror;

namespace PlayerRoles.Subroutines
{
	public static class SubroutineMessageReaderWriter
	{
		public static void WriteSubroutineMessage(this NetworkWriter writer, SubroutineMessage msg)
		{
			msg.Write(writer);
		}

		public static SubroutineMessage ReadSubroutineMessage(this NetworkReader reader)
		{
			return new SubroutineMessage(reader);
		}
	}
}
