namespace LabApi.Events.Arguments.PlayerEvents
{
	public class PlayerRequestingRaPlayerListEventArgs : global::System.EventArgs, global::LabApi.Events.Arguments.Interfaces.IPlayerEvent, global::LabApi.Events.Arguments.Interfaces.ICancellableEvent
	{
		public global::LabApi.Features.Wrappers.Player Player { get; }

		public global::System.Text.StringBuilder ListBuilder { get; }

		public bool IsDescending { get; set; }

		public global::RemoteAdmin.Communication.RaPlayerList.PlayerSorting Sorting { get; set; }

		public bool ViewHiddenLocalBadges { get; set; }

		public bool ViewHiddenGlobalBadges { get; set; }

		public bool IsAllowed { get; set; }

		public PlayerRequestingRaPlayerListEventArgs(CommandSender commandSender, global::System.Text.StringBuilder builder, bool isDescending, global::RemoteAdmin.Communication.RaPlayerList.PlayerSorting sorting, bool viewHiddenLocalBadges, bool viewHiddenGlobalBadges)
		{
			Player = global::LabApi.Features.Wrappers.Player.Get(commandSender);
			ListBuilder = builder;
			IsDescending = isDescending;
			Sorting = sorting;
			ViewHiddenLocalBadges = viewHiddenLocalBadges;
			ViewHiddenGlobalBadges = viewHiddenGlobalBadges;
			IsAllowed = true;
		}
	}
}
