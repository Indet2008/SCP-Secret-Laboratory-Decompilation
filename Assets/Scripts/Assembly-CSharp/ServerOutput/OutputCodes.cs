namespace ServerOutput
{
	public enum OutputCodes : byte
	{
		RoundRestart = 16,
		IdleEnter = 17,
		IdleExit = 18,
		ExitActionReset = 19,
		ExitActionShutdown = 20,
		ExitActionSilentShutdown = 21,
		ExitActionRestart = 22,
		Heartbeat = 23
	}
}
