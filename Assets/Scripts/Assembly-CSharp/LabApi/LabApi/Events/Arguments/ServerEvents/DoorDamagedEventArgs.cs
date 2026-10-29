namespace LabApi.Events.Arguments.ServerEvents
{
	public class DoorDamagedEventArgs : global::System.EventArgs
	{
		public global::LabApi.Features.Wrappers.Door Door { get; }

		public float Damage { get; }

		public global::Interactables.Interobjects.DoorUtils.DoorDamageType DamageType { get; }

		public DoorDamagedEventArgs(global::Interactables.Interobjects.DoorUtils.DoorVariant door, float hp, global::Interactables.Interobjects.DoorUtils.DoorDamageType type)
		{
			Door = global::LabApi.Features.Wrappers.Door.Get(door);
			Damage = hp;
			DamageType = type;
		}
	}
}
