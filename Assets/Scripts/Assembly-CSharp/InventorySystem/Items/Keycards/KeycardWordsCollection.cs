using System;
using MapGeneration;
using UnityEngine;

namespace InventorySystem.Items.Keycards
{
	[CreateAssetMenu(fileName = "Word Collections", menuName = "ScriptableObject/Items/Keycard Words Collection")]
	public class KeycardWordsCollection : ScriptableObject
	{
		private int[] _ids;

		private int _lastId;

		private int _lastSeed;

		[field: SerializeField]
		public string[] Words { get; private set; }

		public string NextRandomWord()
		{
			if (_ids == null || _lastSeed != SeedSynchronizer.Seed)
			{
				ReRandomize();
			}
			int num = _ids[_lastId++ % _ids.Length];
			return Words[num % Words.Length];
		}

		public void ReRandomize()
		{
			int num = Words.Length;
			if (_ids == null || _ids.Length != num)
			{
				_ids = new int[num];
			}
			for (int i = 0; i < num; i++)
			{
				_ids[i] = i;
			}
			System.Random random = new System.Random();
			int num2 = num;
			while (num2 > 1)
			{
				num2--;
				int num3 = random.Next(num2 + 1);
				ref int reference = ref _ids[num2];
				ref int reference2 = ref _ids[num3];
				int num4 = _ids[num3];
				int num5 = _ids[num2];
				reference = num4;
				reference2 = num5;
			}
			_lastSeed = SeedSynchronizer.Seed;
		}
	}
}
