using PlayerRoles;

namespace Respawning.Objectives
{
	public abstract class ScpObjectiveBase : FactionObjectiveBase
	{
		protected override bool IsValidFaction(Faction faction)
		{
			return faction == Faction.SCP;
		}
	}
}
