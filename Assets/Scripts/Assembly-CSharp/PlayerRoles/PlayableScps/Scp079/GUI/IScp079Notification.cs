namespace PlayerRoles.PlayableScps.Scp079.GUI
{
	public interface IScp079Notification
	{
		string DisplayedText { get; }

		float Opacity { get; }

		bool Delete { get; }

		NotificationSound Sound { get; }

		float Height { get; }
	}
}
