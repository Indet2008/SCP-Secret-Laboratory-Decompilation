namespace LabApi.Features.Wrappers
{
	public class WaypointToy : global::LabApi.Features.Wrappers.AdminToy
	{
		public const float MaxBounds = 255.9961f;

		public new static global::System.Collections.Generic.Dictionary<global::AdminToys.WaypointToy, global::LabApi.Features.Wrappers.WaypointToy> Dictionary { get; } = new global::System.Collections.Generic.Dictionary<global::AdminToys.WaypointToy, global::LabApi.Features.Wrappers.WaypointToy>();

		public new static global::System.Collections.Generic.IReadOnlyCollection<global::LabApi.Features.Wrappers.WaypointToy> List => Dictionary.Values;

		public new global::AdminToys.WaypointToy Base { get; }

		public override global::UnityEngine.Vector3 Position
		{
			get
			{
				return base.Position;
			}
			set
			{
				base.Position = value;
				Base.UpdateWaypointChildren();
			}
		}

		public override global::UnityEngine.Quaternion Rotation
		{
			get
			{
				return base.Rotation;
			}
			set
			{
				base.Rotation = value;
				Base.UpdateWaypointChildren();
			}
		}

		public override global::UnityEngine.Vector3 Scale
		{
			get
			{
				return base.Scale;
			}
			set
			{
				base.Scale = value;
				if (value != global::UnityEngine.Vector3.one)
				{
					global::LabApi.Features.Console.Logger.Warn("Setting scale on WaypointToy is not supported and may cause problems.");
				}
			}
		}

		public global::UnityEngine.Vector3 BoundsSize
		{
			get
			{
				return Base.BoundsSize;
			}
			set
			{
				Base.NetworkBoundsSize = value;
			}
		}

		public bool VisualizeBounds
		{
			get
			{
				return Base.VisualizeBounds;
			}
			set
			{
				Base.NetworkVisualizeBounds = value;
			}
		}

		public float PriorityBias
		{
			get
			{
				return Base.Priority;
			}
			set
			{
				Base.NetworkPriority = value;
			}
		}

		public static global::LabApi.Features.Wrappers.WaypointToy Create(global::UnityEngine.Transform? parent = null, bool networkSpawn = true)
		{
			return Create(global::UnityEngine.Vector3.zero, parent, networkSpawn);
		}

		public static global::LabApi.Features.Wrappers.WaypointToy Create(global::UnityEngine.Vector3 position, global::UnityEngine.Transform? parent = null, bool networkSpawn = true)
		{
			return Create(position, global::UnityEngine.Quaternion.identity, parent, networkSpawn);
		}

		public static global::LabApi.Features.Wrappers.WaypointToy Create(global::UnityEngine.Vector3 position, global::UnityEngine.Quaternion rotation, global::UnityEngine.Transform? parent = null, bool networkSpawn = true)
		{
			return Create(position, rotation, global::UnityEngine.Vector3.one, parent, networkSpawn);
		}

		public static global::LabApi.Features.Wrappers.WaypointToy Create(global::UnityEngine.Vector3 position, global::UnityEngine.Quaternion rotation, global::UnityEngine.Vector3 scale, global::UnityEngine.Transform? parent = null, bool networkSpawn = true)
		{
			global::LabApi.Features.Wrappers.WaypointToy waypointToy = Get(global::LabApi.Features.Wrappers.AdminToy.Create<global::AdminToys.WaypointToy>(position, rotation, scale, parent));
			if (networkSpawn)
			{
				waypointToy.Spawn();
			}
			return waypointToy;
		}

		[return: global::System.Diagnostics.CodeAnalysis.NotNullIfNotNull("baseWaypointToy")]
		public static global::LabApi.Features.Wrappers.WaypointToy? Get(global::AdminToys.WaypointToy? baseWaypointToy)
		{
			if (baseWaypointToy == null)
			{
				return null;
			}
			if (!Dictionary.TryGetValue(baseWaypointToy, out global::LabApi.Features.Wrappers.WaypointToy value))
			{
				return (global::LabApi.Features.Wrappers.WaypointToy)global::LabApi.Features.Wrappers.AdminToy.CreateAdminToyWrapper(baseWaypointToy);
			}
			return value;
		}

		public static bool TryGet(global::AdminToys.WaypointToy? baseWaypointToy, [global::System.Diagnostics.CodeAnalysis.NotNullWhen(true)] out global::LabApi.Features.Wrappers.WaypointToy? waypointToy)
		{
			waypointToy = Get(baseWaypointToy);
			return waypointToy != null;
		}

		internal WaypointToy(global::AdminToys.WaypointToy baseWaypointToy)
			: base(baseWaypointToy)
		{
			Dictionary.Add(baseWaypointToy, this);
			Base = baseWaypointToy;
		}

		public void UpdateWaypointChildren()
		{
			Base.UpdateWaypointChildren();
		}

		public override string ToString()
		{
			return $"[WaypointToy: Position:{Position}, BoundsSize:{BoundsSize}, VisualizeBounds:{VisualizeBounds}, PriorityBias:{PriorityBias}]";
		}

		internal override void OnRemove()
		{
			base.OnRemove();
			Dictionary.Remove(Base);
		}
	}
}
