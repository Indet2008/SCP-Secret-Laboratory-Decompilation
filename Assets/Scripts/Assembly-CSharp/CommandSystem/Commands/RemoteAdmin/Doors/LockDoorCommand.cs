using Interactables.Interobjects.DoorUtils;

namespace CommandSystem.Commands.RemoteAdmin.Doors
{
	[CommandHandler(typeof(RemoteAdminCommandHandler))]
	public class LockDoorCommand : BaseDoorCommand
	{
		public override string Command { get; } = "lock";

		public override string[] Aliases { get; } = new string[2] { "lockdoor", "l" };

		public override string Description { get; } = "Locks a specified door.";

		protected override void OnTargetFound(DoorVariant door)
		{
			door.ServerChangeLock(DoorLockReason.AdminCommand, newState: true);
		}
	}
}
