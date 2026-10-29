namespace LabApi.Features.Wrappers
{
	public class DummyDoor : global::LabApi.Features.Wrappers.Door
	{
		public new static global::System.Collections.Generic.Dictionary<global::Interactables.Interobjects.DummyDoor, global::LabApi.Features.Wrappers.DummyDoor> Dictionary { get; } = new global::System.Collections.Generic.Dictionary<global::Interactables.Interobjects.DummyDoor, global::LabApi.Features.Wrappers.DummyDoor>();

		public new static global::System.Collections.Generic.IReadOnlyCollection<global::LabApi.Features.Wrappers.DummyDoor> List => Dictionary.Values;

		public new global::Interactables.Interobjects.DummyDoor Base { get; }

		[return: global::System.Diagnostics.CodeAnalysis.NotNullIfNotNull("baseDummyDoor")]
		public static global::LabApi.Features.Wrappers.DummyDoor? Get(global::Interactables.Interobjects.DummyDoor? baseDummyDoor)
		{
			if (baseDummyDoor == null)
			{
				return null;
			}
			if (Dictionary.TryGetValue(baseDummyDoor, out global::LabApi.Features.Wrappers.DummyDoor value))
			{
				return value;
			}
			return (global::LabApi.Features.Wrappers.DummyDoor)global::LabApi.Features.Wrappers.Door.CreateDoorWrapper(baseDummyDoor);
		}

		internal DummyDoor(global::Interactables.Interobjects.DummyDoor baseDummyDoor)
			: base(baseDummyDoor)
		{
			Dictionary.Add(baseDummyDoor, this);
			Base = baseDummyDoor;
		}

		internal override void OnRemove()
		{
			base.OnRemove();
			Dictionary.Remove(Base);
		}
	}
}
