using CustomPlayerEffects;
using InventorySystem.Items.Usables.Scp1344;

namespace Achievements.Handlers
{
	public class HawkeyeHandler : AchievementHandlerBase
	{
		internal override void OnInitialize()
		{
			Scp1344HumanXrayProvider.OnPlayerSeen += OnPlayerSeen;
		}

		private void OnPlayerSeen(ReferenceHub owner, ReferenceHub seenPlayer)
		{
			if (owner.isLocalPlayer && seenPlayer.playerEffectsController.TryGetEffect<Invisible>(out var playerEffect) && playerEffect.IsEnabled && HitboxIdentity.IsEnemy(owner, seenPlayer))
			{
				AchievementHandlerBase.ClientAchieve(AchievementName.Hawkeye);
			}
		}
	}
}
