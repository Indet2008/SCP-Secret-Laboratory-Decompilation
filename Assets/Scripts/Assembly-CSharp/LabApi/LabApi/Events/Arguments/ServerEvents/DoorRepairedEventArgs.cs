namespace LabApi.Events.Arguments.ServerEvents
{
	public class DoorRepairedEventArgs : global::System.EventArgs
	{
		public global::LabApi.Features.Wrappers.Door Door { get; }

		public float RemainingHealth { get; }

		public DoorRepairedEventArgs(global::Interactables.Interobjects.DoorUtils.DoorVariant door, float remainingHealth)
		{
			Door = global::LabApi.Features.Wrappers.Door.Get(door);
			RemainingHealth = remainingHealth;
		}
	}
}
