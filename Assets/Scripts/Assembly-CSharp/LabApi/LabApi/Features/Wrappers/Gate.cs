namespace LabApi.Features.Wrappers
{
	public class Gate : global::LabApi.Features.Wrappers.Door
	{
		public new static global::System.Collections.Generic.Dictionary<global::Interactables.Interobjects.PryableDoor, global::LabApi.Features.Wrappers.Gate> Dictionary { get; } = new global::System.Collections.Generic.Dictionary<global::Interactables.Interobjects.PryableDoor, global::LabApi.Features.Wrappers.Gate>();

		public new static global::System.Collections.Generic.IReadOnlyCollection<global::LabApi.Features.Wrappers.Gate> List => Dictionary.Values;

		public new global::Interactables.Interobjects.PryableDoor Base { get; }

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

		[return: global::System.Diagnostics.CodeAnalysis.NotNullIfNotNull("pryableDoor")]
		public static global::LabApi.Features.Wrappers.Gate? Get(global::Interactables.Interobjects.PryableDoor? pryableDoor)
		{
			if (pryableDoor == null)
			{
				return null;
			}
			if (Dictionary.TryGetValue(pryableDoor, out global::LabApi.Features.Wrappers.Gate value))
			{
				return value;
			}
			return (global::LabApi.Features.Wrappers.Gate)global::LabApi.Features.Wrappers.Door.CreateDoorWrapper(pryableDoor);
		}

		internal Gate(global::Interactables.Interobjects.PryableDoor pryableDoor)
			: base(pryableDoor)
		{
			Base = pryableDoor;
			if (base.CanCache)
			{
				Dictionary.Add(pryableDoor, this);
			}
		}

		public bool TryPry(global::LabApi.Features.Wrappers.Player player)
		{
			return Base.TryPryGate(player.ReferenceHub);
		}

		public void Pry()
		{
			Base.RpcPryGate();
		}

		internal override void OnRemove()
		{
			base.OnRemove();
			Dictionary.Remove(Base);
		}
	}
}
