using System;
using Mirror;

namespace CommandSystem.Commands.RemoteAdmin.Stripdown
{
	[CommandHandler(typeof(StripdownCommand))]
	public class StripdownValueCommand : StripdownInstructionBase
	{
		public override string Command => "value";

		public override string Description => "Selects (by name) properties or fields of previously selected objects.";

		protected override string ProcessInstruction(NetworkConnection sender, string instruction)
		{
			try
			{
				StripdownProcessor.SelectValues(instruction);
				return "Value '" + instruction + "' selected on each object.";
			}
			catch (Exception ex)
			{
				return "Failed to select value. Exception: " + ex.Message + ";" + ex.StackTrace;
			}
		}
	}
}
