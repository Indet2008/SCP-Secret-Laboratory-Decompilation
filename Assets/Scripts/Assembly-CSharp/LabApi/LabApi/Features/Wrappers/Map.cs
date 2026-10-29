namespace LabApi.Features.Wrappers
{
	public static class Map
	{
		public static int Seed => global::MapGeneration.SeedSynchronizer.Seed;

		public static global::System.Collections.Generic.IReadOnlyCollection<global::LabApi.Features.Wrappers.Room> Rooms => global::LabApi.Features.Wrappers.Room.List;

		public static global::System.Collections.Generic.IReadOnlyCollection<global::LabApi.Features.Wrappers.LightsController> RoomLights => global::LabApi.Features.Wrappers.LightsController.List;

		public static global::System.Collections.Generic.IReadOnlyCollection<global::LabApi.Features.Wrappers.Camera> Cameras => global::LabApi.Features.Wrappers.Camera.List;

		public static global::System.Collections.Generic.IReadOnlyCollection<global::LabApi.Features.Wrappers.Door> Doors => global::LabApi.Features.Wrappers.Door.List;

		public static global::System.Collections.Generic.IReadOnlyCollection<global::LabApi.Features.Wrappers.Elevator> Elevators => global::LabApi.Features.Wrappers.Elevator.List;

		public static global::System.Collections.Generic.IReadOnlyCollection<global::LabApi.Features.Wrappers.Tesla> Teslas => global::LabApi.Features.Wrappers.Tesla.List;

		public static global::System.Collections.Generic.IReadOnlyCollection<global::LabApi.Features.Wrappers.Generator> Generators => global::LabApi.Features.Wrappers.Generator.List;

		public static global::System.Collections.Generic.IReadOnlyCollection<global::LabApi.Features.Wrappers.Pickup> Pickups => global::LabApi.Features.Wrappers.Pickup.List;

		public static global::System.Collections.Generic.IReadOnlyCollection<global::LabApi.Features.Wrappers.Ragdoll> Ragdolls => global::LabApi.Features.Wrappers.Ragdoll.List;

		public static global::UnityEngine.Bounds DefaultEscapeZone { get; } = Escape.DefaultEscapeZone;

		public static global::System.Collections.Generic.List<global::UnityEngine.Bounds> EscapeZones => Escape.EscapeZones;

		public static void AddEscapeZone(global::UnityEngine.Bounds escapeZone)
		{
			EscapeZones.Add(escapeZone);
		}

		public static void RemoveEscapeZone(global::UnityEngine.Bounds escapeZone)
		{
			EscapeZones.Remove(escapeZone);
		}

		public static global::LabApi.Features.Wrappers.Room? GetRandomRoom()
		{
			if (Rooms.Count == 0)
			{
				return null;
			}
			return global::System.Linq.Enumerable.ElementAt(Rooms, global::UnityEngine.Random.Range(0, Rooms.Count));
		}

		public static global::LabApi.Features.Wrappers.Room? GetRandomRoom(global::MapGeneration.FacilityZone zone)
		{
			global::System.Collections.Generic.IEnumerable<global::LabApi.Features.Wrappers.Room> source = global::System.Linq.Enumerable.Where(Rooms, (global::LabApi.Features.Wrappers.Room x) => x.Zone == zone);
			int num = global::System.Linq.Enumerable.Count(source);
			if (num == 0)
			{
				return null;
			}
			return global::System.Linq.Enumerable.ElementAt(source, global::UnityEngine.Random.Range(0, num));
		}

		public static global::LabApi.Features.Wrappers.Room? GetRandomRoom(global::System.Collections.Generic.IEnumerable<global::MapGeneration.FacilityZone> zones)
		{
			global::System.Collections.Generic.IEnumerable<global::LabApi.Features.Wrappers.Room> source = global::System.Linq.Enumerable.Where(Rooms, (global::LabApi.Features.Wrappers.Room x) => global::System.Linq.Enumerable.Contains(zones, x.Zone));
			int num = global::System.Linq.Enumerable.Count(source);
			if (num == 0)
			{
				return null;
			}
			return global::System.Linq.Enumerable.ElementAt(source, global::UnityEngine.Random.Range(0, num));
		}

		public static global::LabApi.Features.Wrappers.Door? GetRandomDoor()
		{
			if (Doors.Count == 0)
			{
				return null;
			}
			return global::System.Linq.Enumerable.ElementAt(Doors, global::UnityEngine.Random.Range(0, Doors.Count));
		}

		public static global::LabApi.Features.Wrappers.Door? GetRandomDoor(global::MapGeneration.FacilityZone zone, bool includeBorders)
		{
			global::System.Collections.Generic.IEnumerable<global::LabApi.Features.Wrappers.Door> source = global::System.Linq.Enumerable.Where(Doors, (global::LabApi.Features.Wrappers.Door x) => (!includeBorders) ? global::System.Linq.Enumerable.All(x.Rooms, (global::LabApi.Features.Wrappers.Room room) => room.Zone == zone) : global::System.Linq.Enumerable.Any(x.Rooms, (global::LabApi.Features.Wrappers.Room room) => room.Zone == zone));
			int num = global::System.Linq.Enumerable.Count(source);
			if (num == 0)
			{
				return null;
			}
			return global::System.Linq.Enumerable.ElementAt(source, global::UnityEngine.Random.Range(0, num));
		}

		public static global::LabApi.Features.Wrappers.Door? GetRandomDoor(global::System.Collections.Generic.IEnumerable<global::MapGeneration.FacilityZone> zones, bool includeBorders)
		{
			global::System.Collections.Generic.IEnumerable<global::LabApi.Features.Wrappers.Door> source = global::System.Linq.Enumerable.Where(Doors, (global::LabApi.Features.Wrappers.Door x) => (!includeBorders) ? global::System.Linq.Enumerable.All(x.Rooms, (global::LabApi.Features.Wrappers.Room room) => global::System.Linq.Enumerable.Contains(zones, room.Zone)) : global::System.Linq.Enumerable.Any(x.Rooms, (global::LabApi.Features.Wrappers.Room room) => global::System.Linq.Enumerable.Contains(zones, room.Zone)));
			int num = global::System.Linq.Enumerable.Count(source);
			if (num == 0)
			{
				return null;
			}
			return global::System.Linq.Enumerable.ElementAt(source, global::UnityEngine.Random.Range(0, num));
		}

		public static global::LabApi.Features.Wrappers.LightsController? GetRandomLight()
		{
			if (RoomLights.Count == 0)
			{
				return null;
			}
			return global::System.Linq.Enumerable.ElementAt(RoomLights, global::UnityEngine.Random.Range(0, RoomLights.Count));
		}

		public static global::LabApi.Features.Wrappers.LightsController? GetRandomLight(global::MapGeneration.FacilityZone zone)
		{
			global::System.Collections.Generic.IEnumerable<global::LabApi.Features.Wrappers.LightsController> source = global::System.Linq.Enumerable.Where(RoomLights, (global::LabApi.Features.Wrappers.LightsController x) => x.Room.Zone == zone);
			int num = global::System.Linq.Enumerable.Count(source);
			if (num == 0)
			{
				return null;
			}
			return global::System.Linq.Enumerable.ElementAt(source, global::UnityEngine.Random.Range(0, num));
		}

		public static global::LabApi.Features.Wrappers.LightsController? GetRandomLight(global::System.Collections.Generic.IEnumerable<global::MapGeneration.FacilityZone> zones)
		{
			global::System.Collections.Generic.IEnumerable<global::LabApi.Features.Wrappers.LightsController> source = global::System.Linq.Enumerable.Where(RoomLights, (global::LabApi.Features.Wrappers.LightsController x) => global::System.Linq.Enumerable.Contains(zones, x.Room.Zone));
			int num = global::System.Linq.Enumerable.Count(source);
			if (num == 0)
			{
				return null;
			}
			return global::System.Linq.Enumerable.ElementAt(source, global::UnityEngine.Random.Range(0, num));
		}

		public static global::LabApi.Features.Wrappers.Camera? GetRandomCamera()
		{
			if (Cameras.Count == 0)
			{
				return null;
			}
			return global::System.Linq.Enumerable.ElementAt(Cameras, global::UnityEngine.Random.Range(0, Cameras.Count));
		}

		public static global::LabApi.Features.Wrappers.Camera? GetRandomCamera(global::MapGeneration.FacilityZone zone)
		{
			global::System.Collections.Generic.IEnumerable<global::LabApi.Features.Wrappers.Camera> source = global::System.Linq.Enumerable.Where(Cameras, (global::LabApi.Features.Wrappers.Camera x) => x.Room.Zone == zone);
			int num = global::System.Linq.Enumerable.Count(source);
			if (num == 0)
			{
				return null;
			}
			return global::System.Linq.Enumerable.ElementAt(source, global::UnityEngine.Random.Range(0, num));
		}

		public static global::LabApi.Features.Wrappers.Camera? GetRandomCamera(global::System.Collections.Generic.IEnumerable<global::MapGeneration.FacilityZone> zones)
		{
			global::System.Collections.Generic.IEnumerable<global::LabApi.Features.Wrappers.Camera> source = global::System.Linq.Enumerable.Where(Cameras, (global::LabApi.Features.Wrappers.Camera x) => global::System.Linq.Enumerable.Contains(zones, x.Room.Zone));
			int num = global::System.Linq.Enumerable.Count(source);
			if (num == 0)
			{
				return null;
			}
			return global::System.Linq.Enumerable.ElementAt(source, global::UnityEngine.Random.Range(0, num));
		}

		public static global::LabApi.Features.Wrappers.Locker? GetRandomLocker()
		{
			throw new global::System.NotImplementedException();
		}

		public static global::LabApi.Features.Wrappers.Locker? GetRandomLocker(global::MapGeneration.FacilityZone zone)
		{
			throw new global::System.NotImplementedException();
		}

		public static global::LabApi.Features.Wrappers.Locker? GetRandomLocker(global::System.Collections.Generic.IEnumerable<global::MapGeneration.FacilityZone> zones)
		{
			throw new global::System.NotImplementedException();
		}

		public static global::LabApi.Features.Wrappers.Elevator? GetRandomElevator()
		{
			if (Elevators.Count == 0)
			{
				return null;
			}
			return global::System.Linq.Enumerable.ElementAt(Elevators, global::UnityEngine.Random.Range(0, Elevators.Count));
		}

		public static global::LabApi.Features.Wrappers.Tesla? GetRandomTesla()
		{
			if (Teslas.Count == 0)
			{
				return null;
			}
			return global::System.Linq.Enumerable.ElementAt(Teslas, global::UnityEngine.Random.Range(0, Teslas.Count));
		}

		public static global::LabApi.Features.Wrappers.Generator? GetRandomGenerator()
		{
			if (Generators.Count == 0)
			{
				return null;
			}
			return global::System.Linq.Enumerable.ElementAt(Generators, global::UnityEngine.Random.Range(0, Generators.Count));
		}

		public static global::LabApi.Features.Wrappers.Pickup? GetRandomPickup()
		{
			if (Pickups.Count == 0)
			{
				return null;
			}
			return global::System.Linq.Enumerable.ElementAt(Pickups, global::UnityEngine.Random.Range(0, Pickups.Count));
		}

		public static global::LabApi.Features.Wrappers.Pickup? GetRandomPickup(global::MapGeneration.FacilityZone zone)
		{
			throw new global::System.NotImplementedException();
		}

		public static global::LabApi.Features.Wrappers.Pickup? GetRandomPickup(global::System.Collections.Generic.IEnumerable<global::MapGeneration.FacilityZone> zones)
		{
			throw new global::System.NotImplementedException();
		}

		public static global::LabApi.Features.Wrappers.Ragdoll? GetRandomRagdoll()
		{
			if (Ragdolls.Count == 0)
			{
				return null;
			}
			return global::System.Linq.Enumerable.ElementAt(Ragdolls, global::UnityEngine.Random.Range(0, Ragdolls.Count));
		}

		public static global::LabApi.Features.Wrappers.Ragdoll? GetRandomRagdoll(global::MapGeneration.FacilityZone zone)
		{
			global::System.Collections.Generic.IEnumerable<global::LabApi.Features.Wrappers.Ragdoll> source = global::System.Linq.Enumerable.Where(Ragdolls, (global::LabApi.Features.Wrappers.Ragdoll x) => global::LabApi.Features.Wrappers.Room.TryGetRoomAtPosition(x.Position, out global::LabApi.Features.Wrappers.Room room) && room.Zone == zone);
			int num = global::System.Linq.Enumerable.Count(source);
			if (num == 0)
			{
				return null;
			}
			return global::System.Linq.Enumerable.ElementAt(source, global::UnityEngine.Random.Range(0, num));
		}

		public static global::LabApi.Features.Wrappers.Ragdoll? GetRandomRagdoll(global::System.Collections.Generic.IEnumerable<global::MapGeneration.FacilityZone> zones)
		{
			global::System.Collections.Generic.IEnumerable<global::LabApi.Features.Wrappers.Ragdoll> source = global::System.Linq.Enumerable.Where(Ragdolls, (global::LabApi.Features.Wrappers.Ragdoll x) => global::LabApi.Features.Wrappers.Room.TryGetRoomAtPosition(x.Position, out global::LabApi.Features.Wrappers.Room room) && global::System.Linq.Enumerable.Contains(zones, room.Zone));
			int num = global::System.Linq.Enumerable.Count(source);
			if (num == 0)
			{
				return null;
			}
			return global::System.Linq.Enumerable.ElementAt(source, global::UnityEngine.Random.Range(0, num));
		}

		public static void TurnOffLights(float duration)
		{
			foreach (global::LabApi.Features.Wrappers.LightsController item in global::LabApi.Features.Wrappers.LightsController.List)
			{
				item.FlickerLights(duration);
			}
		}

		public static void TurnOffLights()
		{
			TurnOffLights(float.MaxValue);
		}

		public static void TurnOffLights(global::MapGeneration.FacilityZone zone)
		{
			foreach (global::LabApi.Features.Wrappers.LightsController item in global::LabApi.Features.Wrappers.LightsController.List)
			{
				if (item.Room.Zone == zone)
				{
					item.FlickerLights(float.MaxValue);
				}
			}
		}

		public static void TurnOffLights(global::System.Collections.Generic.IEnumerable<global::MapGeneration.FacilityZone> zones)
		{
			global::System.Collections.Generic.IEnumerable<global::MapGeneration.FacilityZone> source = (zones as global::MapGeneration.FacilityZone[]) ?? global::System.Linq.Enumerable.ToArray(zones);
			foreach (global::LabApi.Features.Wrappers.LightsController item in global::LabApi.Features.Wrappers.LightsController.List)
			{
				if (global::System.Linq.Enumerable.Contains(source, item.Room.Zone))
				{
					item.FlickerLights(float.MaxValue);
				}
			}
		}

		public static void TurnOffLights(float duration, global::MapGeneration.FacilityZone zone)
		{
			foreach (global::LabApi.Features.Wrappers.LightsController item in global::LabApi.Features.Wrappers.LightsController.List)
			{
				if (item.Room.Zone == zone)
				{
					item.FlickerLights(duration);
				}
			}
		}

		public static void TurnOffLights(float duration, global::System.Collections.Generic.IEnumerable<global::MapGeneration.FacilityZone> zones)
		{
			foreach (global::LabApi.Features.Wrappers.LightsController item in global::LabApi.Features.Wrappers.LightsController.List)
			{
				if (global::System.Linq.Enumerable.Contains(zones, item.Room.Zone))
				{
					item.FlickerLights(duration);
				}
			}
		}

		public static void TurnOnLights()
		{
			foreach (global::LabApi.Features.Wrappers.LightsController item in global::LabApi.Features.Wrappers.LightsController.List)
			{
				item.LightsEnabled = true;
			}
		}

		public static void TurnOnLights(global::MapGeneration.FacilityZone zone)
		{
			foreach (global::LabApi.Features.Wrappers.LightsController item in global::LabApi.Features.Wrappers.LightsController.List)
			{
				if (item.Room.Zone == zone)
				{
					item.LightsEnabled = true;
				}
			}
		}

		public static void TurnOnLights(global::System.Collections.Generic.IEnumerable<global::MapGeneration.FacilityZone> zones)
		{
			foreach (global::LabApi.Features.Wrappers.LightsController item in global::LabApi.Features.Wrappers.LightsController.List)
			{
				if (global::System.Linq.Enumerable.Contains(zones, item.Room.Zone))
				{
					item.LightsEnabled = true;
				}
			}
		}

		public static void SetColorOfLights(global::UnityEngine.Color color)
		{
			foreach (global::LabApi.Features.Wrappers.LightsController item in global::LabApi.Features.Wrappers.LightsController.List)
			{
				item.OverrideLightsColor = color;
			}
		}

		public static void SetColorOfLights(global::UnityEngine.Color color, global::MapGeneration.FacilityZone zone)
		{
			foreach (global::LabApi.Features.Wrappers.LightsController item in global::LabApi.Features.Wrappers.LightsController.List)
			{
				if (item.Room.Zone == zone)
				{
					item.OverrideLightsColor = color;
				}
			}
		}

		public static void SetColorOfLights(global::UnityEngine.Color color, global::System.Collections.Generic.IEnumerable<global::MapGeneration.FacilityZone> zones)
		{
			foreach (global::LabApi.Features.Wrappers.LightsController item in global::LabApi.Features.Wrappers.LightsController.List)
			{
				if (global::System.Linq.Enumerable.Contains(zones, item.Room.Zone))
				{
					item.OverrideLightsColor = color;
				}
			}
		}

		public static void ResetColorOfLights()
		{
			foreach (global::LabApi.Features.Wrappers.LightsController item in global::LabApi.Features.Wrappers.LightsController.List)
			{
				item.OverrideLightsColor = global::UnityEngine.Color.clear;
			}
		}

		public static void ResetColorOfLights(global::MapGeneration.FacilityZone zone)
		{
			foreach (global::LabApi.Features.Wrappers.LightsController item in global::LabApi.Features.Wrappers.LightsController.List)
			{
				if (item.Room.Zone == zone)
				{
					item.OverrideLightsColor = global::UnityEngine.Color.clear;
				}
			}
		}

		public static void ResetColorOfLights(global::System.Collections.Generic.IEnumerable<global::MapGeneration.FacilityZone> zones)
		{
			foreach (global::LabApi.Features.Wrappers.LightsController item in global::LabApi.Features.Wrappers.LightsController.List)
			{
				if (global::System.Linq.Enumerable.Contains(zones, item.Room.Zone))
				{
					item.OverrideLightsColor = global::UnityEngine.Color.clear;
				}
			}
		}
	}
}
