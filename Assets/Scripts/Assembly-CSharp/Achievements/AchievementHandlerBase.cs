using System;
using LabApi.Events.Arguments.PlayerEvents;
using LabApi.Events.Handlers;
using Mirror;

namespace Achievements
{
	public abstract class AchievementHandlerBase
	{
		private static bool AllowAchievements => (ServerConfigSynchronizer.Singleton.MainBoolsSync & 2) == 0;

		internal virtual void OnInitialize()
		{
		}

		internal virtual void OnRoundStarted()
		{
		}

		public static void ClientAchieve(AchievementName targetAchievement)
		{
			if (AllowAchievements && AchievementManager.Achievements.TryGetValue(targetAchievement, out var value))
			{
				value.Achieve();
			}
		}

		public static void ServerAchieve(NetworkConnection conn, AchievementName targetAchievement)
		{
			if (!NetworkServer.active)
			{
				throw new InvalidOperationException("Method ServerAchieve can only be executed on the server.");
			}
			if (!conn.identity.isLocalPlayer && AllowAchievements)
			{
				conn.Send(new AchievementManager.AchievementMessage
				{
					AchievementId = (byte)targetAchievement
				});
				PlayerEvents.OnReceivedAchievement(new PlayerReceivedAchievementEventArgs(conn.identity, targetAchievement));
			}
		}
	}
}
