namespace LabApi.Features.Wrappers
{
	public class Camera
	{
		public static global::System.Collections.Generic.Dictionary<global::PlayerRoles.PlayableScps.Scp079.Cameras.Scp079Camera, global::LabApi.Features.Wrappers.Camera> Dictionary { get; } = new global::System.Collections.Generic.Dictionary<global::PlayerRoles.PlayableScps.Scp079.Cameras.Scp079Camera, global::LabApi.Features.Wrappers.Camera>();

		public static global::System.Collections.Generic.IReadOnlyCollection<global::LabApi.Features.Wrappers.Camera> List => Dictionary.Values;

		public global::PlayerRoles.PlayableScps.Scp079.Cameras.Scp079Camera Base { get; }

		public global::UnityEngine.GameObject GameObject => Base.gameObject;

		public global::UnityEngine.Vector3 Position => Base.Position;

		public global::UnityEngine.Quaternion Rotation
		{
			get
			{
				return Base.CameraAnchor.rotation;
			}
			set
			{
				Base.CameraAnchor.rotation = value;
			}
		}

		public global::LabApi.Features.Wrappers.Room Room => global::LabApi.Features.Wrappers.Room.Get(Base.Room);

		public float Zoom => Base.ZoomAxis.CurrentZoom;

		public bool IsBeingUsed
		{
			get
			{
				return Base.IsActive;
			}
			set
			{
				Base.IsActive = value;
			}
		}

		[return: global::System.Diagnostics.CodeAnalysis.NotNullIfNotNull("camera")]
		public static global::LabApi.Features.Wrappers.Camera? Get(global::PlayerRoles.PlayableScps.Scp079.Cameras.Scp079Camera? camera)
		{
			if (camera == null)
			{
				return null;
			}
			if (!TryGet(camera, out global::LabApi.Features.Wrappers.Camera wrapper))
			{
				return new global::LabApi.Features.Wrappers.Camera(camera);
			}
			return wrapper;
		}

		public static bool TryGet(global::PlayerRoles.PlayableScps.Scp079.Cameras.Scp079Camera camera, [global::System.Diagnostics.CodeAnalysis.NotNullWhen(true)] out global::LabApi.Features.Wrappers.Camera? wrapper)
		{
			wrapper = null;
			if (camera != null)
			{
				return Dictionary.TryGetValue(camera, out wrapper);
			}
			return false;
		}

		[global::Generators.InitializeWrapper(128)]
		internal static void Initialize()
		{
			Dictionary.Clear();
			global::PlayerRoles.PlayableScps.Scp079.Cameras.Scp079Camera.OnInstanceCreated += (global::PlayerRoles.PlayableScps.Scp079.Cameras.Scp079Camera camera) =>
			{
				new global::LabApi.Features.Wrappers.Camera(camera);
			};
			global::PlayerRoles.PlayableScps.Scp079.Cameras.Scp079Camera.OnInstanceRemoved += (global::PlayerRoles.PlayableScps.Scp079.Cameras.Scp079Camera camera) =>
			{
				Remove(camera);
			};
		}

		private static void Remove(global::PlayerRoles.PlayableScps.Scp079.Cameras.Scp079Camera camera)
		{
			Dictionary.Remove(camera);
		}

		private Camera(global::PlayerRoles.PlayableScps.Scp079.Cameras.Scp079Camera camera)
		{
			Dictionary.Add(camera, this);
			Base = camera;
		}

		public override string ToString()
		{
			return $"[Camera: Position={Position}, Rotation={Rotation}, Room={Room}, Zoom={Zoom}, IsBeingUsed={IsBeingUsed}]";
		}
	}
}
