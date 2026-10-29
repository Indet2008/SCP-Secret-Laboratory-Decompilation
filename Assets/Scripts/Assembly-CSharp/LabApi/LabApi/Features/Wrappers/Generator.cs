namespace LabApi.Features.Wrappers
{
	public class Generator : global::LabApi.Features.Wrappers.Structure
	{
		public new static global::System.Collections.Generic.Dictionary<global::MapGeneration.Distributors.Scp079Generator, global::LabApi.Features.Wrappers.Generator> Dictionary { get; } = new global::System.Collections.Generic.Dictionary<global::MapGeneration.Distributors.Scp079Generator, global::LabApi.Features.Wrappers.Generator>();

		public new static global::System.Collections.Generic.IReadOnlyCollection<global::LabApi.Features.Wrappers.Generator> List => Dictionary.Values;

		private static global::System.Collections.Generic.Dictionary<global::LabApi.Features.Wrappers.Room, global::System.Collections.Generic.List<global::LabApi.Features.Wrappers.Generator>> GeneratorsByRoom { get; } = new global::System.Collections.Generic.Dictionary<global::LabApi.Features.Wrappers.Room, global::System.Collections.Generic.List<global::LabApi.Features.Wrappers.Generator>>();

		public new global::MapGeneration.Distributors.Scp079Generator Base { get; }

		public float TotalActivationTime
		{
			get
			{
				return Base.TotalActivationTime;
			}
			set
			{
				Base.TotalActivationTime = value;
			}
		}

		public float TotalDeactivationTime
		{
			get
			{
				return Base.TotalDeactivationTime;
			}
			set
			{
				Base.TotalDeactivationTime = value;
			}
		}

		public global::Interactables.Interobjects.DoorUtils.DoorPermissionFlags RequiredPermissions
		{
			get
			{
				return Base.RequiredPermissions;
			}
			set
			{
				Base.RequiredPermissions = value;
			}
		}

		public float DropdownSpeed => Base.DropdownSpeed;

		public bool ActivationReady => Base.ActivationReady;

		public bool IsOpen
		{
			get
			{
				return Base.IsOpen;
			}
			set
			{
				Base.IsOpen = value;
			}
		}

		public bool IsUnlocked
		{
			get
			{
				return Base.IsUnlocked;
			}
			set
			{
				Base.IsUnlocked = value;
			}
		}

		public float ActivationTime => Base.ActivationTime;

		public bool Engaged
		{
			get
			{
				return Base.Engaged;
			}
			set
			{
				Base.Engaged = value;
			}
		}

		public bool Activating
		{
			get
			{
				return Base.Activating;
			}
			set
			{
				Base.Activating = value;
			}
		}

		public short RemainingTime
		{
			get
			{
				return Base.RemainingTime;
			}
			set
			{
				Base.RemainingTime = value;
			}
		}

		[return: global::System.Diagnostics.CodeAnalysis.NotNullIfNotNull("scp079Generator")]
		public static global::LabApi.Features.Wrappers.Generator? Get(global::MapGeneration.Distributors.Scp079Generator? scp079Generator)
		{
			if (scp079Generator == null)
			{
				return null;
			}
			if (!Dictionary.TryGetValue(scp079Generator, out global::LabApi.Features.Wrappers.Generator value))
			{
				return (global::LabApi.Features.Wrappers.Generator)global::LabApi.Features.Wrappers.Structure.CreateStructureWrapper(scp079Generator);
			}
			return value;
		}

		public static bool TryGetFromRoom(global::LabApi.Features.Wrappers.Room room, [global::System.Diagnostics.CodeAnalysis.NotNullWhen(true)] out global::System.Collections.Generic.List<global::LabApi.Features.Wrappers.Generator>? generators)
		{
			return GeneratorsByRoom.TryGetValue(room, out generators);
		}

		[global::Generators.InitializeWrapper(128)]
		internal static void InitializeCaching()
		{
			global::MapGeneration.SeedSynchronizer.OnGenerationFinished += SeedSynchronizer_OnGenerationFinished;
		}

		private static void SeedSynchronizer_OnGenerationFinished()
		{
			foreach (global::LabApi.Features.Wrappers.Generator item in List)
			{
				item.TryRegisterByRoom();
			}
		}

		internal Generator(global::MapGeneration.Distributors.Scp079Generator generator)
			: base(generator)
		{
			Base = generator;
			if (base.CanCache)
			{
				Dictionary.Add(generator, this);
				TryRegisterByRoom();
			}
		}

		public void ServerInteract(global::LabApi.Features.Wrappers.Player player, global::MapGeneration.Distributors.Scp079Generator.GeneratorColliderId collider)
		{
			Base.ServerInteract(player.ReferenceHub, (byte)collider);
		}

		public void PlayerDeniedBeep(global::Interactables.Interobjects.DoorUtils.DoorPermissionFlags flags)
		{
			Base.RpcDenied(flags);
		}

		internal override void OnRemove()
		{
			base.OnRemove();
			if (Base.ParentRoom == null)
			{
				Dictionary.Remove(Base);
				return;
			}
			global::LabApi.Features.Wrappers.Room room = global::LabApi.Features.Wrappers.Room.Get(Base.ParentRoom);
			if (room == null)
			{
				global::LabApi.Features.Wrappers.Room room2 = null;
				foreach (global::System.Collections.Generic.KeyValuePair<global::LabApi.Features.Wrappers.Room, global::System.Collections.Generic.List<global::LabApi.Features.Wrappers.Generator>> item in GeneratorsByRoom)
				{
					if (item.Value.Contains(this))
					{
						room2 = item.Key;
						break;
					}
				}
				room = room2;
			}
			if (room != null && GeneratorsByRoom.TryGetValue(room, out global::System.Collections.Generic.List<global::LabApi.Features.Wrappers.Generator> value))
			{
				value.Remove(this);
				if (value.Count == 0)
				{
					GeneratorsByRoom.Remove(room);
				}
			}
			Dictionary.Remove(Base);
		}

		private void TryRegisterByRoom()
		{
			foreach (global::System.Collections.Generic.KeyValuePair<global::LabApi.Features.Wrappers.Room, global::System.Collections.Generic.List<global::LabApi.Features.Wrappers.Generator>> item in GeneratorsByRoom)
			{
				if (item.Value.Contains(this))
				{
					return;
				}
			}
			if (Base.ParentRoom == null)
			{
				return;
			}
			global::LabApi.Features.Wrappers.Room room = global::LabApi.Features.Wrappers.Room.Get(Base.ParentRoom);
			if (room != null)
			{
				if (!GeneratorsByRoom.TryGetValue(room, out global::System.Collections.Generic.List<global::LabApi.Features.Wrappers.Generator> value))
				{
					value = new global::System.Collections.Generic.List<global::LabApi.Features.Wrappers.Generator>();
					GeneratorsByRoom.Add(room, value);
				}
				value.Add(this);
			}
		}
	}
}
