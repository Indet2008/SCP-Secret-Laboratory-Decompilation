namespace LabApi.Events.Arguments.Scp106Events
{
	public class Scp106UsingHunterAtlasEventArgs : global::System.EventArgs, global::LabApi.Events.Arguments.Interfaces.IPlayerEvent, global::LabApi.Events.Arguments.Interfaces.ICancellableEvent
	{
		public global::LabApi.Features.Wrappers.Player Player { get; }

		public global::UnityEngine.Vector3 DestinationPosition { get; set; }

		public bool IsAllowed { get; set; }

		public Scp106UsingHunterAtlasEventArgs(ReferenceHub hub, global::UnityEngine.Vector3 destinationPosition)
		{
			Player = global::LabApi.Features.Wrappers.Player.Get(hub);
			DestinationPosition = destinationPosition;
			IsAllowed = true;
		}
	}
}
