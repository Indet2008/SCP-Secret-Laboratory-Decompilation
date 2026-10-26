using Interactables.Interobjects.DoorUtils;

namespace CommandSystem.Commands.RemoteAdmin.Doors
{
	[CommandHandler(typeof(RemoteAdminCommandHandler))]
	public class DestroyDoorCommand : BaseDoorCommand
	{
		public override string Command { get; } = "destroy";

		public override string[] Aliases { get; } = new string[1] { "destroydoor" };

		public override string Description { get; } = "Destroys a specified door.";

		public override bool AllowNonDamageableTargets => false;

		protected override void OnTargetFound(DoorVariant door)
		{
			(door as IDamageableDoor).ServerDamage(65535f, DoorDamageType.ServerCommand);
		}
	}
}
