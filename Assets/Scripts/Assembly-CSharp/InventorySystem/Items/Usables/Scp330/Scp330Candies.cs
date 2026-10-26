using System.Collections.Generic;
using MapGeneration.Holidays;
using UnityEngine;

namespace InventorySystem.Items.Usables.Scp330
{
	public static class Scp330Candies
	{
		public static readonly ICandy[] NormalCandies = new ICandy[8]
		{
			new CandyGreen(),
			new CandyPurple(),
			new CandyRainbow(),
			new CandyRed(),
			new CandyYellow(),
			new CandyBlue(),
			new CandyPink(),
			new CandyBlack()
		};

		public static readonly ICandy[] HauntedCandies = new ICandy[13]
		{
			new HauntedCandyGreen(),
			new HauntedCandyPurple(),
			new HauntedCandyRainbow(),
			new HauntedCandyRed(),
			new HauntedCandyYellow(),
			new HauntedCandyBlue(),
			new HauntedCandyPink(),
			new HauntedCandyBlack(),
			new HauntedCandyGray(),
			new HauntedCandyWhite(),
			new HauntedCandyBrown(),
			new HauntedCandyOrange(),
			new HauntedCandyEvil()
		};

		private static readonly Dictionary<CandyKindID, ICandy> DictionarizedCandies = new Dictionary<CandyKindID, ICandy>();

		private static bool _dictionarySet = false;

		public static ICandy[] Candies
		{
			get
			{
				if (HolidayUtils.IsHolidayActive(HolidayType.Halloween))
				{
					return HauntedCandies;
				}
				return NormalCandies;
			}
		}

		public static Dictionary<CandyKindID, ICandy> CandiesById
		{
			get
			{
				if (!_dictionarySet)
				{
					ICandy[] candies = Candies;
					foreach (ICandy candy in candies)
					{
						DictionarizedCandies[candy.Kind] = candy;
					}
					_dictionarySet = true;
				}
				return DictionarizedCandies;
			}
		}

		public static CandyKindID GetRandom(CandyKindID ignoredKind = CandyKindID.None)
		{
			float num = 0f;
			ICandy[] candies = Candies;
			foreach (ICandy candy in candies)
			{
				if (candy.Kind != ignoredKind)
				{
					num += candy.SpawnChanceWeight;
				}
			}
			float num2 = Random.Range(0f, num);
			candies = Candies;
			foreach (ICandy candy2 in candies)
			{
				if (candy2.Kind != ignoredKind)
				{
					num2 -= candy2.SpawnChanceWeight;
					if (!(num2 > 0f))
					{
						return candy2.Kind;
					}
				}
			}
			return CandyKindID.None;
		}
	}
}
