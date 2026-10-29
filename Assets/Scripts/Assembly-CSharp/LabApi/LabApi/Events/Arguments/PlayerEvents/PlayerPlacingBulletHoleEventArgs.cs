namespace LabApi.Events.Arguments.PlayerEvents
{
	public class PlayerPlacingBulletHoleEventArgs : global::System.EventArgs, global::LabApi.Events.Arguments.Interfaces.IPlayerEvent, global::LabApi.Events.Arguments.Interfaces.ICancellableEvent
	{
		public global::LabApi.Features.Wrappers.Player Player { get; }

		public global::Decals.DecalPoolType DecalType { get; set; }

		public global::UnityEngine.Vector3 HitPosition { get; set; }

		public global::UnityEngine.Vector3 RaycastStart { get; set; }

		public bool IsAllowed { get; set; }

		public PlayerPlacingBulletHoleEventArgs(ReferenceHub hub, global::Decals.DecalPoolType type, global::UnityEngine.Vector3 hitPosition, global::UnityEngine.Vector3 startRaycast)
		{
			IsAllowed = true;
			Player = global::LabApi.Features.Wrappers.Player.Get(hub);
			DecalType = type;
			HitPosition = hitPosition;
			RaycastStart = startRaycast;
		}
	}
}
