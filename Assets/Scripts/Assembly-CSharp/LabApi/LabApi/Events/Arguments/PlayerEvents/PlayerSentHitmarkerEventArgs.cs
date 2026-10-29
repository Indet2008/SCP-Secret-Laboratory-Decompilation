namespace LabApi.Events.Arguments.PlayerEvents
{
	public class PlayerSentHitmarkerEventArgs : global::System.EventArgs, global::LabApi.Events.Arguments.Interfaces.IPlayerEvent
	{
		public global::LabApi.Features.Wrappers.Player Player { get; }

		public float Size { get; }

		public bool PlayedAudio { get; }

		public HitmarkerType Hitmarker { get; }

		public PlayerSentHitmarkerEventArgs(ReferenceHub hub, float size, bool playedAudio, HitmarkerType hitmarkerType)
		{
			Player = global::LabApi.Features.Wrappers.Player.Get(hub);
			Size = size;
			PlayedAudio = playedAudio;
			Hitmarker = hitmarkerType;
		}
	}
}
