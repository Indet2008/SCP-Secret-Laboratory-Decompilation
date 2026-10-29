namespace LabApi.Events.Arguments.Scp106Events
{
	public class Scp106UsedHunterAtlasEventArgs : global::System.EventArgs, global::LabApi.Events.Arguments.Interfaces.IPlayerEvent
	{
		public global::LabApi.Features.Wrappers.Player Player { get; }

		public global::UnityEngine.Vector3 OriginalPosition { get; }

		public Scp106UsedHunterAtlasEventArgs(ReferenceHub hub, global::UnityEngine.Vector3 originalPosition)
		{
			Player = global::LabApi.Features.Wrappers.Player.Get(hub);
			OriginalPosition = originalPosition;
		}
	}
}
