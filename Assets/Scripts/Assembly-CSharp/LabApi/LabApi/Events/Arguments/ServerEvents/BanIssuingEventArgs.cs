namespace LabApi.Events.Arguments.ServerEvents
{
	public class BanIssuingEventArgs : global::System.EventArgs, global::LabApi.Events.Arguments.Interfaces.ICancellableEvent
	{
		public bool IsAllowed { get; set; }

		public BanHandler.BanType BanType { get; set; }

		public BanDetails BanDetails { get; set; }

		public BanIssuingEventArgs(BanHandler.BanType banType, BanDetails banDetails)
		{
			IsAllowed = true;
			BanType = banType;
			BanDetails = banDetails;
		}
	}
}
