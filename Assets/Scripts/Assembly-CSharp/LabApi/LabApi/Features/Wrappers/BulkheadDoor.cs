namespace LabApi.Features.Wrappers
{
	public class BulkheadDoor : global::LabApi.Features.Wrappers.Gate
	{
		public new static global::System.Collections.Generic.Dictionary<global::Interactables.Interobjects.PryableDoor, global::LabApi.Features.Wrappers.BulkheadDoor> Dictionary { get; } = new global::System.Collections.Generic.Dictionary<global::Interactables.Interobjects.PryableDoor, global::LabApi.Features.Wrappers.BulkheadDoor>();

		public new static global::System.Collections.Generic.IReadOnlyCollection<global::LabApi.Features.Wrappers.BulkheadDoor> List => Dictionary.Values;

		public new global::Interactables.Interobjects.PryableDoor Base { get; }

		public global::LabApi.Features.Wrappers.DoorCrusher? Crusher { get; }

		[return: global::System.Diagnostics.CodeAnalysis.NotNullIfNotNull("pryableDoor")]
		public new static global::LabApi.Features.Wrappers.BulkheadDoor? Get(global::Interactables.Interobjects.PryableDoor? pryableDoor)
		{
			if (pryableDoor == null)
			{
				return null;
			}
			if (Dictionary.TryGetValue(pryableDoor, out global::LabApi.Features.Wrappers.BulkheadDoor value))
			{
				return value;
			}
			return (global::LabApi.Features.Wrappers.BulkheadDoor)global::LabApi.Features.Wrappers.Door.CreateDoorWrapper(pryableDoor);
		}

		internal BulkheadDoor(global::Interactables.Interobjects.PryableDoor pryableDoor)
			: base(pryableDoor)
		{
			Base = pryableDoor;
			global::Interactables.Interobjects.DoorUtils.DoorCrusherExtension component = pryableDoor.gameObject.GetComponent<global::Interactables.Interobjects.DoorUtils.DoorCrusherExtension>();
			if (component != null)
			{
				Crusher = new global::LabApi.Features.Wrappers.DoorCrusher(component);
			}
			if (base.CanCache)
			{
				Dictionary.Add(pryableDoor, this);
			}
		}

		internal override void OnRemove()
		{
			base.OnRemove();
			Dictionary.Remove(Base);
		}
	}
}
