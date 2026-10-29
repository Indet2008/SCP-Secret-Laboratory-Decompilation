namespace LabApi.Events.Arguments.Scp173Events
{
	public class Scp173PlayingSoundEventArgs : global::System.EventArgs, global::LabApi.Events.Arguments.Interfaces.IPlayerEvent, global::LabApi.Events.Arguments.Interfaces.ICancellableEvent
	{
		public global::PlayerRoles.PlayableScps.Scp173.Scp173AudioPlayer.Scp173SoundId SoundId { get; set; }

		public global::LabApi.Features.Wrappers.Player Player { get; }

		public bool IsAllowed { get; set; }

		public Scp173PlayingSoundEventArgs(ReferenceHub hub, global::PlayerRoles.PlayableScps.Scp173.Scp173AudioPlayer.Scp173SoundId soundId)
		{
			IsAllowed = true;
			Player = global::LabApi.Features.Wrappers.Player.Get(hub);
			SoundId = soundId;
		}
	}
}
