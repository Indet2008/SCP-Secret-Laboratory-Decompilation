using System;
using UnityEngine;

namespace InventorySystem.Items.Firearms.Modules.Misc
{
	[Serializable]
	public struct BuckshotSettings
	{
		public Vector2[] PredefinedPellets;

		public int MaxHits;

		public float Randomness;

		public float OverallScale;
	}
}
