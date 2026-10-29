namespace LabApi.Features.Wrappers
{
	public class ElevatorDoor : global::LabApi.Features.Wrappers.Door
	{
		public new static global::System.Collections.Generic.Dictionary<global::Interactables.Interobjects.ElevatorDoor, global::LabApi.Features.Wrappers.ElevatorDoor> Dictionary { get; } = new global::System.Collections.Generic.Dictionary<global::Interactables.Interobjects.ElevatorDoor, global::LabApi.Features.Wrappers.ElevatorDoor>();

		public new static global::System.Collections.Generic.IReadOnlyCollection<global::LabApi.Features.Wrappers.ElevatorDoor> List => Dictionary.Values;

		public new global::Interactables.Interobjects.ElevatorDoor Base { get; }

		public global::LabApi.Features.Wrappers.Elevator? Elevator => global::System.Linq.Enumerable.FirstOrDefault(global::LabApi.Features.Wrappers.Elevator.GetByGroup(Base.Group));

		public global::Interactables.Interobjects.ElevatorGroup Group => Base.Group;

		[return: global::System.Diagnostics.CodeAnalysis.NotNullIfNotNull("baseElevatorDoor")]
		public static global::LabApi.Features.Wrappers.ElevatorDoor? Get(global::Interactables.Interobjects.ElevatorDoor? baseElevatorDoor)
		{
			if (baseElevatorDoor == null)
			{
				return null;
			}
			if (Dictionary.TryGetValue(baseElevatorDoor, out global::LabApi.Features.Wrappers.ElevatorDoor value))
			{
				return value;
			}
			return (global::LabApi.Features.Wrappers.ElevatorDoor)global::LabApi.Features.Wrappers.Door.CreateDoorWrapper(baseElevatorDoor);
		}

		internal ElevatorDoor(global::Interactables.Interobjects.ElevatorDoor baseElevatorDoor)
			: base(baseElevatorDoor)
		{
			Base = baseElevatorDoor;
			if (base.CanCache)
			{
				Dictionary.Add(baseElevatorDoor, this);
			}
		}

		internal override void OnRemove()
		{
			base.OnRemove();
			Dictionary.Remove(Base);
		}
	}
}
