using Interactables.Interobjects.DoorUtils;

namespace CommandSystem.Commands.RemoteAdmin.Doors
{
	[CommandHandler(typeof(RemoteAdminCommandHandler))]
	public class UnlockDoorCommand : BaseDoorCommand
	{
		public override string Command { get; } = "unlock";

		public override string[] Aliases { get; } = new string[2] { "unlockdoor", "ul" };

		public override string Description { get; } = "Unlocks a specified door.";

		protected override void OnTargetFound(DoorVariant door)
		{
			door.ServerChangeLock(DoorLockReason.AdminCommand, newState: false);
		}
	}
}
