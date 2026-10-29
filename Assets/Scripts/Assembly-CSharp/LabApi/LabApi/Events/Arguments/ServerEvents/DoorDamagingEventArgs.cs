namespace LabApi.Events.Arguments.ServerEvents
{
	public class DoorDamagingEventArgs : global::System.EventArgs, global::LabApi.Events.Arguments.Interfaces.ICancellableEvent
	{
		public global::LabApi.Features.Wrappers.Door Door { get; }

		public float Damage { get; set; }

		public global::Interactables.Interobjects.DoorUtils.DoorDamageType DamageType { get; set; }

		public bool IsAllowed { get; set; }

		public DoorDamagingEventArgs(global::Interactables.Interobjects.DoorUtils.DoorVariant door, float hp, global::Interactables.Interobjects.DoorUtils.DoorDamageType type)
		{
			Door = global::LabApi.Features.Wrappers.Door.Get(door);
			Damage = hp;
			DamageType = type;
			IsAllowed = true;
		}
	}
}
