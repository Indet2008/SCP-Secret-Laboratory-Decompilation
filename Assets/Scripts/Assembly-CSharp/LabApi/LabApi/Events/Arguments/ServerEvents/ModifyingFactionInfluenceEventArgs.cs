namespace LabApi.Events.Arguments.ServerEvents
{
	public class ModifyingFactionInfluenceEventArgs : global::System.EventArgs, global::LabApi.Events.Arguments.Interfaces.ICancellableEvent
	{
		public global::PlayerRoles.Faction Faction { get; set; }

		public float Influence { get; set; }

		public bool IsAllowed { get; set; }

		public ModifyingFactionInfluenceEventArgs(global::PlayerRoles.Faction faction, float influence)
		{
			Faction = faction;
			Influence = influence;
			IsAllowed = true;
		}
	}
}
