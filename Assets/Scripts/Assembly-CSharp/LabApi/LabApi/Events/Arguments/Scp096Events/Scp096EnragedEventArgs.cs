namespace LabApi.Events.Arguments.Scp096Events
{
	public class Scp096EnragedEventArgs : global::System.EventArgs, global::LabApi.Events.Arguments.Interfaces.IPlayerEvent
	{
		public global::LabApi.Features.Wrappers.Player Player { get; }

		public float InitialDuration { get; }

		public Scp096EnragedEventArgs(ReferenceHub hub, float initialDuration)
		{
			Player = global::LabApi.Features.Wrappers.Player.Get(hub);
			InitialDuration = initialDuration;
		}
	}
}
