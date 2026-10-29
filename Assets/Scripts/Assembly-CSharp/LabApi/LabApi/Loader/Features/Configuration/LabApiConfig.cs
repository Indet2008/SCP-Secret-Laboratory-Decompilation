namespace LabApi.Loader.Features.Configuration
{
	public class LabApiConfig
	{
		[global::System.ComponentModel.Description("List of dependency paths relative to the Dependencies folder to load from. Use $port to load from the server port's folder.")]
		public global::System.Collections.Generic.List<string> DependencyPaths { get; set; } = new global::System.Collections.Generic.List<string>(2) { "global", "$port" };

		[global::System.ComponentModel.Description("List of plugin paths relative to the Plugins folder to load from. Use $port to load from the server port's folder.")]
		public global::System.Collections.Generic.List<string> PluginPaths { get; set; } = new global::System.Collections.Generic.List<string>(2) { "global", "$port" };

		[global::System.ComponentModel.Description("Whether to allow loading plugins even if they were built for a different major version of LabAPI.")]
		public bool LoadUnsupportedPlugins { get; set; }
	}
}
