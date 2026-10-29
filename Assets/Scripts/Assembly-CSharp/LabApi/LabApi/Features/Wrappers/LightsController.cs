namespace LabApi.Features.Wrappers
{
	public class LightsController
	{
		public static global::System.Collections.Generic.IReadOnlyCollection<global::LabApi.Features.Wrappers.LightsController> List => Dictionary.Values;

		private static global::System.Collections.Generic.Dictionary<RoomLightController, global::LabApi.Features.Wrappers.LightsController> Dictionary { get; } = new global::System.Collections.Generic.Dictionary<RoomLightController, global::LabApi.Features.Wrappers.LightsController>();

		public RoomLightController Base { get; }

		public global::LabApi.Features.Wrappers.Room Room => global::LabApi.Features.Wrappers.Room.Get(Base.Room);

		public bool LightsEnabled
		{
			get
			{
				return Base.NetworkLightsEnabled;
			}
			set
			{
				Base.NetworkLightsEnabled = value;
			}
		}

		public global::UnityEngine.Color OverrideLightsColor
		{
			get
			{
				return Base.NetworkOverrideColor;
			}
			set
			{
				Base.NetworkOverrideColor = value;
			}
		}

		[return: global::System.Diagnostics.CodeAnalysis.NotNullIfNotNull("roomLightController")]
		public static global::LabApi.Features.Wrappers.LightsController? Get(RoomLightController roomLightController)
		{
			if (roomLightController == null)
			{
				return null;
			}
			if (!Dictionary.TryGetValue(roomLightController, out global::LabApi.Features.Wrappers.LightsController value))
			{
				return new global::LabApi.Features.Wrappers.LightsController(roomLightController);
			}
			return value;
		}

		[global::Generators.InitializeWrapper(128)]
		internal static void Initialize()
		{
			RoomLightController.OnAdded += (RoomLightController roomLightController) =>
			{
				new global::LabApi.Features.Wrappers.LightsController(roomLightController);
			};
			RoomLightController.OnRemoved += (RoomLightController roomLightController) =>
			{
				Dictionary.Remove(roomLightController);
			};
		}

		private LightsController(RoomLightController original)
		{
			Dictionary.Add(original, this);
			Base = original;
		}

		public void FlickerLights(float duration)
		{
			Base.ServerFlickerLights(duration);
		}
	}
}
