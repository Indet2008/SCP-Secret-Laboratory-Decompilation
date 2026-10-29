namespace LabApi.Events.Arguments.Scp173Events
{
	public class Scp173PlayedSoundEventArgs : global::System.EventArgs, global::LabApi.Events.Arguments.Interfaces.IPlayerEvent
	{
		public global::PlayerRoles.PlayableScps.Scp173.Scp173AudioPlayer.Scp173SoundId SoundId { get; }

		public global::LabApi.Features.Wrappers.Player Player { get; }

		public Scp173PlayedSoundEventArgs(ReferenceHub hub, global::PlayerRoles.PlayableScps.Scp173.Scp173AudioPlayer.Scp173SoundId soundId)
		{
			Player = global::LabApi.Features.Wrappers.Player.Get(hub);
			SoundId = soundId;
		}
	}
}
