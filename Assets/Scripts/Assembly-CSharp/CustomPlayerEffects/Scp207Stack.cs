using System;
using UnityEngine;

namespace CustomPlayerEffects
{
	[Serializable]
	public struct Scp207Stack : ICokeStack
	{
		public float DamageAmount;

		[field: SerializeField]
		public float PostProcessIntensity { get; set; }

		[field: SerializeField]
		public float SpeedMultiplier { get; set; }
	}
}
