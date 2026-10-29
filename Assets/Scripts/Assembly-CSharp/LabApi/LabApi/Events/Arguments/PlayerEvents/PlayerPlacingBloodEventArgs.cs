namespace LabApi.Events.Arguments.PlayerEvents
{
	public class PlayerPlacingBloodEventArgs : global::System.EventArgs, global::LabApi.Events.Arguments.Interfaces.IPlayerEvent, global::LabApi.Events.Arguments.Interfaces.ICancellableEvent
	{
		public global::LabApi.Features.Wrappers.Player Player { get; }

		public global::LabApi.Features.Wrappers.Player Attacker { get; }

		public global::UnityEngine.Vector3 HitPosition { get; set; }

		public global::UnityEngine.Vector3 RaycastStart { get; set; }

		public bool IsAllowed { get; set; }

		public PlayerPlacingBloodEventArgs(ReferenceHub hub, ReferenceHub attacker, global::UnityEngine.Vector3 hitPosition, global::UnityEngine.Vector3 startRaycast)
		{
			IsAllowed = true;
			Player = global::LabApi.Features.Wrappers.Player.Get(hub);
			Attacker = global::LabApi.Features.Wrappers.Player.Get(attacker);
			HitPosition = hitPosition;
			RaycastStart = startRaycast;
		}
	}
}
