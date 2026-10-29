namespace LabApi.Loader.Features.Paths
{
	public static class PathManager
	{
		private const string SecretLabFolderName = "SCP Secret Laboratory";

		private const string LabApiFolderName = "LabAPI";

		private const string PluginsFolderName = "plugins";

		private const string DependenciesFolderName = "dependencies";

		private const string ConfigsFolderName = "configs";

		public static global::System.IO.DirectoryInfo AppData { get; }

		public static global::System.IO.DirectoryInfo SecretLab { get; }

		public static global::System.IO.DirectoryInfo LabApi { get; }

		public static global::System.IO.DirectoryInfo Plugins { get; }

		public static global::System.IO.DirectoryInfo Dependencies { get; }

		public static global::System.IO.DirectoryInfo Configs { get; }

		public static string RAConfigPath => ServerStatic.RolesConfigPath;

		public static string GameplayConfigPath => global::GameCore.ConfigFile.GetConfigPath("config_gameplay");

		public static string SharingConfigPath => global::GameCore.ConfigFile.GetConfigPath("config_sharing");

		public static string MutesConfigPath => global::GameCore.ConfigSharing.Paths[1];

		public static string UserIdBansPath => BanHandler.GetPath(BanHandler.BanType.UserId);

		public static string IpBansPath => BanHandler.GetPath(BanHandler.BanType.IP);

		public static string WhitelistConfigPath => global::GameCore.ConfigSharing.Paths[2] + "UserIDWhitelist.txt";

		public static string ReservedSlotsConfigPath => global::GameCore.ConfigSharing.Paths[3] + "UserIDReservedSlots.txt";

		static PathManager()
		{
			AppData = GetAppDataDirectory();
			SecretLab = AppData.CreateSubdirectory("SCP Secret Laboratory");
			LabApi = SecretLab.CreateSubdirectory("LabAPI");
			Plugins = LabApi.CreateSubdirectory("plugins");
			Dependencies = LabApi.CreateSubdirectory("dependencies");
			Configs = LabApi.CreateSubdirectory("configs");
		}

		private static global::System.IO.DirectoryInfo GetAppDataDirectory()
		{
			return global::System.IO.Directory.CreateDirectory(GetHosterPolicy() ? "AppData" : global::System.Environment.GetFolderPath(global::System.Environment.SpecialFolder.ApplicationData));
		}

		private static bool GetHosterPolicy()
		{
			if (global::System.IO.File.Exists("hoster_policy.txt"))
			{
				return global::System.Linq.Enumerable.Any(global::System.IO.File.ReadAllLines("hoster_policy.txt"), (string l) => l.Contains("gamedir_for_configs: true", global::System.StringComparison.OrdinalIgnoreCase));
			}
			return false;
		}
	}
}
