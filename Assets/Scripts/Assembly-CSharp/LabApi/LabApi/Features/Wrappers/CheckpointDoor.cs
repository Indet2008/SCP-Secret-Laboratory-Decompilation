namespace LabApi.Features.Wrappers
{
	public class CheckpointDoor : global::LabApi.Features.Wrappers.Door
	{
		public new static global::System.Collections.Generic.Dictionary<global::Interactables.Interobjects.CheckpointDoor, global::LabApi.Features.Wrappers.CheckpointDoor> Dictionary { get; } = new global::System.Collections.Generic.Dictionary<global::Interactables.Interobjects.CheckpointDoor, global::LabApi.Features.Wrappers.CheckpointDoor>();

		public new static global::System.Collections.Generic.IReadOnlyCollection<global::LabApi.Features.Wrappers.CheckpointDoor> List => Dictionary.Values;

		public new global::Interactables.Interobjects.CheckpointDoor Base { get; }

		public global::Interactables.Interobjects.CheckpointSequenceController SequenceController => Base.SequenceCtrl;

		public global::LabApi.Features.Wrappers.Door[] SubDoors { get; }

		public bool IsSubOpened
		{
			get
			{
				return global::System.Linq.Enumerable.All(SubDoors, (global::LabApi.Features.Wrappers.Door x) => x.IsOpened);
			}
			set
			{
				Base.ToggleAllDoors(value);
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

		public global::Interactables.Interobjects.CheckpointDoor.SequenceState SequenceState
		{
			get
			{
				return Base.CurSequence;
			}
			set
			{
				Base.CurSequence = value;
			}
		}

		public float OpenTime
		{
			get
			{
				return Base.SequenceCtrl.OpenLoopTime;
			}
			set
			{
				Base.SequenceCtrl.OpenLoopTime = value;
			}
		}

		public float WarningTime
		{
			get
			{
				return Base.SequenceCtrl.WarningTime;
			}
			set
			{
				Base.SequenceCtrl.WarningTime = value;
			}
		}

		public float HealthPercent => Base.GetHealthPercent();

		[return: global::System.Diagnostics.CodeAnalysis.NotNullIfNotNull("baseCheckpointDoor")]
		public static global::LabApi.Features.Wrappers.CheckpointDoor? Get(global::Interactables.Interobjects.CheckpointDoor? baseCheckpointDoor)
		{
			if (baseCheckpointDoor == null)
			{
				return null;
			}
			if (Dictionary.TryGetValue(baseCheckpointDoor, out global::LabApi.Features.Wrappers.CheckpointDoor value))
			{
				return value;
			}
			return (global::LabApi.Features.Wrappers.CheckpointDoor)global::LabApi.Features.Wrappers.Door.CreateDoorWrapper(baseCheckpointDoor);
		}

		internal CheckpointDoor(global::Interactables.Interobjects.CheckpointDoor baseCheckpointDoor)
			: base(baseCheckpointDoor)
		{
			Base = baseCheckpointDoor;
			SubDoors = new global::LabApi.Features.Wrappers.Door[baseCheckpointDoor.SubDoors.Length];
			for (int i = 0; i < baseCheckpointDoor.SubDoors.Length; i++)
			{
				SubDoors[i] = global::LabApi.Features.Wrappers.Door.Get(baseCheckpointDoor.SubDoors[i]);
			}
			if (base.CanCache)
			{
				Dictionary.Add(baseCheckpointDoor, this);
			}
		}

		public void PlayWarningSound()
		{
			Base.RpcPlayWarningSound();
		}

		public bool TryDamage(float damage, global::Interactables.Interobjects.DoorUtils.DoorDamageType type = global::Interactables.Interobjects.DoorUtils.DoorDamageType.ServerCommand)
		{
			return Base.ServerDamage(damage, type);
		}

		public bool TryBreak(global::Interactables.Interobjects.DoorUtils.DoorDamageType type = global::Interactables.Interobjects.DoorUtils.DoorDamageType.ServerCommand)
		{
			return TryDamage(float.MaxValue, type);
		}

		internal override void OnRemove()
		{
			base.OnRemove();
			Dictionary.Remove(Base);
		}
	}
}
