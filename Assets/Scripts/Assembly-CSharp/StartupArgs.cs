using System;

public static class StartupArgs
{
	public static readonly string[] Args;

	static StartupArgs()
	{
		Args = Environment.GetCommandLineArgs();
	}
}
