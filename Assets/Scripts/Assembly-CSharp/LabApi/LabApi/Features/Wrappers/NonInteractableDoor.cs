namespace LabApi.Features.Wrappers
{
	public class NonInteractableDoor : global::LabApi.Features.Wrappers.Door
	{
		public new static global::System.Collections.Generic.Dictionary<global::Interactables.Interobjects.BasicNonInteractableDoor, global::LabApi.Features.Wrappers.NonInteractableDoor> Dictionary { get; } = new global::System.Collections.Generic.Dictionary<global::Interactables.Interobjects.BasicNonInteractableDoor, global::LabApi.Features.Wrappers.NonInteractableDoor>();

		public new static global::System.Collections.Generic.IReadOnlyCollection<global::LabApi.Features.Wrappers.NonInteractableDoor> List => Dictionary.Values;

		public new global::Interactables.Interobjects.BasicNonInteractableDoor Base { get; }

		public bool Is106Passable
		{
			get
			{
				return Base.IsScp106Passable;
			}
			set
			{
				Base.IsScp106Passable = value;
			}
		}

		[return: global::System.Diagnostics.CodeAnalysis.NotNullIfNotNull("basicNonInteractableDoor")]
		public static global::LabApi.Features.Wrappers.NonInteractableDoor? Get(global::Interactables.Interobjects.BasicNonInteractableDoor? basicNonInteractableDoor)
		{
			if (basicNonInteractableDoor == null)
			{
				return null;
			}
			if (Dictionary.TryGetValue(basicNonInteractableDoor, out global::LabApi.Features.Wrappers.NonInteractableDoor value))
			{
				return value;
			}
			return (global::LabApi.Features.Wrappers.NonInteractableDoor)global::LabApi.Features.Wrappers.Door.CreateDoorWrapper(basicNonInteractableDoor);
		}

		internal NonInteractableDoor(global::Interactables.Interobjects.BasicNonInteractableDoor basicNonInteractableDoor)
			: base(basicNonInteractableDoor)
		{
			Base = basicNonInteractableDoor;
			if (base.CanCache)
			{
				Dictionary.Add(basicNonInteractableDoor, this);
			}
		}

		internal override void OnRemove()
		{
			base.OnRemove();
			Dictionary.Remove(Base);
		}
	}
}
