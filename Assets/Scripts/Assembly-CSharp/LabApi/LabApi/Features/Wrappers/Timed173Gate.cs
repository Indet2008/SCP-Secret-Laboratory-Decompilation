namespace LabApi.Features.Wrappers
{
	public class Timed173Gate : global::LabApi.Features.Wrappers.Gate
	{
		public new static global::System.Collections.Generic.Dictionary<global::Interactables.Interobjects.Timed173PryableDoor, global::LabApi.Features.Wrappers.Timed173Gate> Dictionary { get; } = new global::System.Collections.Generic.Dictionary<global::Interactables.Interobjects.Timed173PryableDoor, global::LabApi.Features.Wrappers.Timed173Gate>();

		public new static global::System.Collections.Generic.IReadOnlyCollection<global::LabApi.Features.Wrappers.Timed173Gate> List => Dictionary.Values;

		public new global::Interactables.Interobjects.Timed173PryableDoor Base { get; }

		public global::System.Diagnostics.Stopwatch Stopwatch => Base.Stopwatch;

		public bool SmartOpen
		{
			get
			{
				return Base.SmartOpen;
			}
			set
			{
				Base.SmartOpen = value;
			}
		}

		public float Delay
		{
			get
			{
				return Base.TimeMark;
			}
			set
			{
				Base.TimeMark = value;
			}
		}

		[return: global::System.Diagnostics.CodeAnalysis.NotNullIfNotNull("timed173PryableDoor")]
		public static global::LabApi.Features.Wrappers.Timed173Gate? Get(global::Interactables.Interobjects.Timed173PryableDoor? timed173PryableDoor)
		{
			if (timed173PryableDoor == null)
			{
				return null;
			}
			if (Dictionary.TryGetValue(timed173PryableDoor, out global::LabApi.Features.Wrappers.Timed173Gate value))
			{
				return value;
			}
			return (global::LabApi.Features.Wrappers.Timed173Gate)global::LabApi.Features.Wrappers.Door.CreateDoorWrapper(timed173PryableDoor);
		}

		internal Timed173Gate(global::Interactables.Interobjects.Timed173PryableDoor timed173PryableDoor)
			: base(timed173PryableDoor)
		{
			Base = timed173PryableDoor;
			if (base.CanCache)
			{
				Dictionary.Add(timed173PryableDoor, this);
			}
		}

		internal override void OnRemove()
		{
			base.OnRemove();
			Dictionary.Remove(Base);
		}
	}
}
