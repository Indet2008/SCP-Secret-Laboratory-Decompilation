namespace LabApi.Loader.Features.Plugins.Configuration
{
	public class Properties
	{
		[global::System.ComponentModel.Description("Whether or not the plugin is enabled.")]
		public bool IsEnabled { get; set; } = true;

		[global::System.ComponentModel.Description("Whether to allow loading the plugin even if it was built for a different major version of LabAPI. \"Default\" = use port-specific config; \"True\"/\"Enabled\" = load if unsupported; \"False\"/\"Disabled\" = do not load if unsupported")]
		public global::LabApi.Loader.Features.Plugins.Enums.OptionalBoolean UnsupportedLoading { get; set; } = global::LabApi.Loader.Features.Plugins.Enums.OptionalBoolean.Default;

		public static global::LabApi.Loader.Features.Plugins.Configuration.Properties CreateDefault()
		{
			return new global::LabApi.Loader.Features.Plugins.Configuration.Properties();
		}
	}
}
