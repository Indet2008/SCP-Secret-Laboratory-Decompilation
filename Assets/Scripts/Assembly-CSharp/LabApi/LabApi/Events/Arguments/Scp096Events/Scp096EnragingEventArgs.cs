namespace LabApi.Events.Arguments.Scp096Events
{
	public class Scp096EnragingEventArgs : global::System.EventArgs, global::LabApi.Events.Arguments.Interfaces.IPlayerEvent, global::LabApi.Events.Arguments.Interfaces.ICancellableEvent
	{
		public global::LabApi.Features.Wrappers.Player Player { get; }

		public float InitialDuration { get; set; }

		public bool IsAllowed { get; set; }

		public Scp096EnragingEventArgs(ReferenceHub hub, float initialDuration)
		{
			Player = global::LabApi.Features.Wrappers.Player.Get(hub);
			InitialDuration = initialDuration;
			IsAllowed = true;
		}
	}
}
