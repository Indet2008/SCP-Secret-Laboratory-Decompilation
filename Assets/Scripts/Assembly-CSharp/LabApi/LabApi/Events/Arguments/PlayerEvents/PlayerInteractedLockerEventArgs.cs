namespace LabApi.Events.Arguments.PlayerEvents
{
	public class PlayerInteractedLockerEventArgs : global::System.EventArgs, global::LabApi.Events.Arguments.Interfaces.IPlayerEvent, global::LabApi.Events.Arguments.Interfaces.ILockerEvent, global::LabApi.Events.Arguments.Interfaces.IStructureEvent
	{
		public global::LabApi.Features.Wrappers.Player Player { get; }

		public global::LabApi.Features.Wrappers.Locker Locker { get; }

		public global::LabApi.Features.Wrappers.LockerChamber Chamber { get; }

		public bool CanOpen { get; }

		public PlayerInteractedLockerEventArgs(ReferenceHub hub, global::MapGeneration.Distributors.Locker locker, global::MapGeneration.Distributors.LockerChamber chamber, bool canOpen)
		{
			Player = global::LabApi.Features.Wrappers.Player.Get(hub);
			Locker = global::LabApi.Features.Wrappers.Locker.Get(locker);
			Chamber = global::LabApi.Features.Wrappers.LockerChamber.Get(chamber);
			CanOpen = canOpen;
		}
	}
}
