using System.IO;

namespace GameCore
{
	public static class ConfigSharing
	{
		public enum ConfigShare
		{
			Bans = 0,
			Mutes = 1,
			Whitelist = 2,
			ReservedSlots = 3,
			Groups = 4,
			GroupsMembers = 5,
			GameplayDatabase = 6
		}

		public static readonly string[] Shares;

		public static readonly string[] Paths;

		static ConfigSharing()
		{
			Shares = new string[7];
			Paths = new string[7];
			Reload();
		}

		internal static void Reload()
		{
			Shares[0] = ConfigFile.SharingConfig.GetString("bans");
			Shares[1] = ConfigFile.SharingConfig.GetString("mutes");
			Shares[2] = ConfigFile.SharingConfig.GetString("whitelist");
			Shares[3] = ConfigFile.SharingConfig.GetString("reserved_slots");
			Shares[4] = ConfigFile.SharingConfig.GetString("groups");
			Shares[5] = ConfigFile.SharingConfig.GetString("groups_members");
			Shares[6] = ConfigFile.SharingConfig.GetString("gameplay_database");
			for (ushort num = 0; num < Shares.Length; num++)
			{
				if (Shares[num] == "disable")
				{
					Paths[num] = ((num == 4 || num == 5) ? null : FileManager.GetAppFolder(addSeparator: true, serverConfig: true));
				}
				else
				{
					Paths[num] = FileManager.GetAppFolder(addSeparator: true, serverConfig: true, Shares[num]);
					string appFolder = FileManager.GetAppFolder(addSeparator: true, serverConfig: true, Shares[num]);
					if (!Directory.Exists(appFolder))
					{
						Directory.CreateDirectory(appFolder);
					}
					switch (num)
					{
					case 5:
						if (num == 5 && !File.Exists(Paths[num] + "shared_groups_members.txt"))
						{
							File.Copy("ConfigTemplates/shared_groups_members.template.txt", Paths[num] + "shared_groups_members.txt");
						}
						break;
					case 4:
						if (!File.Exists(Paths[num] + "shared_groups.txt"))
						{
							File.Copy("ConfigTemplates/shared_groups.template.txt", Paths[num] + "shared_groups.txt");
						}
						break;
					}
				}
			}
			ServerConsole.AddLog("Config sharing loaded.");
		}
	}
}
