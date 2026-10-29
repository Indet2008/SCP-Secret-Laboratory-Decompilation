namespace LabApi.Loader
{
	public static class PluginLoader
	{
		private const string LoggerPrefix = "[LOADER]";

		private const string DllSearchPattern = "*.dll";

		private const string PdbFileExtension = ".pdb";

		private const string LabApiConfigName = "LabApi-{0}.yml";

		public static global::LabApi.Loader.Features.Configuration.LabApiConfig Config { get; private set; } = null;

		public static bool Initialized { get; private set; }

		public static global::System.Collections.Generic.HashSet<global::System.Reflection.Assembly> Dependencies { get; } = new global::System.Collections.Generic.HashSet<global::System.Reflection.Assembly>();

		public static global::System.Collections.Generic.Dictionary<global::LabApi.Loader.Features.Plugins.Plugin, global::System.Reflection.Assembly> Plugins { get; } = new global::System.Collections.Generic.Dictionary<global::LabApi.Loader.Features.Plugins.Plugin, global::System.Reflection.Assembly>();

		public static global::System.Collections.Generic.HashSet<global::LabApi.Loader.Features.Plugins.Plugin> EnabledPlugins { get; } = new global::System.Collections.Generic.HashSet<global::LabApi.Loader.Features.Plugins.Plugin>();

		public static void Initialize()
		{
			if (!Initialized)
			{
				Initialized = true;
				LoadLabApiConfig();
				InitializeWrappers();
				global::LabApi.Loader.CommandLoader.RegisterCommands();
				LoadAllDependencies();
				LoadAllPlugins();
				ResolveTransparentlyModdedFlag();
				AddPluginsToBuildInfo();
				global::LabApi.Features.Permissions.PermissionsManager.RegisterProvider<global::LabApi.Features.Permissions.Providers.DefaultPermissionsProvider>();
				global::LabApi.Events.Handlers.ServerEvents.OnPluginsEnabled();
			}
		}

		public static void LoadAllDependencies()
		{
			global::LabApi.Features.Console.Logger.Info("[LOADER] Loading all dependencies");
			foreach (string dependencyPath in Config.DependencyPaths)
			{
				string path = ResolvePath(dependencyPath);
				string path2 = global::System.IO.Path.Combine(global::LabApi.Loader.Features.Paths.PathManager.Dependencies.FullName, path);
				global::System.IO.Directory.CreateDirectory(path2);
				LoadDependencies(new global::System.IO.DirectoryInfo(path2).GetFiles("*.dll", global::System.IO.SearchOption.AllDirectories));
			}
		}

		public static void LoadDependencies(global::System.Collections.Generic.IEnumerable<global::System.IO.FileInfo> files)
		{
			foreach (global::System.IO.FileInfo file in files)
			{
				try
				{
					global::System.Reflection.Assembly assembly = global::System.Reflection.Assembly.Load(global::System.IO.File.ReadAllBytes(file.FullName));
					Dependencies.Add(assembly);
					global::LabApi.Features.Console.Logger.Info("[LOADER] Successfully loaded " + assembly.FullName);
				}
				catch (global::System.Exception message)
				{
					global::LabApi.Features.Console.Logger.Error("[LOADER] Couldn't load the dependency inside '" + file.FullName + "'");
					global::LabApi.Features.Console.Logger.Error(message);
				}
			}
		}

		public static void LoadAllPlugins()
		{
			global::LabApi.Features.Console.Logger.Info("[LOADER] Loading all plugins");
			foreach (string pluginPath in Config.PluginPaths)
			{
				string path = ResolvePath(pluginPath);
				string path2 = global::System.IO.Path.Combine(global::LabApi.Loader.Features.Paths.PathManager.Plugins.FullName, path);
				global::System.IO.Directory.CreateDirectory(path2);
				if (global::System.IO.Directory.Exists(path2))
				{
					LoadPlugins(new global::System.IO.DirectoryInfo(path2).GetFiles("*.dll", global::System.IO.SearchOption.AllDirectories));
				}
			}
			global::LabApi.Features.Console.Logger.Info("[LOADER] Enabling all plugins");
			EnablePlugins(global::System.Linq.Enumerable.OrderBy(Plugins.Keys, (global::LabApi.Loader.Features.Plugins.Plugin plugin) => plugin.Priority));
		}

		public static void LoadPlugins(global::System.Collections.Generic.IEnumerable<global::System.IO.FileInfo> files)
		{
			global::System.Collections.Generic.List<(string, global::System.Reflection.Assembly)> list = new global::System.Collections.Generic.List<(string, global::System.Reflection.Assembly)>();
			foreach (global::System.IO.FileInfo file in files)
			{
				try
				{
					global::System.IO.FileInfo fileInfo = new global::System.IO.FileInfo(global::System.IO.Path.ChangeExtension(file.FullName, ".pdb"));
					global::System.Reflection.Assembly item = (fileInfo.Exists ? global::System.Reflection.Assembly.Load(global::System.IO.File.ReadAllBytes(file.FullName), global::System.IO.File.ReadAllBytes(fileInfo.FullName)) : global::System.Reflection.Assembly.Load(global::System.IO.File.ReadAllBytes(file.FullName)));
					list.Add((file.FullName, item));
				}
				catch (global::System.Exception message)
				{
					global::LabApi.Features.Console.Logger.Error("[LOADER] Couldn't load the plugin inside '" + file.FullName + "'");
					global::LabApi.Features.Console.Logger.Error(message);
				}
			}
			foreach (var (text, assembly) in list)
			{
				try
				{
					global::LabApi.Loader.Features.Misc.AssemblyUtils.ResolveEmbeddedResources(assembly);
				}
				catch (global::System.Exception message2)
				{
					global::LabApi.Features.Console.Logger.Error("[LOADER] Failed to resolve embedded resources for assembly '" + text + "'");
					LogMissingDependencies(assembly);
					global::LabApi.Features.Console.Logger.Error(message2);
				}
			}
			foreach (var (text2, assembly2) in list)
			{
				try
				{
					InstantiatePlugins(assembly2.GetTypes(), assembly2, text2);
				}
				catch (global::System.Exception message3)
				{
					global::LabApi.Features.Console.Logger.Error("[LOADER] Couldn't load the plugin inside '" + text2 + "'");
					LogMissingDependencies(assembly2);
					global::LabApi.Features.Console.Logger.Error(message3);
				}
			}
		}

		public static void EnablePlugins(global::System.Collections.Generic.IEnumerable<global::LabApi.Loader.Features.Plugins.Plugin> plugins)
		{
			foreach (global::LabApi.Loader.Features.Plugins.Plugin plugin in plugins)
			{
				if (plugin.TryLoadProperties())
				{
					global::LabApi.Loader.Features.Plugins.Configuration.Properties? properties = plugin.Properties;
					if ((properties == null || properties.IsEnabled) && ValidateVersion(plugin))
					{
						EnablePlugin(plugin);
					}
				}
			}
		}

		public static void EnablePlugin(global::LabApi.Loader.Features.Plugins.Plugin plugin)
		{
			try
			{
				CustomNetworkManager.Modded = true;
				plugin.LoadConfigs();
				plugin.RegisterCommands();
				plugin.Enable();
				EnabledPlugins.Add(plugin);
				global::LabApi.Features.Console.Logger.Info(string.Format("{0} Successfully enabled {1}", "[LOADER]", plugin));
			}
			catch (global::System.Exception message)
			{
				global::LabApi.Features.Console.Logger.Error(string.Format("{0} Couldn't enable the plugin {1}", "[LOADER]", plugin));
				global::LabApi.Features.Console.Logger.Error(message);
			}
		}

		private static void InitializeWrappers()
		{
			global::LabApi.Features.Wrappers.AdminToy.Initialize();
			global::LabApi.Features.Wrappers.Pickup.Initialize();
			global::LabApi.Features.Wrappers.Item.Initialize();
			global::LabApi.Features.Wrappers.FirearmItem.InitializeFirearmWrappers();
			global::LabApi.Features.Wrappers.Warhead.Initialize();
			global::LabApi.Features.Wrappers.Window.Initialize();
			global::LabApi.Features.Wrappers.Structure.Initialize();
			global::LabApi.Features.Wrappers.Generator.InitializeCaching();
			global::LabApi.Features.Wrappers.Room.Initialize();
			global::LabApi.Features.Wrappers.Player.Initialize();
			global::LabApi.Features.Wrappers.PocketTeleport.Initialize();
			global::LabApi.Features.Wrappers.LightsController.Initialize();
			global::LabApi.Features.Wrappers.Camera.Initialize();
			global::LabApi.Features.Wrappers.RespawnWaves.Initialize();
			global::LabApi.Features.Wrappers.Tesla.Initialize();
			global::LabApi.Features.Wrappers.Hazard.Initialize();
			global::LabApi.Features.Wrappers.Elevator.Initialize();
			global::LabApi.Features.Wrappers.Door.Initialize();
			global::LabApi.Features.Wrappers.SpawnableCullingParent.Initialize();
			global::LabApi.Features.Wrappers.PocketItem.Initialize();
			global::LabApi.Features.Wrappers.Ragdoll.Initialize();
		}

		private static void LoadLabApiConfig()
		{
			string path = global::System.IO.Path.Combine(global::LabApi.Loader.Features.Paths.PathManager.LabApi.FullName, $"LabApi-{(global::LabApi.Features.Wrappers.Server.Port)}.yml");
			Config = new global::LabApi.Loader.Features.Configuration.LabApiConfig();
			try
			{
				if (global::System.IO.File.Exists(path))
				{
					string input = global::System.IO.File.ReadAllText(path);
					Config = global::LabApi.Loader.Features.Yaml.YamlConfigParser.Deserializer.Deserialize<global::LabApi.Loader.Features.Configuration.LabApiConfig>(input) ?? Config;
				}
				string contents = global::LabApi.Loader.Features.Yaml.YamlConfigParser.Serializer.Serialize(Config);
				global::System.IO.File.WriteAllText(path, contents);
			}
			catch (global::System.Exception message)
			{
				global::LabApi.Features.Console.Logger.Error("[LOADER] Failed to load LabAPI configuration, using defaults");
				global::LabApi.Features.Console.Logger.Error(message);
			}
		}

		private static void ResolveTransparentlyModdedFlag()
		{
			if (Plugins.Count == 0 || global::LabApi.Features.Wrappers.Server.IsTransparentlyModded)
			{
				return;
			}
			bool flag = true;
			foreach (global::LabApi.Loader.Features.Plugins.Plugin key in Plugins.Keys)
			{
				if (!key.IsTransparent)
				{
					flag = false;
					break;
				}
			}
			global::LabApi.Features.Wrappers.Server.IsTransparentlyModded = flag;
			if (flag)
			{
				global::LabApi.Features.Console.Logger.Raw("[LOADER] This server has been flagged as transparently modded by one or more installed plugins. If you believe this is a mistake, please review your installed plugins and contact the plugin developers.", global::System.ConsoleColor.Red);
				ServerConsole.Update = true;
			}
		}

		private static void AddPluginsToBuildInfo()
		{
			if (EnabledPlugins.Count == 0)
			{
				return;
			}
			global::System.Text.StringBuilder stringBuilder = global::NorthwoodLib.Pools.StringBuilderPool.Shared.Rent();
			foreach (global::LabApi.Loader.Features.Plugins.Plugin enabledPlugin in EnabledPlugins)
			{
				stringBuilder.AppendFormat("- {0} by {1} [{2}]: {3}\n", enabledPlugin.Name, enabledPlugin.Author, enabledPlugin.Version, enabledPlugin.Description);
			}
			global::CommandSystem.Commands.Shared.BuildInfoCommand.ModDescription = global::NorthwoodLib.Pools.StringBuilderPool.Shared.ToStringReturn(stringBuilder);
		}

		private static string ResolvePath(string path)
		{
			return path.Replace("$port", global::LabApi.Features.Wrappers.Server.Port.ToString());
		}

		private static void LogMissingDependencies(global::System.Reflection.Assembly assembly)
		{
			global::System.Collections.Generic.IEnumerable<string> missingDependencies = global::LabApi.Loader.Features.Misc.AssemblyUtils.GetMissingDependencies(assembly);
			if (global::System.Linq.Enumerable.Any(missingDependencies))
			{
				global::LabApi.Features.Console.Logger.Error("[LOADER] Missing dependencies:\n" + string.Join("\n", global::System.Linq.Enumerable.Select(missingDependencies, (string x) => "-\t " + x)));
			}
		}

		private static bool ValidateVersion(global::LabApi.Loader.Features.Plugins.Plugin plugin)
		{
			global::System.Version requiredApiVersion = plugin.RequiredApiVersion;
			if (requiredApiVersion == null)
			{
				return true;
			}
			global::System.Version currentVersion = global::LabApi.Features.LabApiProperties.CurrentVersion;
			if (requiredApiVersion.Major == currentVersion.Major)
			{
				if (!IsGreaterVersion(requiredApiVersion, currentVersion))
				{
					return true;
				}
				global::LabApi.Features.Console.Logger.Warn(string.Format("{0} Potential issue with plugin {1}\r\nIt was built for a newer minor/patch version of LabAPI, and might not be able to access some features it depends on.\r\nAre you running an older version of the server?\r\nCurrent LabAPI version: {2}\r\nRequired by plugin: {3}", "[LOADER]", plugin, global::LabApi.Features.LabApiProperties.CompiledVersion, requiredApiVersion));
				return true;
			}
			string text = ((requiredApiVersion.Major < currentVersion.Major) ? "an outdated major version" : "a newer major version");
			if (plugin.Properties?.UnsupportedLoading switch
			{
				global::LabApi.Loader.Features.Plugins.Enums.OptionalBoolean.True => true, 
				global::LabApi.Loader.Features.Plugins.Enums.OptionalBoolean.False => false, 
				_ => Config.LoadUnsupportedPlugins, 
			})
			{
				global::LabApi.Features.Console.Logger.Warn(string.Format("{0} Forcefully loading unsupported plugin {1}\r\nIt was built for {2} of LabAPI, and will likely have degraded functionality.\r\nCurrent LabAPI version: {3}\r\nRequired by plugin: {4}", "[LOADER]", plugin, text, global::LabApi.Features.LabApiProperties.CompiledVersion, requiredApiVersion));
				return true;
			}
			global::LabApi.Features.Console.Logger.Error(string.Format("{0} Couldn't enable the plugin {1}\r\nIt was built for {2} of LabAPI, and would likely have degraded functionality.\r\nTo forcefully load it, set the appropriate property in the plugins's properties.yml file.\r\nTo forcefully load all unsupported plugins, set the appropriate property in the LabAPI configuration for the current port (LabApi-{3}.yml).\r\nCurrent LabAPI version: {4}\r\nRequired by plugin: {5}", "[LOADER]", plugin, text, global::LabApi.Features.Wrappers.Server.Port, global::LabApi.Features.LabApiProperties.CompiledVersion, requiredApiVersion));
			return false;
		}

		private static void InstantiatePlugins(global::System.Type[] types, global::System.Reflection.Assembly assembly, string filePath)
		{
			foreach (global::System.Type type in types)
			{
				if (type.IsSubclassOf(typeof(global::LabApi.Loader.Features.Plugins.Plugin)) && !type.IsAbstract && global::System.Activator.CreateInstance(type) is global::LabApi.Loader.Features.Plugins.Plugin plugin)
				{
					plugin.FilePath = filePath;
					Plugins.Add(plugin, assembly);
					global::LabApi.Features.Console.Logger.Info("[LOADER] Successfully loaded " + plugin.Name);
				}
			}
		}

		private static bool IsGreaterVersion(global::System.Version required, global::System.Version current)
		{
			global::System.Version version = new global::System.Version(required.Major, required.Minor, (required.Build != -1) ? required.Build : 0, (required.Revision != -1) ? required.Revision : 0);
			global::System.Version version2 = new global::System.Version(current.Major, current.Minor, (current.Build != -1) ? current.Build : 0, (current.Revision != -1) ? current.Revision : 0);
			return version > version2;
		}
	}
}
