namespace LabApi.Events.Arguments.Scp939Events
{
	public class Scp939FocusedEventArgs : global::System.EventArgs, global::LabApi.Events.Arguments.Interfaces.IPlayerEvent
	{
		public global::LabApi.Features.Wrappers.Player Player { get; }

		public bool FocusState { get; }

		public Scp939FocusedEventArgs(ReferenceHub hub, bool focusState)
		{
			Player = global::LabApi.Features.Wrappers.Player.Get(hub);
			FocusState = focusState;
		}
	}
}
