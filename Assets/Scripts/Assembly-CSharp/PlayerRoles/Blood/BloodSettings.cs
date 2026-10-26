using System;
using Decals;
using UnityEngine;

namespace PlayerRoles.Blood
{
	[Serializable]
	public class BloodSettings
	{
		[field: SerializeField]
		public DecalPoolType Decal { get; private set; }

		[field: Range(0f, 1f)]
		[field: SerializeField]
		public float DecalSpawnChance { get; private set; }

		public bool RandomDecalValidate => GetRandom(DecalSpawnChance);

		private bool GetRandom(float chance)
		{
			if (chance <= 0f)
			{
				return false;
			}
			if (chance >= 1f)
			{
				return true;
			}
			return UnityEngine.Random.value <= chance;
		}
	}
}
