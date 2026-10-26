using System;
using System.Linq;

public static class StartupArguments
{
	public static bool IsSetShort(string param)
	{
		return Environment.GetCommandLineArgs().Any((string x) => x.StartsWith("-") && !x.StartsWith("--") && x.Contains(param));
	}

	public static bool IsSetBool(string param, string alias = "")
	{
		if (!Environment.GetCommandLineArgs().Contains<string>("--" + param))
		{
			if (!string.IsNullOrEmpty(alias))
			{
				return IsSetShort(alias);
			}
			return false;
		}
		return true;
	}

	public static string GetArgument(string param, string alias = "", string def = "")
	{
		string[] commandLineArgs = Environment.GetCommandLineArgs();
		bool flag = false;
		string[] array = commandLineArgs;
		foreach (string text in array)
		{
			if (flag && !text.StartsWith("-"))
			{
				return text;
			}
			flag = text == "--" + param || (!string.IsNullOrEmpty(alias) && text.StartsWith("-") && !text.StartsWith("--") && text.EndsWith(alias));
		}
		return def;
	}
}
