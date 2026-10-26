namespace Achievements.Handlers
{
	public class HeWillBeBackHandler : AchievementHandlerBase
	{
		internal override void OnInitialize()
		{
			PocketDimensionTeleport.OnPlayerEscapePocketDimension += OnPlayerEscapePocketDimension;
		}

		private void OnPlayerEscapePocketDimension(ReferenceHub hub)
		{
			AchievementHandlerBase.ServerAchieve(hub.connectionToClient, AchievementName.HeWillBeBack);
		}
	}
}
