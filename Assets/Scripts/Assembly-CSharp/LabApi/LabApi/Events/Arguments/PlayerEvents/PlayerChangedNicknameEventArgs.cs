namespace LabApi.Events.Arguments.PlayerEvents
{
	public class PlayerChangedNicknameEventArgs : global::System.EventArgs, global::LabApi.Events.Arguments.Interfaces.IPlayerEvent
	{
		public global::LabApi.Features.Wrappers.Player Player { get; }

		public string? OldNickname { get; }

		public string? NewNickname { get; }

		public PlayerChangedNicknameEventArgs(ReferenceHub hub, string? oldNickname, string? newNickname)
		{
			Player = global::LabApi.Features.Wrappers.Player.Get(hub);
			OldNickname = oldNickname;
			NewNickname = newNickname;
		}
	}
}
