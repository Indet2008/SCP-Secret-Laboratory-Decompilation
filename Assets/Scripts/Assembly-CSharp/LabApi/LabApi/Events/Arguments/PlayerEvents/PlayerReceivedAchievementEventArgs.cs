namespace LabApi.Events.Arguments.PlayerEvents
{
	public class PlayerReceivedAchievementEventArgs : global::System.EventArgs, global::LabApi.Events.Arguments.Interfaces.IPlayerEvent
	{
		public global::LabApi.Features.Wrappers.Player? Player { get; }

		public global::Achievements.AchievementName Achievement { get; }

		public PlayerReceivedAchievementEventArgs(global::Mirror.NetworkIdentity identity, global::Achievements.AchievementName name)
		{
			Player = global::LabApi.Features.Wrappers.Player.Get(identity);
			Achievement = name;
		}
	}
}
