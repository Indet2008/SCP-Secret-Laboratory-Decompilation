namespace InventorySystem.Items
{
	public interface ISoundEmittingItem
	{
		bool TryGetSoundEmissionRange(out float range);
	}
}
