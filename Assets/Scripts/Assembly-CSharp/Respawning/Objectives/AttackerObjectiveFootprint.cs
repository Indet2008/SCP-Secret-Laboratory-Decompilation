using System.Text;
using Mirror;
using PlayerRoles;

namespace Respawning.Objectives
{
	public abstract class AttackerObjectiveFootprint : ObjectiveFootprintBase
	{
		public ObjectiveHubFootprint VictimFootprint { get; set; }

		public override void ServerWriteRpc(NetworkWriter writer)
		{
			base.ServerWriteRpc(writer);
			VictimFootprint.Write(writer);
		}

		public override void ClientReadRpc(NetworkReader reader)
		{
			base.ClientReadRpc(reader);
			VictimFootprint = new ObjectiveHubFootprint(reader);
		}

		public override StringBuilder ClientCompletionText(StringBuilder builder)
		{
			base.ClientCompletionText(builder);
			RoleTypeId roleType = VictimFootprint.RoleType;
			string newValue = ((roleType.GetTeam() == Team.SCPs) ? roleType.GetAbbreviatedRoleName() : VictimFootprint.Nickname);
			builder.Replace("%victimColor%", roleType.GetRoleColor().ToHex());
			builder.Replace("%victimName%", newValue);
			return builder;
		}
	}
}
