namespace LabApi.Events.Arguments.Scp049Events
{
	public class Scp049UsedDoctorsCallEventArgs : global::System.EventArgs, global::LabApi.Events.Arguments.Interfaces.IPlayerEvent
	{
		public global::LabApi.Features.Wrappers.Player Player { get; }

		public Scp049UsedDoctorsCallEventArgs(ReferenceHub hub)
		{
			Player = global::LabApi.Features.Wrappers.Player.Get(hub);
		}
	}
}
