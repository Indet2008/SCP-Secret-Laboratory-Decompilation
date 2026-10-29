namespace LabApi.Events.Arguments.ServerEvents
{
	public class BanRevokedEventArgs : global::System.EventArgs
	{
		public BanHandler.BanType BanType { get; }

		public BanDetails BanDetails { get; }

		public BanRevokedEventArgs(BanHandler.BanType banType, BanDetails banDetails)
		{
			BanType = banType;
			BanDetails = banDetails;
		}
	}
}
