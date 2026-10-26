using System;
using InventorySystem.Crosshairs;

namespace CommandSystem.Commands.Console
{
	[CommandHandler(typeof(GameConsoleCommandHandler))]
	public class AccuracyStatsCommand : ICommand
	{
		public string Command { get; } = "accuracystats";

		public string[] Aliases { get; } = new string[5] { "accstats", "inaccstats", "inaccuracystats", "statsacc", "statsinacc" };

		public string Description { get; } = "Replaces gun crosshair with one that displays current inaccuracy.";

		private bool Enabled
		{
			get
			{
				return DebugStatsCrosshair.Enabled;
			}
			set
			{
				DebugStatsCrosshair.Enabled = value;
			}
		}

		public bool Execute(ArraySegment<string> arguments, ICommandSender sender, out string response)
		{
			Enabled = !Enabled;
			response = "Accuracy stats crosshair status: " + (Enabled ? "Enabled" : "Disabled") + "\nIf changes aren't applied automatically, re-equip your firearm.";
			if (ReferenceHub.TryGetLocalHub(out var hub))
			{
				CrosshairController.Refresh(hub, hub.inventory.CurItem.SerialNumber);
			}
			return true;
		}
	}
}
