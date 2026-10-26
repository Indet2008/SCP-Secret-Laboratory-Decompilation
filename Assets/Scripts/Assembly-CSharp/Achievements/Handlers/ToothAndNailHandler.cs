using InventorySystem.Items.Firearms;
using InventorySystem.Items.Firearms.Modules;
using InventorySystem.Items.Firearms.Modules.Scp127;

namespace Achievements.Handlers
{
	public class ToothAndNailHandler : AchievementHandlerBase
	{
		private const Scp127Tier TierLimit = Scp127Tier.Tier3;

		internal override void OnInitialize()
		{
			Scp127TierManagerModule.ServerOnLevelledUp += OnLevelUp;
		}

		private void OnLevelUp(Firearm firearm)
		{
			if (firearm.HasOwner && firearm.TryGetModule<Scp127TierManagerModule>(out var module) && module.CurTier >= Scp127Tier.Tier3)
			{
				AchievementHandlerBase.ServerAchieve(firearm.Owner.connectionToClient, AchievementName.ToothAndNail);
			}
		}
	}
}
