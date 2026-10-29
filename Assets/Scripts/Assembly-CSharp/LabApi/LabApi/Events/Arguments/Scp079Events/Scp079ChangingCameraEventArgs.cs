namespace LabApi.Events.Arguments.Scp079Events
{
	public class Scp079ChangingCameraEventArgs : global::System.EventArgs, global::LabApi.Events.Arguments.Interfaces.IPlayerEvent, global::LabApi.Events.Arguments.Interfaces.ICameraEvent, global::LabApi.Events.Arguments.Interfaces.ICancellableEvent
	{
		public global::LabApi.Features.Wrappers.Player Player { get; }

		public global::LabApi.Features.Wrappers.Camera Camera { get; set; }

		public bool IsAllowed { get; set; }

		public Scp079ChangingCameraEventArgs(ReferenceHub hub, global::PlayerRoles.PlayableScps.Scp079.Cameras.Scp079Camera camera)
		{
			Player = global::LabApi.Features.Wrappers.Player.Get(hub);
			Camera = global::LabApi.Features.Wrappers.Camera.Get(camera);
			IsAllowed = true;
		}
	}
}
