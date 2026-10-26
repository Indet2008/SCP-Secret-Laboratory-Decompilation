using Mirror;
using PlayerRoles;

namespace Respawning
{
	public struct InfluenceUpdateMessage : NetworkMessage
	{
		public Faction Faction;

		public float Influence;
	}
}
