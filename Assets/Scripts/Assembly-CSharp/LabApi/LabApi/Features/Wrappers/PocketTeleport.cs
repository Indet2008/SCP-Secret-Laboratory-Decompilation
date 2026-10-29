namespace LabApi.Features.Wrappers
{
	public class PocketTeleport
	{
		public static global::System.Collections.Generic.IReadOnlyCollection<global::LabApi.Features.Wrappers.PocketTeleport> List => Dictionary.Values;

		private static global::System.Collections.Generic.Dictionary<PocketDimensionTeleport, global::LabApi.Features.Wrappers.PocketTeleport> Dictionary { get; } = new global::System.Collections.Generic.Dictionary<PocketDimensionTeleport, global::LabApi.Features.Wrappers.PocketTeleport>();

		public PocketDimensionTeleport Base { get; }

		public global::UnityEngine.GameObject GameObject => Base.gameObject;

		public global::UnityEngine.Transform Transform => Base.transform;

		public global::UnityEngine.SphereCollider Collider { get; }

		public bool IsExit
		{
			get
			{
				return Base.GetTeleportType() == PocketDimensionTeleport.PDTeleportType.Exit;
			}
			set
			{
				Base.SetType(value ? PocketDimensionTeleport.PDTeleportType.Exit : PocketDimensionTeleport.PDTeleportType.Killer);
			}
		}

		public global::UnityEngine.Vector3 Position
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

		public global::UnityEngine.Quaternion Rotation
		{
			get
			{
				return Transform.rotation;
			}
			set
			{
				Transform.rotation = value;
			}
		}

		public global::UnityEngine.Vector3 Scale
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

		public float Radius
		{
			get
			{
				return Collider.radius;
			}
			set
			{
				Collider.radius = value;
			}
		}

		[return: global::System.Diagnostics.CodeAnalysis.NotNullIfNotNull("pocketTeleport")]
		public static global::LabApi.Features.Wrappers.PocketTeleport? Get(PocketDimensionTeleport? pocketTeleport)
		{
			if (pocketTeleport == null)
			{
				return null;
			}
			if (Dictionary.TryGetValue(pocketTeleport, out global::LabApi.Features.Wrappers.PocketTeleport value))
			{
				return value;
			}
			return new global::LabApi.Features.Wrappers.PocketTeleport(pocketTeleport);
		}

		[global::Generators.InitializeWrapper(128)]
		internal static void Initialize()
		{
			PocketDimensionTeleport.OnAdded += OnAdded;
			PocketDimensionTeleport.OnRemoved += OnRemoved;
		}

		private static void OnAdded(PocketDimensionTeleport pocketTeleport)
		{
			if (!Dictionary.ContainsKey(pocketTeleport))
			{
				new global::LabApi.Features.Wrappers.PocketTeleport(pocketTeleport);
			}
		}

		private static void OnRemoved(PocketDimensionTeleport pocketTeleport)
		{
			Dictionary.Remove(pocketTeleport);
		}

		internal PocketTeleport(PocketDimensionTeleport pocketDimensionTeleport)
		{
			Dictionary.Add(pocketDimensionTeleport, this);
			Base = pocketDimensionTeleport;
			Collider = Base.GetComponent<global::UnityEngine.SphereCollider>();
		}

		public global::LabApi.Features.Wrappers.PocketTeleport Spawn(global::UnityEngine.Vector3 localPosition)
		{
			global::UnityEngine.GameObject gameObject = new global::UnityEngine.GameObject("Teleport", typeof(PocketDimensionTeleport), typeof(global::UnityEngine.SphereCollider), typeof(global::Mirror.NetworkIdentity));
			PocketDimensionTeleport component = gameObject.GetComponent<PocketDimensionTeleport>();
			gameObject.transform.localPosition = localPosition;
			return Get(component);
		}

		public void Destroy()
		{
			global::UnityEngine.Object.Destroy(Base);
		}
	}
}
