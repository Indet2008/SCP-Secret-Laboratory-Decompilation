namespace LabApi.Features.Wrappers
{
	public static class Whitelist
	{
		public static string FilePath => global::LabApi.Loader.Features.Paths.PathManager.WhitelistConfigPath;

		public static global::System.Collections.Generic.IEnumerable<string> WhitelistedPlayers => WhiteList.Users;

		public static int Count => WhiteList.Users.Count;

		public static bool WhitelistEnabled
		{
			get
			{
				return WhiteList.WhitelistEnabled;
			}
			set
			{
				WhiteList.WhitelistEnabled = value;
			}
		}

		public static bool IsOnWhitelist(string userId)
		{
			return WhiteList.IsOnWhitelist(userId);
		}

		public static bool IsWhitelisted(string userId)
		{
			return WhiteList.IsWhitelisted(userId);
		}

		public static void Reload()
		{
			WhiteList.Reload();
		}

		public static void Add(string userId)
		{
			if (!IsOnWhitelist(userId))
			{
				global::System.Collections.Generic.List<string> list = FileManager.ReadAllLinesList(FilePath);
				list.Add(userId);
				FileManager.WriteToFile(list, FilePath, removeempty: true);
				WhiteList.Users.Add(userId);
			}
		}

		public static void Add(global::LabApi.Features.Wrappers.Player player)
		{
			Add(player.UserId);
		}

		public static bool Remove(string userId)
		{
			if (!IsOnWhitelist(userId))
			{
				return false;
			}
			global::System.Collections.Generic.List<string> list = FileManager.ReadAllLinesList(FilePath);
			int num = list.RemoveAll((string n) => string.IsNullOrEmpty(n) || n == userId);
			WhiteList.Users.Remove(userId);
			FileManager.WriteToFile(list, FilePath, removeempty: true);
			global::NorthwoodLib.Pools.ListPool<string>.Shared.Return(list);
			return num > 0;
		}

		public static bool Remove(global::LabApi.Features.Wrappers.Player player)
		{
			return Remove(player.UserId);
		}
	}
}
