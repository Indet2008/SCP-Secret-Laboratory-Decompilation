namespace LabApi.Features.Wrappers
{
	public class Tesla
	{
		public static global::System.Collections.Generic.Dictionary<TeslaGate, global::LabApi.Features.Wrappers.Tesla> Dictionary { get; } = new global::System.Collections.Generic.Dictionary<TeslaGate, global::LabApi.Features.Wrappers.Tesla>();

		public static global::System.Collections.Generic.IReadOnlyCollection<global::LabApi.Features.Wrappers.Tesla> List => Dictionary.Values;

		private static global::System.Collections.Generic.Dictionary<global::MapGeneration.RoomIdentifier, global::LabApi.Features.Wrappers.Tesla> TeslaByRoom { get; } = new global::System.Collections.Generic.Dictionary<global::MapGeneration.RoomIdentifier, global::LabApi.Features.Wrappers.Tesla>();

		public TeslaGate Base { get; }

		public global::UnityEngine.Vector3 Position => Base.Position;

		public global::UnityEngine.Quaternion Rotation => Base.transform.rotation;

		public float InactiveTime
		{
			get
			{
				return Base.NetworkInactiveTime;
			}
			set
			{
				Base.NetworkInactiveTime = value;
				if (value > 0f)
				{
					Base.ServerSideIdle(shouldIdle: false);
				}
			}
		}

		public global::LabApi.Features.Wrappers.Room Room => global::LabApi.Features.Wrappers.Room.Get(Base.Room);

		public static global::LabApi.Features.Wrappers.Tesla Get(TeslaGate teslaGate)
		{
			if (!Dictionary.TryGetValue(teslaGate, out global::LabApi.Features.Wrappers.Tesla value))
			{
				return new global::LabApi.Features.Wrappers.Tesla(teslaGate);
			}
			return value;
		}

		public static bool TryGet(global::LabApi.Features.Wrappers.Room room, [global::System.Diagnostics.CodeAnalysis.NotNullWhen(true)] out global::LabApi.Features.Wrappers.Tesla? tesla)
		{
			return TeslaByRoom.TryGetValue(room.Base, out tesla);
		}

		[global::Generators.InitializeWrapper(128)]
		internal static void Initialize()
		{
			Dictionary.Clear();
			TeslaByRoom.Clear();
			TeslaGate.OnAdded += (TeslaGate tesla) =>
			{
				new global::LabApi.Features.Wrappers.Tesla(tesla);
			};
			TeslaGate.OnRemoved += (TeslaGate tesla) =>
			{
				Dictionary.Remove(tesla);
				TeslaByRoom.Remove(tesla.Room);
			};
		}

		private Tesla(TeslaGate tesla)
		{
			Dictionary.Add(tesla, this);
			TeslaByRoom.Add(tesla.Room, this);
			Base = tesla;
		}

		public bool IsPlayerInIdleRange(global::LabApi.Features.Wrappers.Player player)
		{
			return Base.IsInIdleRange(player.ReferenceHub);
		}

		public bool IsPlayerInRange(global::LabApi.Features.Wrappers.Player player)
		{
			return Base.PlayerInRange(player.ReferenceHub);
		}

		public bool IsAnyPlayerInIdleRange()
		{
			return global::Utils.NonAllocLINQ.HashsetExtensions.Any(ReferenceHub.AllHubs, Base.IsInIdleRange);
		}

		public bool IsAnyPlayerInRange()
		{
			return global::Utils.NonAllocLINQ.HashsetExtensions.Any(ReferenceHub.AllHubs, Base.PlayerInRange);
		}

		public void Trigger()
		{
			Base.ServerSideCode();
		}

		public void InstantTrigger()
		{
			Base.RpcInstantBurst();
		}
	}
}
