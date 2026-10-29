namespace LabApi.Features.Wrappers
{
	public class Structure
	{
		private static readonly global::System.Collections.Generic.Dictionary<global::System.Type, global::System.Func<global::MapGeneration.Distributors.SpawnableStructure, global::LabApi.Features.Wrappers.Structure>> TypeWrappers = new global::System.Collections.Generic.Dictionary<global::System.Type, global::System.Func<global::MapGeneration.Distributors.SpawnableStructure, global::LabApi.Features.Wrappers.Structure>>();

		public static global::System.Collections.Generic.Dictionary<global::MapGeneration.Distributors.SpawnableStructure, global::LabApi.Features.Wrappers.Structure> Dictionary { get; } = new global::System.Collections.Generic.Dictionary<global::MapGeneration.Distributors.SpawnableStructure, global::LabApi.Features.Wrappers.Structure>();

		public static global::System.Collections.Generic.IReadOnlyCollection<global::LabApi.Features.Wrappers.Structure> List => Dictionary.Values;

		public global::MapGeneration.Distributors.SpawnableStructure Base { get; }

		public global::MapGeneration.Distributors.StructurePositionSync StructurePositionSync { get; }

		public global::UnityEngine.GameObject GameObject => Base.gameObject;

		public global::UnityEngine.Transform Transform => Base.transform;

		public global::UnityEngine.Vector3 Position
		{
			get
			{
				return Transform.position;
			}
			set
			{
				Transform.position = value;
				StructurePositionSync.Network_position = value;
			}
		}

		public float RotationY
		{
			get
			{
				return Transform.rotation.eulerAngles.y;
			}
			set
			{
				Transform.rotation = global::UnityEngine.Quaternion.AngleAxis(value, global::UnityEngine.Vector3.up);
				StructurePositionSync.Network_rotationY = (sbyte)global::UnityEngine.Mathf.RoundToInt(value / 5.625f);
			}
		}

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

		public global::LabApi.Features.Wrappers.Room? Room => global::LabApi.Features.Wrappers.Room.Get(Base.ParentRoom);

		protected internal bool CanCache
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

		[return: global::System.Diagnostics.CodeAnalysis.NotNullIfNotNull("spawnableStructure")]
		public static global::LabApi.Features.Wrappers.Structure? Get(global::MapGeneration.Distributors.SpawnableStructure? spawnableStructure)
		{
			if (spawnableStructure == null)
			{
				return null;
			}
			if (!Dictionary.TryGetValue(spawnableStructure, out global::LabApi.Features.Wrappers.Structure value))
			{
				return CreateStructureWrapper(spawnableStructure);
			}
			return value;
		}

		public static bool TryGet(global::MapGeneration.Distributors.SpawnableStructure? spawnableStructure, [global::System.Diagnostics.CodeAnalysis.NotNullWhen(true)] out global::LabApi.Features.Wrappers.Structure? structure)
		{
			structure = Get(spawnableStructure);
			return structure != null;
		}

		[global::Generators.InitializeWrapper(128)]
		internal static void Initialize()
		{
			global::MapGeneration.Distributors.SpawnableStructure.OnAdded += OnAdded;
			global::MapGeneration.Distributors.SpawnableStructure.OnRemoved += OnRemoved;
			Register((global::MapGeneration.Distributors.SpawnableStructure x) => (x.StructureType != global::MapGeneration.Distributors.StructureType.Workstation) ? null : new global::LabApi.Features.Wrappers.Workstation(x));
			Register((global::MapGeneration.Distributors.Scp079Generator x) => new global::LabApi.Features.Wrappers.Generator(x));
			Register((global::MapGeneration.Distributors.Locker x) => x.StructureType switch
			{
				global::MapGeneration.Distributors.StructureType.SmallWallCabinet => new global::LabApi.Features.Wrappers.WallCabinet(x), 
				global::MapGeneration.Distributors.StructureType.StandardLocker => new global::LabApi.Features.Wrappers.StandardLocker(x), 
				global::MapGeneration.Distributors.StructureType.LargeGunLocker => (x.Chambers.Length > 9) ? ((global::LabApi.Features.Wrappers.Locker)new global::LabApi.Features.Wrappers.LargeLocker(x)) : ((global::LabApi.Features.Wrappers.Locker)new global::LabApi.Features.Wrappers.RifleRackLocker(x)), 
				_ => null, 
			});
			Register((global::MapGeneration.Distributors.PedestalScpLocker x) => new global::LabApi.Features.Wrappers.PedestalLocker(x));
			Register((global::MapGeneration.Distributors.ExperimentalWeaponLocker x) => new global::LabApi.Features.Wrappers.ExperimentalWeaponLocker(x));
			Register((global::InventorySystem.Items.MicroHID.MicroHIDPedestal x) => new global::LabApi.Features.Wrappers.MicroPedestal(x));
		}

		protected static global::LabApi.Features.Wrappers.Structure CreateStructureWrapper(global::MapGeneration.Distributors.SpawnableStructure structure)
		{
			global::System.Type type = structure.GetType();
			if (!TypeWrappers.TryGetValue(type, out global::System.Func<global::MapGeneration.Distributors.SpawnableStructure, global::LabApi.Features.Wrappers.Structure> value))
			{
				return new global::LabApi.Features.Wrappers.Structure(structure);
			}
			global::LabApi.Features.Wrappers.Structure structure2 = value?.Invoke(structure);
			if (structure2 == null)
			{
				global::LabApi.Features.Console.Logger.Error($"Failed to create structure wrapper. A handler returned null for type {structure.GetType()}");
				return null;
			}
			return structure2;
		}

		private static void OnAdded(global::MapGeneration.Distributors.SpawnableStructure structure)
		{
			if (!Dictionary.ContainsKey(structure))
			{
				CreateStructureWrapper(structure);
			}
		}

		private static void OnRemoved(global::MapGeneration.Distributors.SpawnableStructure spawnableStructure)
		{
			if (Dictionary.TryGetValue(spawnableStructure, out global::LabApi.Features.Wrappers.Structure value))
			{
				value.OnRemove();
			}
		}

		private static void Register<T>(global::System.Func<T, global::LabApi.Features.Wrappers.Structure> constructor) where T : global::MapGeneration.Distributors.SpawnableStructure
		{
			TypeWrappers.Add(typeof(T), (global::MapGeneration.Distributors.SpawnableStructure x) => constructor((T)x));
		}

		internal Structure(global::MapGeneration.Distributors.SpawnableStructure spawnableStructure)
		{
			Base = spawnableStructure;
			StructurePositionSync = Base.gameObject.GetComponent<global::MapGeneration.Distributors.StructurePositionSync>();
			if (CanCache)
			{
				Dictionary.Add(spawnableStructure, this);
			}
		}

		public void Spawn()
		{
			global::Mirror.NetworkServer.Spawn(GameObject);
		}

		public void Destroy()
		{
			global::Mirror.NetworkServer.Destroy(GameObject);
		}

		public override string ToString()
		{
			return $"[{GetType().Name}: Position={Position}, RotationY={RotationY}, IsDestroyed={IsDestroyed}]";
		}

		internal virtual void OnRemove()
		{
			Dictionary.Remove(Base);
		}
	}
}
