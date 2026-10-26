using Footprinting;
using Mirror;
using PlayerRoles;

namespace Respawning.Objectives
{
	public struct ObjectiveHubFootprint
	{
		private const string DefaultNickname = "???";

		private const RoleTypeId DefaultRole = RoleTypeId.None;

		public string Nickname { get; private set; }

		public RoleTypeId RoleType { get; private set; }

		public ObjectiveHubFootprint(ReferenceHub hub, RoleTypeId role = RoleTypeId.None)
		{
			Nickname = ((hub != null) ? hub.nicknameSync.DisplayName : "???");
			RoleType = ((role == RoleTypeId.None) ? hub.GetRoleId() : role);
		}

		public ObjectiveHubFootprint(Footprint footprint)
		{
			Nickname = footprint.Nickname;
			RoleType = footprint.Role;
		}

		public ObjectiveHubFootprint(NetworkReader reader)
		{
			Nickname = reader.ReadString();
			RoleType = reader.ReadRoleType();
		}

		public void Write(NetworkWriter writer)
		{
			writer.WriteString(Nickname);
			writer.WriteRoleType(RoleType);
		}
	}
}
