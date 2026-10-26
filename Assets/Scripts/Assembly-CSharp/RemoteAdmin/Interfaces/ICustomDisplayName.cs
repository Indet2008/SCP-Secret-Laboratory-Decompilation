namespace RemoteAdmin.Interfaces
{
	public interface ICustomDisplayName
	{
		string DisplayName { get; }

		bool CanBeDisplayed { get; }
	}
}
