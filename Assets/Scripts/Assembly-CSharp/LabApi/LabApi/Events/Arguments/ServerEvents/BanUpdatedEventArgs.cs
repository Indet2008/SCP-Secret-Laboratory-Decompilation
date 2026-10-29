namespace LabApi.Events.Arguments.ServerEvents
{
	public class BanUpdatedEventArgs : global::System.EventArgs
	{
		public BanHandler.BanType BanType { get; }

		public BanDetails BanDetails { get; }

		public BanDetails OldBanDetails { get; }

		public BanUpdatedEventArgs(BanHandler.BanType banType, BanDetails banDetails, BanDetails oldBanDetails)
		{
			BanType = banType;
			BanDetails = banDetails;
			OldBanDetails = oldBanDetails;
		}
	}
}
