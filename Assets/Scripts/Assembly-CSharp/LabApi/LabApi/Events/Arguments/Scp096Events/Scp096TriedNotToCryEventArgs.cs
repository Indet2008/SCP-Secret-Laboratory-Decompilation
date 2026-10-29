namespace LabApi.Events.Arguments.Scp096Events
{
	public class Scp096TriedNotToCryEventArgs : global::System.EventArgs, global::LabApi.Events.Arguments.Interfaces.IPlayerEvent
	{
		public global::LabApi.Features.Wrappers.Player Player { get; }

		public Scp096TriedNotToCryEventArgs(ReferenceHub hub)
		{
			Player = global::LabApi.Features.Wrappers.Player.Get(hub);
		}
	}
}
