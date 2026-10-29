namespace LabApi.Features.Console
{
	public static class Logger
	{
		private const string DebugPrefix = "DEBUG";

		private const string InfoPrefix = "INFO";

		private const string WarnPrefix = "WARN";

		private const string ErrorPrefix = "ERROR";

		private const string InternalPrefix = "INTERNAL";

		public static void Raw(string message, global::System.ConsoleColor color)
		{
			ServerConsole.AddLog(message, color);
		}

		public static void Debug(object message, bool canBePrinted = true)
		{
			if (canBePrinted)
			{
				Raw(FormatLog(message, "DEBUG", global::System.Reflection.Assembly.GetCallingAssembly()), global::System.ConsoleColor.Gray);
			}
		}

		public static void Info(object message)
		{
			Raw(FormatLog(message, "INFO", global::System.Reflection.Assembly.GetCallingAssembly()), global::System.ConsoleColor.White);
		}

		public static void Warn(object message)
		{
			Raw(FormatLog(message, "WARN", global::System.Reflection.Assembly.GetCallingAssembly()), global::System.ConsoleColor.Yellow);
		}

		public static void Error(object message)
		{
			Raw(FormatLog(message, "ERROR", global::System.Reflection.Assembly.GetCallingAssembly()), global::System.ConsoleColor.Red);
		}

		internal static void InternalWarn(object message)
		{
			Raw(InternalFormatLog(message, "WARN"), global::System.ConsoleColor.DarkYellow);
		}

		internal static void InternalError(object message)
		{
			Raw(InternalFormatLog(message, "ERROR"), global::System.ConsoleColor.DarkRed);
		}

		private static string FormatAssemblyName(global::System.Reflection.Assembly assembly)
		{
			return assembly.GetName().Name;
		}

		private static string FormatLog(object message, string prefix, global::System.Reflection.Assembly assembly)
		{
			return $"[{prefix}] [{FormatAssemblyName(assembly)}] {message}";
		}

		private static string InternalFormatLog(object message, string prefix)
		{
			return string.Format("[LabAPI {0} {1}] {2}", "INTERNAL", prefix, message);
		}
	}
}
