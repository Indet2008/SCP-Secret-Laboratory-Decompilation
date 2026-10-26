using PlayerRoles.Voice;

namespace Achievements.Handlers
{
	public class IntercomHandler : AchievementHandlerBase
	{
		internal override void OnInitialize()
		{
			Intercom.OnServerBeginUsage += OnBeginUsage;
		}

		private void OnBeginUsage(ReferenceHub hub)
		{
			if (!(hub == null))
			{
				AchievementHandlerBase.ServerAchieve(hub.connectionToClient, AchievementName.IsThisThingOn);
			}
		}
	}
}
