using Interactables.Interobjects.DoorUtils;

namespace CommandSystem.Commands.RemoteAdmin.Doors
{
	[CommandHandler(typeof(RemoteAdminCommandHandler))]
	public class RepairDoorCommand : BaseDoorCommand
	{
		public override string Command { get; } = "repair";

		public override string[] Aliases { get; } = new string[1] { "repairdoor" };

		public override string Description { get; } = "Repairs a specified door.";

		public override bool AllowNonDamageableTargets => false;

		protected override void OnTargetFound(DoorVariant door)
		{
			(door as IDamageableDoor).ServerRepair();
		}
	}
}
