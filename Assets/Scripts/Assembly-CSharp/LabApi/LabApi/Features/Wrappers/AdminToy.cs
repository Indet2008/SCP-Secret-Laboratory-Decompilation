namespace LabApi.Features.Wrappers
{
	public class AdminToy
	{
		internal static class PrefabCache<T> where T : global::Mirror.NetworkBehaviour
		{
			public static T? Prefab { get; set; }
		}

		private static readonly global::System.Collections.Generic.Dictionary<global::System.Type, global::System.Func<global::AdminToys.AdminToyBase, global::LabApi.Features.Wrappers.AdminToy?>> _typeWrappers = new global::System.Collections.Generic.Dictionary<global::System.Type, global::System.Func<global::AdminToys.AdminToyBase, global::LabApi.Features.Wrappers.AdminToy>>();

		public static global::System.Collections.Generic.Dictionary<global::AdminToys.AdminToyBase, global::LabApi.Features.Wrappers.AdminToy> Dictionary { get; } = new global::System.Collections.Generic.Dictionary<global::AdminToys.AdminToyBase, global::LabApi.Features.Wrappers.AdminToy>();

		public static global::System.Collections.Generic.IReadOnlyCollection<global::LabApi.Features.Wrappers.AdminToy> List => Dictionary.Values;

		public global::AdminToys.AdminToyBase Base { get; }

		public global::UnityEngine.GameObject GameObject => Base.gameObject;

		public global::UnityEngine.Transform Transform => Base.transform;

		public bool IsDestroyed => Base == null;

		public virtual global::UnityEngine.Vector3 Position
		{
			get
			{
				return Transform.localPosition;
			}
			set
			{
				Transform.localPosition = value;
			}
		}

		public virtual global::UnityEngine.Quaternion Rotation
		{
			get
			{
				return Transform.localRotation;
			}
			set
			{
				Transform.localRotation = value;
			}
		}

		public virtual global::UnityEngine.Vector3 Scale
		{
			get
			{
				return Transform.localScale;
			}
			set
			{
				Transform.localScale = value;
			}
		}

		public global::UnityEngine.Transform? Parent
		{
			get
			{
				return Transform.parent;
			}
			set
			{
				Transform.SetParent(value, worldPositionStays: false);
			}
		}

		public byte MovementSmoothing
		{
			get
			{
				return (byte)((Base.MovementSmoothing != 0) ? ((uint)(256 - Base.MovementSmoothing)) : 0u);
			}
			set
			{
				Base.NetworkMovementSmoothing = (byte)((value != 0) ? ((uint)(256 - value)) : 0u);
			}
		}

		public bool IsStatic
		{
			get
			{
				return Base.IsStatic;
			}
			set
			{
				Base.NetworkIsStatic = value;
			}
		}

		public float SyncInterval
		{
			get
			{
				return Base.syncInterval;
			}
			set
			{
				Base.syncInterval = value;
			}
		}

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

		[return: global::System.Diagnostics.CodeAnalysis.NotNullIfNotNull("adminToyBase")]
		public static global::LabApi.Features.Wrappers.AdminToy? Get(global::AdminToys.AdminToyBase? adminToyBase)
		{
			if (adminToyBase == null)
			{
				return null;
			}
			if (!Dictionary.TryGetValue(adminToyBase, out global::LabApi.Features.Wrappers.AdminToy value))
			{
				return CreateAdminToyWrapper(adminToyBase);
			}
			return value;
		}

		public static bool TryGet(global::AdminToys.AdminToyBase? adminToyBase, [global::System.Diagnostics.CodeAnalysis.NotNullWhen(true)] out global::LabApi.Features.Wrappers.AdminToy? adminToy)
		{
			adminToy = Get(adminToyBase);
			return adminToy != null;
		}

		[global::Generators.InitializeWrapper(128)]
		internal static void Initialize()
		{
			global::AdminToys.AdminToyBase.OnAdded += AddAdminToy;
			global::AdminToys.AdminToyBase.OnRemoved += RemoveAdminToy;
			Register((global::AdminToys.PrimitiveObjectToy x) => new global::LabApi.Features.Wrappers.PrimitiveObjectToy(x));
			Register((global::AdminToys.LightSourceToy x) => new global::LabApi.Features.Wrappers.LightSourceToy(x));
			Register((global::AdminToys.ShootingTarget x) => new global::LabApi.Features.Wrappers.ShootingTargetToy(x));
			Register((global::AdminToys.SpeakerToy x) => new global::LabApi.Features.Wrappers.SpeakerToy(x));
			Register((global::AdminToys.InvisibleInteractableToy x) => new global::LabApi.Features.Wrappers.InteractableToy(x));
			Register((global::AdminToys.Scp079CameraToy x) => new global::LabApi.Features.Wrappers.CameraToy(x));
			Register((global::AdminToys.CapybaraToy x) => new global::LabApi.Features.Wrappers.CapybaraToy(x));
			Register((global::AdminToys.TextToy x) => new global::LabApi.Features.Wrappers.TextToy(x));
			Register((global::AdminToys.WaypointToy x) => new global::LabApi.Features.Wrappers.WaypointToy(x));
		}

		protected static T Create<T>(global::UnityEngine.Vector3 position, global::UnityEngine.Quaternion rotation, global::UnityEngine.Vector3 scale, global::UnityEngine.Transform? parent) where T : global::AdminToys.AdminToyBase
		{
			if (global::LabApi.Features.Wrappers.AdminToy.PrefabCache<T>.Prefab == null)
			{
				T component = null;
				using (global::System.Collections.Generic.Dictionary<uint, global::UnityEngine.GameObject>.ValueCollection.Enumerator enumerator = global::Mirror.NetworkClient.prefabs.Values.GetEnumerator())
				{
					while (enumerator.MoveNext() && !enumerator.Current.TryGetComponent<T>(out component))
					{
					}
				}
				if (component == null)
				{
					throw new global::System.InvalidOperationException($"No prefab in NetworkClient.prefabs has component type {typeof(T)}");
				}
				global::LabApi.Features.Wrappers.AdminToy.PrefabCache<T>.Prefab = component;
			}
			T? val = global::UnityEngine.Object.Instantiate(global::LabApi.Features.Wrappers.AdminToy.PrefabCache<T>.Prefab, parent);
			val.transform.localPosition = position;
			val.transform.localRotation = rotation;
			val.transform.localScale = scale;
			return val;
		}

		protected static global::LabApi.Features.Wrappers.AdminToy CreateAdminToyWrapper(global::AdminToys.AdminToyBase adminToyBase)
		{
			if (!_typeWrappers.TryGetValue(adminToyBase.GetType(), out global::System.Func<global::AdminToys.AdminToyBase, global::LabApi.Features.Wrappers.AdminToy> value))
			{
				global::LabApi.Features.Console.Logger.InternalWarn($"Backing up to the default AdminToy constructor. Missing constructor handler for type {adminToyBase.GetType()}");
				return new global::LabApi.Features.Wrappers.AdminToy(adminToyBase);
			}
			global::LabApi.Features.Wrappers.AdminToy adminToy = value(adminToyBase);
			if (adminToy == null)
			{
				global::LabApi.Features.Console.Logger.InternalWarn($"Backing up to the default AdminToy constructor. A handler returned null for type {adminToyBase.GetType()}");
				return new global::LabApi.Features.Wrappers.AdminToy(adminToyBase);
			}
			return adminToy;
		}

		private static void AddAdminToy(global::AdminToys.AdminToyBase adminToyBase)
		{
			try
			{
				if (!Dictionary.ContainsKey(adminToyBase))
				{
					CreateAdminToyWrapper(adminToyBase);
				}
			}
			catch (global::System.Exception arg)
			{
				global::LabApi.Features.Console.Logger.InternalError($"Failed to handle admin toy creation with error: {arg}");
			}
		}

		private static void RemoveAdminToy(global::AdminToys.AdminToyBase adminToyBase)
		{
			try
			{
				if (Dictionary.Remove(adminToyBase, out global::LabApi.Features.Wrappers.AdminToy value))
				{
					value.OnRemove();
				}
			}
			catch (global::System.Exception arg)
			{
				global::LabApi.Features.Console.Logger.InternalError($"Failed to handle admin toy destruction with error: {arg}");
			}
		}

		private static void Register<T>(global::System.Func<T, global::LabApi.Features.Wrappers.AdminToy?> constructor) where T : global::AdminToys.AdminToyBase
		{
			_typeWrappers.Add(typeof(T), (global::AdminToys.AdminToyBase x) => constructor((T)x));
		}

		protected AdminToy(global::AdminToys.AdminToyBase adminToyBase)
		{
			Base = adminToyBase;
			if (CanCache)
			{
				Dictionary.Add(adminToyBase, this);
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

		internal virtual void OnRemove()
		{
		}
	}
}
