namespace LabApi.Events.Arguments.ServerEvents
{
	public class DoorRepairingEventArgs : global::System.EventArgs, global::LabApi.Events.Arguments.Interfaces.ICancellableEvent
	{
		public global::LabApi.Features.Wrappers.Door Door { get; }

		public float RemainingHealth { get; set; }

		public bool IsAllowed { get; set; }

		public DoorRepairingEventArgs(global::Interactables.Interobjects.DoorUtils.DoorVariant door, float remainingHealth)
		{
			Door = global::LabApi.Features.Wrappers.Door.Get(door);
			RemainingHealth = remainingHealth;
			IsAllowed = true;
		}
	}
}
