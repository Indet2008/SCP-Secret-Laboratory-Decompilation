namespace LabApi.Events.Arguments.PlayerEvents
{
	public class PlayerSendingHitmarkerEventArgs : global::System.EventArgs, global::LabApi.Events.Arguments.Interfaces.IPlayerEvent, global::LabApi.Events.Arguments.Interfaces.ICancellableEvent
	{
		public global::LabApi.Features.Wrappers.Player Player { get; set; }

		public float Size { get; set; }

		public bool PlayAudio { get; set; }

		public HitmarkerType Hitmarker { get; set; }

		public bool IsAllowed { get; set; }

		public PlayerSendingHitmarkerEventArgs(ReferenceHub hub, float size, bool playAudio, HitmarkerType hitmarkerType)
		{
			Player = global::LabApi.Features.Wrappers.Player.Get(hub);
			Size = size;
			PlayAudio = playAudio;
			Hitmarker = hitmarkerType;
			IsAllowed = true;
		}
	}
}
