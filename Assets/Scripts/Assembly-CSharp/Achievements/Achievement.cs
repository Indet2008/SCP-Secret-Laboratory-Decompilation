namespace Achievements
{
	public readonly struct Achievement
	{
		public readonly string SteamName;

		private readonly string _steamProgress;

		private readonly long _discordId;

		private readonly int _maxValue;

		public readonly bool ActivatedByServer;

		public Achievement(string steamName, long discordId, bool byServer = false)
		{
			SteamName = steamName;
			_discordId = discordId;
			_steamProgress = string.Empty;
			_maxValue = 0;
			ActivatedByServer = byServer;
		}

		public Achievement(string steamName, string steamParameter, long discordId, int maxValue, bool byServer = false)
		{
			SteamName = steamName;
			_discordId = discordId;
			_steamProgress = steamParameter;
			_maxValue = maxValue;
			ActivatedByServer = byServer;
		}

		public void Achieve()
		{
		}

		public void AddProgress(int amt = 1)
		{
		}

		public void Reset()
		{
		}
	}
}
