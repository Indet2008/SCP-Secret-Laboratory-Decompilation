using System;
using Mirror;

namespace CommandSystem.Commands.RemoteAdmin.Stripdown
{
	[CommandHandler(typeof(StripdownCommand))]
	public class StripdownObjectCommand : StripdownInstructionBase
	{
		public override string Command => "object";

		public override string Description => "Finds all objects of provided type and selects them.";

		protected override string ProcessInstruction(NetworkConnection sender, string instruction)
		{
			try
			{
				int num = StripdownProcessor.SelectUnityObjects(instruction);
				return $"Selected {num} objects of type {instruction}";
			}
			catch (Exception ex)
			{
				return "Failed to select objects. Exception: " + ex.Message + ";" + ex.StackTrace;
			}
		}
	}
}
