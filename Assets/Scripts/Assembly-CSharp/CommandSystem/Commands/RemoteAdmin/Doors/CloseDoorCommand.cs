using Interactables.Interobjects.DoorUtils;

namespace CommandSystem.Commands.RemoteAdmin.Doors
{
	[CommandHandler(typeof(RemoteAdminCommandHandler))]
	public class CloseDoorCommand : BaseDoorCommand
	{
		public override string Command { get; } = "close";

		public override string[] Aliases { get; } = new string[2] { "closedoor", "c" };

		public override string Description { get; } = "Closes a specified door.";

		protected override void OnTargetFound(DoorVariant door)
		{
			door.NetworkTargetState = false;
		}
	}
}
