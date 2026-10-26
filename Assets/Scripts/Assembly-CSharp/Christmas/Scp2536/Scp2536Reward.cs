namespace Christmas.Scp2536
{
	public struct Scp2536Reward
	{
		public readonly ItemType Reward;

		public readonly float Weight;

		public Scp2536Reward(ItemType reward, float weight)
		{
			Reward = reward;
			Weight = weight;
		}
	}
}
