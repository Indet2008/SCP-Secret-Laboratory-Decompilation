namespace GameCore
{
	public static class PlayerPermissionsExtensions
	{
		private const string RAPermissionColor = "#F54842";

		private const string ViewAccessPermissionColor = "#BE83F2";

		private const string MiscPermissionsColor = "#7FDB88";

		public static PlayerPermissionType GetPermissionType(this PlayerPermissions permissions)
		{
			switch (permissions)
			{
			case PlayerPermissions.AdminChat:
			case PlayerPermissions.ViewHiddenGlobalBadges:
				return PlayerPermissionType.ViewAccess;
			case PlayerPermissions.KickingAndShortTermBanning:
			case PlayerPermissions.BanningUpToDay:
			case PlayerPermissions.LongTermBanning:
			case PlayerPermissions.ForceclassSelf:
			case PlayerPermissions.ForceclassToSpectator:
			case PlayerPermissions.ForceclassWithoutRestrictions:
			case PlayerPermissions.GivingItems:
			case PlayerPermissions.WarheadEvents:
			case PlayerPermissions.RespawnEvents:
			case PlayerPermissions.RoundEvents:
			case PlayerPermissions.SetGroup:
			case PlayerPermissions.GameplayData:
			case PlayerPermissions.FacilityManagement:
			case PlayerPermissions.PlayersManagement:
			case PlayerPermissions.PermissionsManagement:
			case PlayerPermissions.ServerConsoleCommands:
			case PlayerPermissions.ServerConfigs:
			case PlayerPermissions.Broadcasting:
			case PlayerPermissions.PlayerSensitiveDataAccess:
			case PlayerPermissions.Announcer:
			case PlayerPermissions.Effects:
			case PlayerPermissions.ServerLogLiveFeed:
			case PlayerPermissions.ExecuteAs:
				return PlayerPermissionType.RaAccess;
			case PlayerPermissions.Overwatch:
			case PlayerPermissions.ViewHiddenBadges:
			case PlayerPermissions.Noclip:
			case PlayerPermissions.AFKImmunity:
			case PlayerPermissions.FriendlyFireDetectorImmunity:
			case PlayerPermissions.FriendlyFireDetectorTempDisable:
				return PlayerPermissionType.Misc;
			default:
				return PlayerPermissionType.Misc;
			}
		}

		public static string GetPermissionTypeColor(this PlayerPermissionType type)
		{
			return type switch
			{
				PlayerPermissionType.RaAccess => "#F54842", 
				PlayerPermissionType.ViewAccess => "#BE83F2", 
				PlayerPermissionType.Misc => "#7FDB88", 
				_ => "#7FDB88", 
			};
		}
	}
}
