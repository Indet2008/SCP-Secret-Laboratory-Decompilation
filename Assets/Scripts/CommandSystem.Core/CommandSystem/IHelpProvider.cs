namespace CommandSystem
{
	public interface IHelpProvider
	{
		string GetHelp(global::System.ArraySegment<string> arguments);
	}
}
