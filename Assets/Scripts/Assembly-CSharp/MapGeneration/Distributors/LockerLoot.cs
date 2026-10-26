using System;

namespace MapGeneration.Distributors
{
	[Serializable]
	public class LockerLoot
	{
		public ItemType TargetItem;

		public int RemainingUses;

		public int MaxPerChamber;

		public int ProbabilityPoints;

		public int MinPerChamber = 1;
	}
}
