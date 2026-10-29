namespace LabApi.Loader
{
	public static class ConfigurationLoader
	{
		private const string LoggerPrefix = "[CONFIG_LOADER]";

		private const string PropertiesFileName = "properties.yml";

		public static bool TrySaveConfig<TConfig>(this global::LabApi.Loader.Features.Plugins.Plugin plugin, TConfig config, string fileName, bool isGlobal = false) where TConfig : class, new()
		{
			try
			{
				string configPath = plugin.GetConfigPath(fileName, isGlobal);
				string contents = global::LabApi.Loader.Features.Yaml.YamlConfigParser.Serializer.Serialize(config);
				global::System.IO.File.WriteAllText(configPath, contents);
				return true;
			}
			catch (global::System.Exception message)
			{
				global::LabApi.Features.Console.Logger.Error(string.Format("{0} Couldn't save the configuration of the plugin {1}", "[CONFIG_LOADER]", plugin));
				global::LabApi.Features.Console.Logger.Error(message);
				return false;
			}
		}

		public static bool TryReadConfig<TConfig>(this global::LabApi.Loader.Features.Plugins.Plugin plugin, string fileName, [global::System.Diagnostics.CodeAnalysis.NotNullWhen(true)] out TConfig? config, bool isGlobal = false) where TConfig : class, new()
		{
			config = null;
			try
			{
				string configPath = plugin.GetConfigPath(fileName, isGlobal);
				if (!global::System.IO.File.Exists(configPath))
				{
					return false;
				}
				string input = global::System.IO.File.ReadAllText(configPath);
				config = global::LabApi.Loader.Features.Yaml.YamlConfigParser.Deserializer.Deserialize<TConfig>(input);
				return true;
			}
			catch (global::System.Exception message)
			{
				global::LabApi.Features.Console.Logger.Error(string.Format("{0} Couldn't read the configuration of the plugin {1}", "[CONFIG_LOADER]", plugin));
				global::LabApi.Features.Console.Logger.Error(message);
				return false;
			}
		}

		public static bool TryLoadConfig<TConfig>(this global::LabApi.Loader.Features.Plugins.Plugin plugin, string fileName, [global::System.Diagnostics.CodeAnalysis.NotNullWhen(true)] out TConfig? config, bool isGlobal = false) where TConfig : class, new()
		{
			if (!global::System.IO.File.Exists(plugin.GetConfigPath(fileName, isGlobal)))
			{
				if (plugin.TryCreateDefaultConfig<TConfig>(out config))
				{
					return plugin.TrySaveConfig(config, fileName, isGlobal);
				}
			}
			else if (plugin.TryReadConfig<TConfig>(fileName, out config, isGlobal))
			{
				return plugin.TrySaveConfig(config, fileName, isGlobal);
			}
			return false;
		}

		public static void SaveConfig<TConfig>(this global::LabApi.Loader.Features.Plugins.Plugin plugin, TConfig config, string fileName, bool isGlobal = false) where TConfig : class, new()
		{
			plugin.TrySaveConfig(config, fileName, isGlobal);
		}

		public static TConfig? ReadConfig<TConfig>(this global::LabApi.Loader.Features.Plugins.Plugin plugin, string fileName, bool isGlobal = false) where TConfig : class, new()
		{
			if (!plugin.TryReadConfig<TConfig>(fileName, out TConfig config, isGlobal))
			{
				return null;
			}
			return config;
		}

		public static TConfig? LoadConfig<TConfig>(this global::LabApi.Loader.Features.Plugins.Plugin plugin, string fileName, bool isGlobal = false) where TConfig : class, new()
		{
			if (!plugin.TryLoadConfig<TConfig>(fileName, out TConfig config, isGlobal))
			{
				return null;
			}
			return config;
		}

		public static bool TryCreateDefaultConfig<TConfig>(this global::LabApi.Loader.Features.Plugins.Plugin plugin, [global::System.Diagnostics.CodeAnalysis.NotNullWhen(true)] out TConfig? config) where TConfig : class, new()
		{
			config = null;
			try
			{
				config = new TConfig();
				return true;
			}
			catch (global::System.Exception message)
			{
				global::LabApi.Features.Console.Logger.Error(string.Format("{0} Couldn't create a default instance of the class {1} of the plugin {2}", "[CONFIG_LOADER]", typeof(TConfig), plugin));
				global::LabApi.Features.Console.Logger.Error(message);
				return false;
			}
		}

		public static global::System.IO.DirectoryInfo GetConfigDirectory(this global::LabApi.Loader.Features.Plugins.Plugin plugin, bool isGlobal = false)
		{
			return global::LabApi.Loader.Features.Paths.PathManager.Configs.CreateSubdirectory(isGlobal ? "global" : global::LabApi.Features.Wrappers.Server.Port.ToString()).CreateSubdirectory(plugin.Name);
		}

		public static string GetConfigPath(this global::LabApi.Loader.Features.Plugins.Plugin plugin, string fileName, bool isGlobal = false)
		{
			global::System.IO.DirectoryInfo configDirectory = plugin.GetConfigDirectory(isGlobal);
			if (!fileName.EndsWith(".yml", global::System.StringComparison.InvariantCultureIgnoreCase) && !fileName.EndsWith(".yaml", global::System.StringComparison.InvariantCultureIgnoreCase))
			{
				fileName += ".yml";
			}
			return global::System.IO.Path.Combine(configDirectory.FullName, fileName);
		}

		public static bool TryLoadProperties(this global::LabApi.Loader.Features.Plugins.Plugin plugin)
		{
			if (!plugin.TryLoadConfig<global::LabApi.Loader.Features.Plugins.Configuration.Properties>("properties.yml", out global::LabApi.Loader.Features.Plugins.Configuration.Properties config))
			{
				return false;
			}
			plugin.Properties = config;
			return true;
		}
	}
}
