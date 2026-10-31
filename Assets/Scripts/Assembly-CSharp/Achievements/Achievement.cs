using CentralAuth;
using GameCore;
using Steamworks;

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
			if (_maxValue != 0)
			{
				AddProgress();
				return;
			}
			switch (CentralAuthManager.Platform)
			{
			case DistributionPlatform.Steam:
				SetAchievementSteam(state: true);
				break;
			case DistributionPlatform.Discord:
				SetAchievementDiscord(state: true);
				break;
			}
		}

		public void AddProgress(int amt = 1)
		{
			if (_maxValue == 0)
			{
				Achieve();
				return;
			}
			if (CentralAuthManager.Platform == DistributionPlatform.Steam)
			{
				AddProgressSteam(amt);
			}
		}

		public void Reset()
		{
			switch (CentralAuthManager.Platform)
			{
			case DistributionPlatform.Steam:
				SetAchievementSteam(state: false);
				break;
			case DistributionPlatform.Discord:
				SetAchievementDiscord(state: false);
				break;
			}
		}

		private void SetAchievementDiscord(bool state)
		{
			CentralAuthManager.Discord.GetAchievementManager().SetUserAchievement(_discordId, (byte)(state ? 100 : 0), delegate
			{
			});
		}

		private void SetAchievementSteam(bool state)
		{
			if (!SteamManager.Running || SteamManager.CheckAchievement(SteamName) == state)
			{
				return;
			}
			if (state)
			{
				SteamManager.SetAchievement(SteamName);
			}
			else if (SteamManager.Running)
			{
				SteamManager.ResetAchievement(SteamName);
			}
		}

		private void AddProgressDiscord(int progress)
		{
		}

		private void AddProgressSteam(int progress)
		{
			if (!SteamManager.Running)
			{
				return;
			}
			int statInt = SteamUserStats.GetStatInt(_steamProgress);
			int num = statInt + progress;
			if (num < 0 || num > _maxValue)
			{
				num = ((num >= 0) ? _maxValue : 0);
			}
			if (statInt == num)
			{
				return;
			}
			SteamUserStats.SetStat(_steamProgress, num);
			if (!string.IsNullOrEmpty(SteamName))
			{
				if (num < _maxValue)
				{
					SteamUserStats.IndicateAchievementProgress(SteamName, num, _maxValue);
				}
				else
				{
					SteamManager.SetAchievement(SteamName);
				}
			}
		}
	}
}
