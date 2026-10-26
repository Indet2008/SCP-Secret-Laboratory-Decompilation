namespace Mirror
{
	internal struct LogEntry
	{
		public string message;

		public global::UnityEngine.LogType type;

		public LogEntry(string message, global::UnityEngine.LogType type)
		{
			this.message = message;
			this.type = type;
		}
	}
}
