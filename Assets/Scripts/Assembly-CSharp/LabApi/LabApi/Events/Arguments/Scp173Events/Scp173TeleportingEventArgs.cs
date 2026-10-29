namespace LabApi.Events.Arguments.Scp173Events
{
	public class Scp173TeleportingEventArgs : global::System.EventArgs, global::LabApi.Events.Arguments.Interfaces.IPlayerEvent, global::LabApi.Events.Arguments.Interfaces.ICancellableEvent
	{
		public global::LabApi.Features.Wrappers.Player Player { get; }

		public global::UnityEngine.Vector3 Position { get; set; }

		public bool IsAllowed { get; set; }

		public Scp173TeleportingEventArgs(ReferenceHub hub, global::UnityEngine.Vector3 position)
		{
			Player = global::LabApi.Features.Wrappers.Player.Get(hub);
			Position = position;
			IsAllowed = true;
		}
	}
}
