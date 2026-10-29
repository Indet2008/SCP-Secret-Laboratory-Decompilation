namespace LabApi.Events.Arguments.ServerEvents
{
	public class AchievingMilestoneEventArgs : global::System.EventArgs, global::LabApi.Events.Arguments.Interfaces.ICancellableEvent
	{
		public global::PlayerRoles.Faction Faction { get; }

		public int Threshold { get; }

		public int MilestoneIndex { get; }

		public bool IsAllowed { get; set; }

		public AchievingMilestoneEventArgs(global::PlayerRoles.Faction faction, int threshold, int milestoneIndex)
		{
			Faction = faction;
			Threshold = threshold;
			MilestoneIndex = milestoneIndex;
			IsAllowed = true;
		}
	}
}
