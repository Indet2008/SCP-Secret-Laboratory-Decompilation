using System;
using Mirror;

namespace CommandSystem.Commands.RemoteAdmin.Stripdown
{
	[CommandHandler(typeof(StripdownCommand))]
	public class StripdownComponentCommand : StripdownInstructionBase
	{
		public override string Command => "component";

		public override string Description => "Performs a GetComponent on all previously selected objects and applies them as new selections.";

		protected override string ProcessInstruction(NetworkConnection sender, string instruction)
		{
			try
			{
				StripdownProcessor.SelectComponent(instruction);
				return "Component '" + instruction + "' selected on each object.";
			}
			catch (Exception ex)
			{
				return "Failed to get components. Exception: " + ex.Message + ";" + ex.StackTrace;
			}
		}
	}
}
