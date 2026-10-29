namespace LabApi.Events.Arguments.PlayerEvents
{
	public class PlayerPlacedBloodEventArgs : global::System.EventArgs, global::LabApi.Events.Arguments.Interfaces.IPlayerEvent
	{
		public global::LabApi.Features.Wrappers.Player Player { get; }

		public global::LabApi.Features.Wrappers.Player Attacker { get; }

		public global::UnityEngine.Vector3 HitPosition { get; }

		public global::UnityEngine.Vector3 RaycastStart { get; set; }

		public PlayerPlacedBloodEventArgs(ReferenceHub hub, ReferenceHub attacker, global::UnityEngine.Vector3 hitPosition, global::UnityEngine.Vector3 startRaycast)
		{
			Player = global::LabApi.Features.Wrappers.Player.Get(hub);
			Attacker = global::LabApi.Features.Wrappers.Player.Get(attacker);
			HitPosition = hitPosition;
			RaycastStart = startRaycast;
		}
	}
}
