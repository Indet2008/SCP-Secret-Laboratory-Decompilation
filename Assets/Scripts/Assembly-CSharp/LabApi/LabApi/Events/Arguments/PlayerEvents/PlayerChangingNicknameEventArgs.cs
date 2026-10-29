namespace LabApi.Events.Arguments.PlayerEvents
{
	public class PlayerChangingNicknameEventArgs : global::System.EventArgs, global::LabApi.Events.Arguments.Interfaces.IPlayerEvent, global::LabApi.Events.Arguments.Interfaces.ICancellableEvent
	{
		public global::LabApi.Features.Wrappers.Player Player { get; }

		public string? OldNickname { get; }

		public string? NewNickname { get; set; }

		public bool IsAllowed { get; set; }

		public PlayerChangingNicknameEventArgs(ReferenceHub hub, string? oldNickname, string? newNickname)
		{
			IsAllowed = true;
			Player = global::LabApi.Features.Wrappers.Player.Get(hub);
			OldNickname = oldNickname;
			NewNickname = newNickname;
		}
	}
}
