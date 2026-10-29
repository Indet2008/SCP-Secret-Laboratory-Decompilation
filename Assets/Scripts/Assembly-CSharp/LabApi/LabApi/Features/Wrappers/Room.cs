namespace LabApi.Features.Wrappers
{
	public class Room
	{
		private global::System.Collections.Generic.IReadOnlyCollection<global::LabApi.Features.Wrappers.Room>? _adjacentRooms;

		public static global::System.Collections.Generic.Dictionary<global::MapGeneration.RoomIdentifier, global::LabApi.Features.Wrappers.Room> Dictionary { get; } = new global::System.Collections.Generic.Dictionary<global::MapGeneration.RoomIdentifier, global::LabApi.Features.Wrappers.Room>();

		public static global::System.Collections.Generic.IReadOnlyCollection<global::LabApi.Features.Wrappers.Room> List => Dictionary.Values;

		public global::MapGeneration.RoomIdentifier Base { get; }

		public bool IsDestroyed
		{
			get
			{
				if (!(Base == null))
				{
					return GameObject == null;
				}
				return true;
			}
		}

		public global::MapGeneration.RoomShape Shape => Base.Shape;

		public global::MapGeneration.RoomName Name => Base.Name;

		public global::MapGeneration.FacilityZone Zone => Base.Zone;

		public global::System.Collections.Generic.HashSet<global::MapGeneration.RoomIdentifier> ConnectedRooms => Base.ConnectedRooms;

		public global::System.Collections.Generic.IReadOnlyCollection<global::LabApi.Features.Wrappers.Room> AdjacentRooms
		{
			get
			{
				if (_adjacentRooms != null)
				{
					return _adjacentRooms;
				}
				global::System.Collections.Generic.List<global::LabApi.Features.Wrappers.Room> list = global::System.Linq.Enumerable.ToList(global::System.Linq.Enumerable.Select(ConnectedRooms, Get));
				global::LabApi.Features.Wrappers.Elevator elevator = null;
				foreach (global::LabApi.Features.Wrappers.Elevator item in global::LabApi.Features.Wrappers.Elevator.List)
				{
					if (global::System.Linq.Enumerable.Contains<global::LabApi.Features.Wrappers.Room>(item.Rooms, this))
					{
						elevator = item;
					}
				}
				if (elevator != null)
				{
					foreach (global::LabApi.Features.Wrappers.Room room2 in elevator.Rooms)
					{
						if (room2 != this)
						{
							list.Add(room2);
						}
					}
				}
				if (Name == global::MapGeneration.RoomName.HczCheckpointToEntranceZone)
				{
					global::MapGeneration.FacilityZone targetZone = ((Zone == global::MapGeneration.FacilityZone.HeavyContainment) ? global::MapGeneration.FacilityZone.Entrance : global::MapGeneration.FacilityZone.HeavyContainment);
					global::LabApi.Features.Wrappers.Room room = global::LabApi.Features.Extensions.LinqExtensions.MinBy(global::System.Linq.Enumerable.Where(List, (global::LabApi.Features.Wrappers.Room n) => n.Name == global::MapGeneration.RoomName.HczCheckpointToEntranceZone && n.Zone == targetZone), (global::LabApi.Features.Wrappers.Room n) => (n.Position - Position).sqrMagnitude);
					if (room != null)
					{
						list.Add(room);
					}
				}
				_adjacentRooms = list.AsReadOnly();
				return _adjacentRooms;
			}
		}

		public global::System.Collections.Generic.IEnumerable<global::LabApi.Features.Wrappers.Door> Doors
		{
			get
			{
				if (!global::Interactables.Interobjects.DoorUtils.DoorVariant.DoorsByRoom.TryGetValue(Base, out var value))
				{
					return global::System.Array.Empty<global::LabApi.Features.Wrappers.Door>();
				}
				return global::System.Linq.Enumerable.Select(global::System.Linq.Enumerable.Where(value, (global::Interactables.Interobjects.DoorUtils.DoorVariant x) => x != null), (global::Interactables.Interobjects.DoorUtils.DoorVariant x) => global::LabApi.Features.Wrappers.Door.Get(x));
			}
		}

		public global::LabApi.Features.Wrappers.LightsController? LightController
		{
			get
			{
				if (Base.LightControllers.Count <= 0)
				{
					return null;
				}
				return global::LabApi.Features.Wrappers.LightsController.Get(Base.LightControllers[0]);
			}
		}

		public global::System.Collections.Generic.IEnumerable<global::LabApi.Features.Wrappers.LightsController> AllLightControllers => global::System.Linq.Enumerable.Select(Base.LightControllers, global::LabApi.Features.Wrappers.LightsController.Get);

		public global::UnityEngine.Transform Transform => Base.transform;

		public global::UnityEngine.GameObject GameObject => Base.gameObject;

		public global::UnityEngine.Vector3 Position => Transform.position;

		public global::UnityEngine.Quaternion Rotation => Transform.rotation;

		public global::System.Collections.Generic.IEnumerable<global::LabApi.Features.Wrappers.Player> Players => global::System.Linq.Enumerable.Where(global::LabApi.Features.Wrappers.Player.List, (global::LabApi.Features.Wrappers.Player p) => p.Room == this);

		public global::System.Collections.Generic.IEnumerable<global::LabApi.Features.Wrappers.Camera> Cameras => global::System.Linq.Enumerable.Where(global::LabApi.Features.Wrappers.Camera.List, (global::LabApi.Features.Wrappers.Camera x) => x.Room == this);

		protected bool CanCache
		{
			get
			{
				if (!IsDestroyed)
				{
					return Base.isActiveAndEnabled;
				}
				return false;
			}
		}

		public static global::System.Collections.Generic.List<global::LabApi.Features.Wrappers.Room> FindPath(global::LabApi.Features.Wrappers.Room start, global::LabApi.Features.Wrappers.Room end, global::System.Func<global::LabApi.Features.Wrappers.Room, int> weightFunction)
		{
			global::System.Collections.Generic.List<global::LabApi.Features.Wrappers.Room> list = global::NorthwoodLib.Pools.ListPool<global::LabApi.Features.Wrappers.Room>.Shared.Rent();
			if (start == null || end == null || start == end)
			{
				return list;
			}
			global::System.Collections.Generic.Dictionary<global::LabApi.Features.Wrappers.Room, global::LabApi.Features.Wrappers.Room> dictionary = global::UnityEngine.Pool.CollectionPool<global::System.Collections.Generic.Dictionary<global::LabApi.Features.Wrappers.Room, global::LabApi.Features.Wrappers.Room>, global::System.Collections.Generic.KeyValuePair<global::LabApi.Features.Wrappers.Room, global::LabApi.Features.Wrappers.Room>>.Get();
			global::System.Collections.Generic.Dictionary<global::LabApi.Features.Wrappers.Room, int> dictionary2 = global::UnityEngine.Pool.CollectionPool<global::System.Collections.Generic.Dictionary<global::LabApi.Features.Wrappers.Room, int>, global::System.Collections.Generic.KeyValuePair<global::LabApi.Features.Wrappers.Room, int>>.Get();
			global::System.Collections.Generic.HashSet<global::LabApi.Features.Wrappers.Room> hashSet = global::NorthwoodLib.Pools.HashSetPool<global::LabApi.Features.Wrappers.Room>.Shared.Rent();
			global::LabApi.Features.Extensions.PriorityQueue<global::LabApi.Features.Wrappers.Room> priorityQueue = global::LabApi.Features.Extensions.PriorityQueuePool<global::LabApi.Features.Wrappers.Room>.Shared.Rent();
			foreach (global::LabApi.Features.Wrappers.Room item in List)
			{
				dictionary2[item] = int.MaxValue;
				dictionary[item] = null;
			}
			dictionary2[start] = 0;
			priorityQueue.Enqueue(start, 0);
			while (priorityQueue.Count > 0)
			{
				global::LabApi.Features.Wrappers.Room room = priorityQueue.Dequeue();
				if (hashSet.Contains(room))
				{
					continue;
				}
				hashSet.Add(room);
				if (room == end)
				{
					break;
				}
				foreach (global::LabApi.Features.Wrappers.Room adjacentRoom in room.AdjacentRooms)
				{
					if (!hashSet.Contains(adjacentRoom))
					{
						int num = dictionary2[room] + weightFunction(adjacentRoom);
						if (num < dictionary2[adjacentRoom])
						{
							dictionary2[adjacentRoom] = num;
							dictionary[adjacentRoom] = room;
							priorityQueue.Enqueue(adjacentRoom, num);
						}
					}
				}
			}
			for (global::LabApi.Features.Wrappers.Room room2 = end; room2 != null; room2 = dictionary[room2])
			{
				list.Insert(0, room2);
			}
			if (list.Count == 1 && list[0] == end)
			{
				list.Clear();
			}
			global::UnityEngine.Pool.CollectionPool<global::System.Collections.Generic.Dictionary<global::LabApi.Features.Wrappers.Room, global::LabApi.Features.Wrappers.Room>, global::System.Collections.Generic.KeyValuePair<global::LabApi.Features.Wrappers.Room, global::LabApi.Features.Wrappers.Room>>.Release(dictionary);
			global::UnityEngine.Pool.CollectionPool<global::System.Collections.Generic.Dictionary<global::LabApi.Features.Wrappers.Room, int>, global::System.Collections.Generic.KeyValuePair<global::LabApi.Features.Wrappers.Room, int>>.Release(dictionary2);
			global::NorthwoodLib.Pools.HashSetPool<global::LabApi.Features.Wrappers.Room>.Shared.Return(hashSet);
			global::LabApi.Features.Extensions.PriorityQueuePool<global::LabApi.Features.Wrappers.Room>.Shared.Return(priorityQueue);
			return list;
		}

		public static global::System.Collections.Generic.List<global::LabApi.Features.Wrappers.Room> FindPath(global::LabApi.Features.Wrappers.Room start, global::LabApi.Features.Wrappers.Room end)
		{
			return FindPath(start, end, (global::LabApi.Features.Wrappers.Room room) => 1);
		}

		[return: global::System.Diagnostics.CodeAnalysis.NotNullIfNotNull("roomIdentifier")]
		public static global::LabApi.Features.Wrappers.Room? Get(global::MapGeneration.RoomIdentifier? roomIdentifier)
		{
			if (roomIdentifier == null)
			{
				return null;
			}
			if (Dictionary.TryGetValue(roomIdentifier, out global::LabApi.Features.Wrappers.Room value))
			{
				return value;
			}
			return CreateRoomWrapper(roomIdentifier);
		}

		public static global::System.Collections.Generic.IEnumerable<global::LabApi.Features.Wrappers.Room> Get(global::MapGeneration.RoomName roomName)
		{
			return global::System.Linq.Enumerable.Where(List, (global::LabApi.Features.Wrappers.Room x) => x.Name == roomName);
		}

		public static global::System.Collections.Generic.IEnumerable<global::LabApi.Features.Wrappers.Room> Get(global::MapGeneration.RoomShape roomShape)
		{
			return global::System.Linq.Enumerable.Where(List, (global::LabApi.Features.Wrappers.Room x) => x.Shape == roomShape);
		}

		public static global::System.Collections.Generic.IEnumerable<global::LabApi.Features.Wrappers.Room> Get(global::MapGeneration.FacilityZone facilityZone)
		{
			return global::System.Linq.Enumerable.Where(List, (global::LabApi.Features.Wrappers.Room x) => x.Zone == facilityZone);
		}

		public static global::System.Collections.Generic.IEnumerable<global::LabApi.Features.Wrappers.Room> Get(global::System.Collections.Generic.IEnumerable<global::MapGeneration.RoomIdentifier> roomIdentifiers)
		{
			return global::System.Linq.Enumerable.Select(roomIdentifiers, Get);
		}

		public static bool TryGetRoomAtPosition(global::UnityEngine.Vector3 position, [global::System.Diagnostics.CodeAnalysis.NotNullWhen(true)] out global::LabApi.Features.Wrappers.Room? room)
		{
			if (!global::MapGeneration.RoomUtils.TryGetRoom(position, out var room2))
			{
				room = null;
				return false;
			}
			room = Get(room2);
			return true;
		}

		public static global::LabApi.Features.Wrappers.Room? GetRoomAtPosition(global::UnityEngine.Vector3 position)
		{
			if (!TryGetRoomAtPosition(position, out global::LabApi.Features.Wrappers.Room room))
			{
				return null;
			}
			return room;
		}

		[global::Generators.InitializeWrapper(128)]
		internal static void Initialize()
		{
			global::MapGeneration.RoomIdentifier.OnAdded += AddRoom;
			global::MapGeneration.RoomIdentifier.OnRemoved += RemoveRoom;
		}

		protected static global::LabApi.Features.Wrappers.Room CreateRoomWrapper(global::MapGeneration.RoomIdentifier roomIdentifier)
		{
			if (roomIdentifier.Name == global::MapGeneration.RoomName.Pocket)
			{
				return new global::LabApi.Features.Wrappers.PocketDimension(roomIdentifier);
			}
			if (roomIdentifier.Name == global::MapGeneration.RoomName.Lcz914)
			{
				return new global::LabApi.Features.Wrappers.Scp914(roomIdentifier);
			}
			return new global::LabApi.Features.Wrappers.Room(roomIdentifier);
		}

		private static void AddRoom(global::MapGeneration.RoomIdentifier roomIdentifier)
		{
			try
			{
				if (!Dictionary.ContainsKey(roomIdentifier))
				{
					CreateRoomWrapper(roomIdentifier);
				}
			}
			catch (global::System.Exception arg)
			{
				global::LabApi.Features.Console.Logger.InternalError($"Failed to handle room creation with error: {arg}");
			}
		}

		private static void RemoveRoom(global::MapGeneration.RoomIdentifier roomIdentifier)
		{
			try
			{
				if (Dictionary.TryGetValue(roomIdentifier, out global::LabApi.Features.Wrappers.Room value))
				{
					value.OnRemoved();
				}
			}
			catch (global::System.Exception arg)
			{
				global::LabApi.Features.Console.Logger.InternalError($"Failed to handle item destruction with error: {arg}");
			}
		}

		internal Room(global::MapGeneration.RoomIdentifier roomIdentifier)
		{
			Base = roomIdentifier;
			if (CanCache)
			{
				Dictionary.Add(roomIdentifier, this);
			}
		}

		public override string ToString()
		{
			return $"[{GetType().Name}: Name={Name}, Shape={Shape}, Zone={Zone}]";
		}

		public global::LabApi.Features.Wrappers.LightsController? GetClosestLightController(global::LabApi.Features.Wrappers.Player player)
		{
			RoomLightController closestLightController = Base.GetClosestLightController(player.ReferenceHub);
			if (!(closestLightController == null))
			{
				return global::LabApi.Features.Wrappers.LightsController.Get(closestLightController);
			}
			return null;
		}

		internal virtual void OnRemoved()
		{
			Dictionary.Remove(Base);
			_adjacentRooms = null;
		}
	}
}
