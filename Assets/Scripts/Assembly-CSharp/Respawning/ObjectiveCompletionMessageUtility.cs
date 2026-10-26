using Mirror;

namespace Respawning
{
	public static class ObjectiveCompletionMessageUtility
	{
		public static void WriteCompletionMessage(this NetworkWriter writer, ObjectiveCompletionMessage msg)
		{
			msg.Write(writer);
		}

		public static ObjectiveCompletionMessage ReadCompletionMessage(this NetworkReader reader)
		{
			return new ObjectiveCompletionMessage(reader);
		}
	}
}
