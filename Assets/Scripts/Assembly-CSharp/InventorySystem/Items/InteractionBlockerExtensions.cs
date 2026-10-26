namespace InventorySystem.Items
{
	public static class InteractionBlockerExtensions
	{
		public static bool HasFlagFast(this BlockedInteraction activeFlags, BlockedInteraction flagToCheck)
		{
			return (activeFlags & flagToCheck) == flagToCheck;
		}

		public static bool HasBlock(this ReferenceHub hub, BlockedInteraction flag)
		{
			return hub.interCoordinator.AnyBlocker(flag);
		}
	}
}
