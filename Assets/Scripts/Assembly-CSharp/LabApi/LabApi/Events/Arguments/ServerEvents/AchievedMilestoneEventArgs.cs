namespace LabApi.Events.Arguments.ServerEvents
{
	public class AchievedMilestoneEventArgs : global::System.EventArgs
	{
		public global::PlayerRoles.Faction Faction { get; }

		public int Threshold { get; }

		public int MilestoneIndex { get; }

		public AchievedMilestoneEventArgs(global::PlayerRoles.Faction faction, int threshold, int milestoneIndex)
		{
			Faction = faction;
			Threshold = threshold;
			MilestoneIndex = milestoneIndex;
		}
	}
}
