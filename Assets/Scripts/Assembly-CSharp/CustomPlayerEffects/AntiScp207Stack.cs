using System;
using UnityEngine;

namespace CustomPlayerEffects
{
	[Serializable]
	public struct AntiScp207Stack : ICokeStack
	{
		public float HealAmount;

		[field: SerializeField]
		public float PostProcessIntensity { get; set; }

		[field: SerializeField]
		public float SpeedMultiplier { get; set; }
	}
}
