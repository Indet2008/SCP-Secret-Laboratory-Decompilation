namespace PlayerRoles.PlayableScps.Scp079.GUI
{
	public interface IScp079FailMessageProvider
	{
		string FailMessage { get; }

		void OnFailMessageAssigned();
	}
}
