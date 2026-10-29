namespace LabApi.Features.Wrappers
{
	public static class ReservedSlots
	{
		public static string FilePath => global::LabApi.Loader.Features.Paths.PathManager.ReservedSlotsConfigPath;

		public static global::System.Collections.Generic.IEnumerable<string> WhitelistedPlayers => ReservedSlot.Users;

		public static int Count => ReservedSlot.Users.Count;

		public static bool HasReservedSlot(string userId)
		{
			return ReservedSlot.HasReservedSlot(userId);
		}

		public static void Reload()
		{
			ReservedSlot.Reload();
		}

		public static void Add(string userId)
		{
			if (!HasReservedSlot(userId))
			{
				global::System.Collections.Generic.List<string> list = FileManager.ReadAllLinesList(FilePath);
				list.Add(userId);
				FileManager.WriteToFile(list, FilePath, removeempty: true);
				ReservedSlot.Users.Add(userId);
			}
		}

		public static void Add(global::LabApi.Features.Wrappers.Player player)
		{
			Add(player.UserId);
		}

		public static bool Remove(string userId)
		{
			if (!HasReservedSlot(userId))
			{
				return false;
			}
			global::System.Collections.Generic.List<string> list = FileManager.ReadAllLinesList(FilePath);
			int num = list.RemoveAll((string n) => string.IsNullOrEmpty(n) || n == userId);
			ReservedSlot.Users.Remove(userId);
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
