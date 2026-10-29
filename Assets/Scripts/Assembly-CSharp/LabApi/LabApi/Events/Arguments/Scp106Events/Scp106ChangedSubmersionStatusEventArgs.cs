namespace LabApi.Events.Arguments.Scp106Events
{
	public class Scp106ChangedSubmersionStatusEventArgs : global::System.EventArgs, global::LabApi.Events.Arguments.Interfaces.IPlayerEvent
	{
		public bool IsSubmerging { get; }

		public global::LabApi.Features.Wrappers.Player Player { get; }

		public Scp106ChangedSubmersionStatusEventArgs(ReferenceHub hub, bool isSubmerging)
		{
			Player = global::LabApi.Features.Wrappers.Player.Get(hub);
			IsSubmerging = isSubmerging;
		}
	}
}
