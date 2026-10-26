namespace CustomPlayerEffects
{
	public interface ICustomHealableEffect : IHealableEffect
	{
		void OnHeal(ItemType item);
	}
}
