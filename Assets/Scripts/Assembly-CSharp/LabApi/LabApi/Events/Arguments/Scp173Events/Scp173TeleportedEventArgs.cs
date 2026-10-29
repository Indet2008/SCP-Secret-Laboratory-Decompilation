namespace LabApi.Events.Arguments.Scp173Events
{
	public class Scp173TeleportedEventArgs : global::System.EventArgs, global::LabApi.Events.Arguments.Interfaces.IPlayerEvent
	{
		public global::LabApi.Features.Wrappers.Player Player { get; }

		public global::UnityEngine.Vector3 Position { get; }

		public bool IsAllowed { get; set; }

		public Scp173TeleportedEventArgs(ReferenceHub hub, global::UnityEngine.Vector3 position)
		{
			IsAllowed = true;
			Player = global::LabApi.Features.Wrappers.Player.Get(hub);
			Position = position;
		}
	}
}
