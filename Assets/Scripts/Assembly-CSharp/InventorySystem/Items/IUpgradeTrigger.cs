using Scp914;

namespace InventorySystem.Items
{
	public interface IUpgradeTrigger
	{
		void ServerOnUpgraded(Scp914KnobSetting setting);
	}
}
