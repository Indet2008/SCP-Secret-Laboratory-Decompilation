namespace LabApi.Events.Arguments.PlayerEvents
{
	public class PlayerPlacedBulletHoleEventArgs : global::System.EventArgs, global::LabApi.Events.Arguments.Interfaces.IPlayerEvent
	{
		public global::LabApi.Features.Wrappers.Player Player { get; }

		public global::Decals.DecalPoolType DecalType { get; set; }

		public global::UnityEngine.Vector3 HitPosition { get; }

		public global::UnityEngine.Vector3 RaycastStart { get; }

		public PlayerPlacedBulletHoleEventArgs(ReferenceHub hub, global::Decals.DecalPoolType type, global::UnityEngine.Vector3 hitPosition, global::UnityEngine.Vector3 startRaycast)
		{
			Player = global::LabApi.Features.Wrappers.Player.Get(hub);
			DecalType = type;
			HitPosition = hitPosition;
			RaycastStart = startRaycast;
		}
	}
}
