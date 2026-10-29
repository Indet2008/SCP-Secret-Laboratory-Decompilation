namespace LabApi.Loader.Features.Plugins
{
	public abstract class Plugin
	{
		public abstract string Name { get; }

		public abstract string Description { get; }

		public abstract string Author { get; }

		public virtual global::System.Version Version => GetType().Assembly.GetName().Version;

		public abstract global::System.Version RequiredApiVersion { get; }

		public virtual global::LabApi.Loader.Features.Plugins.Enums.LoadPriority Priority => global::LabApi.Loader.Features.Plugins.Enums.LoadPriority.Medium;

		public virtual bool IsTransparent => false;

		public global::LabApi.Loader.Features.Plugins.Configuration.Properties? Properties { get; internal set; }

		public string FilePath { get; internal set; } = string.Empty;

		public abstract void Enable();

		public abstract void Disable();

		public virtual void LoadConfigs()
		{
		}

		public override string ToString()
		{
			return $"'{Name}', Version: {Version}, Author: '{Author}'";
		}
	}
	public abstract class Plugin<TConfig> : global::LabApi.Loader.Features.Plugins.Plugin where TConfig : class, new()
	{
		public TConfig Config { get; set; } = new TConfig();

		public virtual string ConfigFileName { get; set; } = "config.yml";

		public override void LoadConfigs()
		{
			if (!this.TryLoadConfig<TConfig>(ConfigFileName, out TConfig config))
			{
				global::LabApi.Features.Console.Logger.Warn("Failed to load the configuration file, using default values.");
				config = new TConfig();
			}
			Config = config;
		}

		public void SaveConfig()
		{
			if (Config == null)
			{
				global::LabApi.Features.Console.Logger.Warn("Failed to save the configuration file for " + Name + ", the configuration is null.");
			}
			else
			{
				this.SaveConfig(Config, ConfigFileName);
			}
		}
	}
}
