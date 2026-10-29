namespace LabApi.Events.Arguments.ServerEvents
{
	public class ModifiedFactionInfluenceEventArgs : global::System.EventArgs
	{
		public global::PlayerRoles.Faction Faction { get; }

		public float Influence { get; }

		public ModifiedFactionInfluenceEventArgs(global::PlayerRoles.Faction faction, float influence)
		{
			Faction = faction;
			Influence = influence;
		}
	}
}
