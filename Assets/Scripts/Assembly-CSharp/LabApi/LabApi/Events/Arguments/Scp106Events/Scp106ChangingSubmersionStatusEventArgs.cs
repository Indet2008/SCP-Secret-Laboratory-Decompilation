namespace LabApi.Events.Arguments.Scp106Events
{
	public class Scp106ChangingSubmersionStatusEventArgs : global::System.EventArgs, global::LabApi.Events.Arguments.Interfaces.IPlayerEvent, global::LabApi.Events.Arguments.Interfaces.ICancellableEvent
	{
		public bool IsSubmerging { get; }

		public global::LabApi.Features.Wrappers.Player Player { get; }

		public bool IsAllowed { get; set; }

		public Scp106ChangingSubmersionStatusEventArgs(ReferenceHub hub, bool isSubmerging)
		{
			Player = global::LabApi.Features.Wrappers.Player.Get(hub);
			IsSubmerging = isSubmerging;
			IsAllowed = true;
		}
	}
}
