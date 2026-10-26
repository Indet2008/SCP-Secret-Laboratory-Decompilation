using System.Collections.Generic;
using InventorySystem.Items.Usables;
using PlayerRoles;

namespace Achievements.Handlers
{
	public class RuleBreakerHandler : AchievementHandlerBase
	{
		private const int CandiesNeeded = 3;

		private static readonly Dictionary<ReferenceHub, int> CandiesEaten = new Dictionary<ReferenceHub, int>();

		internal override void OnInitialize()
		{
			UsableItemsController.ServerOnUsingCompleted += OnUsedScp330;
			PlayerRoleManager.OnServerRoleSet += OnServerRoleSet;
		}

		internal override void OnRoundStarted()
		{
			CandiesEaten.Clear();
		}

		private static void OnServerRoleSet(ReferenceHub hub, RoleTypeId roleTypeId, RoleChangeReason changeReason)
		{
			CandiesEaten.Remove(hub);
		}

		private static void OnUsedScp330(ReferenceHub hub, UsableItem item)
		{
			if (item.ItemTypeId == ItemType.SCP330)
			{
				int valueOrDefault = CandiesEaten.GetValueOrDefault(hub, 0);
				valueOrDefault = (CandiesEaten[hub] = valueOrDefault + 1);
				if (valueOrDefault >= 3)
				{
					AchievementHandlerBase.ServerAchieve(hub.connectionToClient, AchievementName.RuleBreaker);
				}
			}
		}
	}
}
