namespace LabApi.Events.Arguments.ServerEvents
{
	public class BanUpdatingEventArgs : global::System.EventArgs, global::LabApi.Events.Arguments.Interfaces.ICancellableEvent
	{
		public bool IsAllowed { get; set; }

		public BanHandler.BanType BanType { get; set; }

		public BanDetails BanDetails { get; set; }

		public BanDetails OldBanDetails { get; }

		public BanUpdatingEventArgs(BanHandler.BanType banType, BanDetails banDetails, BanDetails oldBanDetails)
		{
			IsAllowed = true;
			BanType = banType;
			BanDetails = banDetails;
			OldBanDetails = oldBanDetails;
		}
	}
}
