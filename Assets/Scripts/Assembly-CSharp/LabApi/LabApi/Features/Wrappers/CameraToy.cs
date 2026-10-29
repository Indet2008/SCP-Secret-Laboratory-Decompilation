namespace LabApi.Features.Wrappers
{
	public class CameraToy : global::LabApi.Features.Wrappers.AdminToy
	{
		public new static global::System.Collections.Generic.Dictionary<global::AdminToys.Scp079CameraToy, global::LabApi.Features.Wrappers.CameraToy> Dictionary { get; } = new global::System.Collections.Generic.Dictionary<global::AdminToys.Scp079CameraToy, global::LabApi.Features.Wrappers.CameraToy>();

		public new static global::System.Collections.Generic.IReadOnlyCollection<global::LabApi.Features.Wrappers.CameraToy> List => Dictionary.Values;

		public new global::AdminToys.Scp079CameraToy Base { get; }

		public global::LabApi.Features.Wrappers.Camera Camera => global::LabApi.Features.Wrappers.Camera.Get(Base.Camera);

		public string Label
		{
			get
			{
				return Base.Label;
			}
			set
			{
				Base.NetworkLabel = value;
			}
		}

		public global::LabApi.Features.Wrappers.Room Room
		{
			get
			{
				return global::LabApi.Features.Wrappers.Room.Get(Base.Room);
			}
			set
			{
				Base.NetworkRoom = value.Base;
			}
		}

		public global::UnityEngine.Vector2 VerticalConstraints
		{
			get
			{
				return Base.VerticalConstraint;
			}
			set
			{
				Base.NetworkVerticalConstraint = value;
			}
		}

		public global::UnityEngine.Vector2 HorizontalConstraint
		{
			get
			{
				return Base.HorizontalConstraint;
			}
			set
			{
				Base.NetworkHorizontalConstraint = value;
			}
		}

		public global::UnityEngine.Vector2 ZoomConstraints
		{
			get
			{
				return Base.ZoomConstraint;
			}
			set
			{
				Base.NetworkZoomConstraint = value;
			}
		}

		public static global::LabApi.Features.Wrappers.CameraToy Create(global::UnityEngine.Transform? parent = null, bool networkSpawn = true)
		{
			return Create(global::UnityEngine.Vector3.zero, parent, networkSpawn);
		}

		public static global::LabApi.Features.Wrappers.CameraToy Create(global::UnityEngine.Vector3 position, global::UnityEngine.Transform? parent = null, bool networkSpawn = true)
		{
			return Create(position, global::UnityEngine.Quaternion.identity, parent, networkSpawn);
		}

		public static global::LabApi.Features.Wrappers.CameraToy Create(global::UnityEngine.Vector3 position, global::UnityEngine.Quaternion rotation, global::UnityEngine.Transform? parent = null, bool networkSpawn = true)
		{
			return Create(position, rotation, global::UnityEngine.Vector3.one, parent, networkSpawn);
		}

		public static global::LabApi.Features.Wrappers.CameraToy Create(global::UnityEngine.Vector3 position, global::UnityEngine.Quaternion rotation, global::UnityEngine.Vector3 scale, global::UnityEngine.Transform? parent = null, bool networkSpawn = true)
		{
			global::LabApi.Features.Wrappers.CameraToy cameraToy = Get(global::LabApi.Features.Wrappers.AdminToy.Create<global::AdminToys.Scp079CameraToy>(position, rotation, scale, parent));
			if (networkSpawn)
			{
				cameraToy.Spawn();
			}
			return cameraToy;
		}

		[return: global::System.Diagnostics.CodeAnalysis.NotNullIfNotNull("baseCameraToy")]
		public static global::LabApi.Features.Wrappers.CameraToy? Get(global::AdminToys.Scp079CameraToy? baseCameraToy)
		{
			if (baseCameraToy == null)
			{
				return null;
			}
			if (!Dictionary.TryGetValue(baseCameraToy, out global::LabApi.Features.Wrappers.CameraToy value))
			{
				return (global::LabApi.Features.Wrappers.CameraToy)global::LabApi.Features.Wrappers.AdminToy.CreateAdminToyWrapper(baseCameraToy);
			}
			return value;
		}

		public static bool TryGet(global::AdminToys.Scp079CameraToy? baseCameraToy, [global::System.Diagnostics.CodeAnalysis.NotNullWhen(true)] out global::LabApi.Features.Wrappers.CameraToy? cameraToy)
		{
			cameraToy = Get(baseCameraToy);
			return cameraToy != null;
		}

		internal CameraToy(global::AdminToys.Scp079CameraToy baseCameraToy)
			: base(baseCameraToy)
		{
			Base = baseCameraToy;
			if (base.CanCache)
			{
				Dictionary.Add(baseCameraToy, this);
			}
		}

		internal override void OnRemove()
		{
			base.OnRemove();
			Dictionary.Remove(Base);
		}
	}
}
