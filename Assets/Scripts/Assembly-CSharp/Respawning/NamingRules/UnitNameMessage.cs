using Mirror;
using PlayerRoles;

namespace Respawning.NamingRules
{
	public struct UnitNameMessage : NetworkMessage
	{
		public string UnitName;

		public Team Team;

		public UnitNamingRule NamingRule;

		public NetworkReader Data;
	}
}
