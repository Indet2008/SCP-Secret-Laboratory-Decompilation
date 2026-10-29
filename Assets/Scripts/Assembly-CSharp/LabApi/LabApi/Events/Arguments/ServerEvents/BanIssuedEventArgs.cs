namespace LabApi.Events.Arguments.ServerEvents
{
	public class BanIssuedEventArgs : global::System.EventArgs
	{
		public BanHandler.BanType BanType { get; }

		public BanDetails BanDetails { get; }

		public BanIssuedEventArgs(BanHandler.BanType banType, BanDetails banDetails)
		{
			BanType = banType;
			BanDetails = banDetails;
		}
	}
}
