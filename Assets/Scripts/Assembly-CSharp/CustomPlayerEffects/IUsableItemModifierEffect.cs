namespace CustomPlayerEffects
{
	public interface IUsableItemModifierEffect
	{
		bool TryGetSpeed(ItemType item, out float speed);
	}
}
