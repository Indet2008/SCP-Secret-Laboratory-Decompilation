namespace LabApi.Events.Arguments.ServerEvents
{
	public class BanRevokingEventArgs : global::System.EventArgs, global::LabApi.Events.Arguments.Interfaces.ICancellableEvent
	{
		public bool IsAllowed { get; set; }

		public BanHandler.BanType BanType { get; }

		public BanDetails BanDetails { get; }

		public BanRevokingEventArgs(BanHandler.BanType banType, BanDetails banDetails)
		{
			IsAllowed = true;
			BanType = banType;
			BanDetails = banDetails;
		}
	}
}
