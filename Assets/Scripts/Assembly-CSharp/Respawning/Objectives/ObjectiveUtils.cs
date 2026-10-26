using PlayerRoles;
using UnityEngine;

namespace Respawning.Objectives
{
	public static class ObjectiveUtils
	{
		private const string NullName = "???";

		public static string GetColoredNickname(this ReferenceHub hub)
		{
			string nickname = hub.GetNickname();
			return "<color=" + hub.roleManager.CurrentRole.RoleColor.ToHex() + ">" + nickname + "</color>";
		}

		public static Color GetRoleColor(this RoleTypeId role)
		{
			if (!role.TryGetRoleTemplate<PlayerRoleBase>(out var result))
			{
				return Color.white;
			}
			return result.RoleColor;
		}

		public static string GetNickname(this ReferenceHub hub)
		{
			if (!(hub != null))
			{
				return "???";
			}
			return hub.nicknameSync.MyNick;
		}

		public static string GetFactionColor(this Faction faction)
		{
			return faction switch
			{
				Faction.FoundationEnemy => "#008F1C", 
				Faction.FoundationStaff => "#0096FF", 
				_ => "white", 
			};
		}
	}
}
