namespace LabApi.Features.Wrappers
{
	public class Elevator
	{
		public static global::System.Collections.Generic.Dictionary<global::Interactables.Interobjects.ElevatorChamber, global::LabApi.Features.Wrappers.Elevator> Dictionary { get; } = new global::System.Collections.Generic.Dictionary<global::Interactables.Interobjects.ElevatorChamber, global::LabApi.Features.Wrappers.Elevator>();

		public static global::System.Collections.Generic.IReadOnlyCollection<global::LabApi.Features.Wrappers.Elevator> List => Dictionary.Values;

		public global::Interactables.Interobjects.ElevatorChamber Base { get; }

		public global::System.Collections.Generic.IEnumerable<global::LabApi.Features.Wrappers.ElevatorDoor> Doors => global::System.Linq.Enumerable.Select(global::Interactables.Interobjects.ElevatorDoor.GetDoorsForGroup(Group), global::LabApi.Features.Wrappers.ElevatorDoor.Get);

		public global::System.Collections.Generic.IEnumerable<global::LabApi.Features.Wrappers.Room> Rooms => global::System.Linq.Enumerable.SelectMany(Doors, (global::LabApi.Features.Wrappers.ElevatorDoor x) => x.Rooms);

		public global::LabApi.Features.Wrappers.ElevatorDoor CurrentDestination => global::LabApi.Features.Wrappers.ElevatorDoor.Get(Base.DestinationDoor);

		public int CurrentDestinationLevel => Base.DestinationLevel;

		public global::LabApi.Features.Wrappers.ElevatorDoor NextDestination => global::LabApi.Features.Wrappers.ElevatorDoor.Get(Base.NextDestinationDoor);

		public int NextDestinationLevel => Base.NextLevel;

		public bool IsReady => Base.IsReady;

		public bool GoingUp => Base.GoingUp;

		public global::Interactables.Interobjects.ElevatorGroup Group
		{
			get
			{
				return Base.AssignedGroup;
			}
			set
			{
				Base.AssignedGroup = value;
			}
		}

		public global::Interactables.Interobjects.ElevatorChamber.ElevatorSequence CurrentSequence => Base.CurSequence;

		[global::System.Obsolete("Use WorldSpaceRelativeBounds.Bounds instead.")]
		public global::UnityEngine.Bounds WorldSpaceBounds => Base.WorldspaceBounds.Bounds;

		public global::Utils.RelativeBounds WorldSpaceRelativeBounds => Base.WorldspaceBounds;

		public global::Interactables.Interobjects.DoorUtils.DoorLockReason AnyDoorLockedReason => Base.ActiveLocksAnyDoors;

		public global::Interactables.Interobjects.DoorUtils.DoorLockReason AllDoorsLockedReason => Base.ActiveLocksAllDoors;

		public bool DynamicAdminLock
		{
			get
			{
				return Base.DynamicAdminLock;
			}
			set
			{
				Base.DynamicAdminLock = value;
			}
		}

		public static void LockAll()
		{
			foreach (global::LabApi.Features.Wrappers.Elevator item in List)
			{
				item.LockAllDoors();
			}
		}

		public static void UnlockAll()
		{
			foreach (global::LabApi.Features.Wrappers.Elevator item in List)
			{
				item.UnlockAllDoors();
			}
		}

		public static global::LabApi.Features.Wrappers.Elevator Get(global::Interactables.Interobjects.ElevatorChamber elevatorChamber)
		{
			if (!Dictionary.TryGetValue(elevatorChamber, out global::LabApi.Features.Wrappers.Elevator value))
			{
				return new global::LabApi.Features.Wrappers.Elevator(elevatorChamber);
			}
			return value;
		}

		public static global::System.Collections.Generic.IEnumerable<global::LabApi.Features.Wrappers.Elevator> GetByGroup(global::Interactables.Interobjects.ElevatorGroup group)
		{
			return global::System.Linq.Enumerable.Where(List, (global::LabApi.Features.Wrappers.Elevator n) => n.Group == group);
		}

		[global::Generators.InitializeWrapper(128)]
		internal static void Initialize()
		{
			Dictionary.Clear();
			global::Interactables.Interobjects.ElevatorChamber.OnElevatorSpawned += (global::Interactables.Interobjects.ElevatorChamber chamber) =>
			{
				new global::LabApi.Features.Wrappers.Elevator(chamber);
			};
			global::Interactables.Interobjects.ElevatorChamber.OnElevatorRemoved += (global::Interactables.Interobjects.ElevatorChamber chamber) =>
			{
				Dictionary.Remove(chamber);
			};
		}

		private Elevator(global::Interactables.Interobjects.ElevatorChamber elevator)
		{
			Dictionary.Add(elevator, this);
			Base = elevator;
		}

		public override string ToString()
		{
			return $"[Elevator: Group={Group}, IsReady={IsReady}, GoingUp={GoingUp}, CurrentSequence={CurrentSequence}]";
		}

		public void SetDestination(int targetLevel, bool force = false)
		{
			Base.ServerSetDestination(targetLevel, force);
		}

		public void Interact(global::LabApi.Features.Wrappers.Player player)
		{
			Base.ServerInteract(player.ReferenceHub, 0);
		}

		public void SendToNextFloor()
		{
			SetDestination(NextDestinationLevel);
		}

		public void LockAllDoors()
		{
			Base.ServerLockAllDoors(global::Interactables.Interobjects.DoorUtils.DoorLockReason.AdminCommand, state: true);
		}

		public void UnlockAllDoors()
		{
			Base.ServerLockAllDoors(global::Interactables.Interobjects.DoorUtils.DoorLockReason.AdminCommand, state: false);
		}
	}
}
