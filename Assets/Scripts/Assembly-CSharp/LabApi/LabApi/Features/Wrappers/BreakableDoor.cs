namespace LabApi.Features.Wrappers
{
	public class BreakableDoor : global::LabApi.Features.Wrappers.Door
	{
		public new static global::System.Collections.Generic.Dictionary<global::Interactables.Interobjects.BreakableDoor, global::LabApi.Features.Wrappers.BreakableDoor> Dictionary { get; } = new global::System.Collections.Generic.Dictionary<global::Interactables.Interobjects.BreakableDoor, global::LabApi.Features.Wrappers.BreakableDoor>();

		public new static global::System.Collections.Generic.IReadOnlyCollection<global::LabApi.Features.Wrappers.BreakableDoor> List => Dictionary.Values;

		public new global::Interactables.Interobjects.BreakableDoor Base { get; }

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

		public float MaxHealth
		{
			get
			{
				return Base.MaxHealth;
			}
			set
			{
				Base.MaxHealth = value;
			}
		}

		public float Health
		{
			get
			{
				return Base.RemainingHealth;
			}
			set
			{
				Base.RemainingHealth = value;
			}
		}

		public bool IsBroken
		{
			get
			{
				return Base.IsDestroyed;
			}
			set
			{
				Base.IsDestroyed = value;
			}
		}

		public global::Interactables.Interobjects.DoorUtils.DoorDamageType IgnoreDamageSources
		{
			get
			{
				return Base.IgnoredDamageSources;
			}
			set
			{
				Base.IgnoredDamageSources = value;
			}
		}

		[return: global::System.Diagnostics.CodeAnalysis.NotNullIfNotNull("baseBreakableDoor")]
		public static global::LabApi.Features.Wrappers.BreakableDoor? Get(global::Interactables.Interobjects.BreakableDoor? baseBreakableDoor)
		{
			if (baseBreakableDoor == null)
			{
				return null;
			}
			if (Dictionary.TryGetValue(baseBreakableDoor, out global::LabApi.Features.Wrappers.BreakableDoor value))
			{
				return value;
			}
			return (global::LabApi.Features.Wrappers.BreakableDoor)global::LabApi.Features.Wrappers.Door.CreateDoorWrapper(baseBreakableDoor);
		}

		internal BreakableDoor(global::Interactables.Interobjects.BreakableDoor baseBreakableDoor)
			: base(baseBreakableDoor)
		{
			Base = baseBreakableDoor;
			if (base.CanCache)
			{
				Dictionary.Add(baseBreakableDoor, this);
			}
		}

		public bool TryDamage(float damage, global::Interactables.Interobjects.DoorUtils.DoorDamageType type = global::Interactables.Interobjects.DoorUtils.DoorDamageType.ServerCommand)
		{
			return Base.ServerDamage(damage, type);
		}

		public bool TryBreak(global::Interactables.Interobjects.DoorUtils.DoorDamageType type = global::Interactables.Interobjects.DoorUtils.DoorDamageType.ServerCommand)
		{
			return TryDamage(float.MaxValue, type);
		}

		public bool TryRepair()
		{
			return Base.ServerRepair();
		}

		internal override void OnRemove()
		{
			base.OnRemove();
			Dictionary.Remove(Base);
		}
	}
}
