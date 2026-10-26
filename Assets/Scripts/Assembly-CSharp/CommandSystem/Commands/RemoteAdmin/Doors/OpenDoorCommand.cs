using Interactables.Interobjects.DoorUtils;

namespace CommandSystem.Commands.RemoteAdmin.Doors
{
	[CommandHandler(typeof(RemoteAdminCommandHandler))]
	public class OpenDoorCommand : BaseDoorCommand
	{
		public override string Command { get; } = "open";

		public override string[] Aliases { get; } = new string[2] { "opendoor", "o" };

		public override string Description { get; } = "Opens a specified door.";

		protected override void OnTargetFound(DoorVariant door)
		{
			door.NetworkTargetState = true;
		}
	}
}
