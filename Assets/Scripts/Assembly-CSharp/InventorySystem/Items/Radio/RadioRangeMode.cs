using System;
using UnityEngine;

namespace InventorySystem.Items.Radio
{
	[Serializable]
	public struct RadioRangeMode
	{
		private const float VerticalMilestone = 250f;

		public string ShortName;

		public string FullName;

		public Texture SignalTexture;

		public float MinuteCostWhenIdle;

		public int MinuteCostWhenTalking;

		public int MaximumRange;

		public int VerticalPenetration;

		public readonly bool CheckRange(Vector3 lhs, Vector3 rhs, out float sqrMag)
		{
			Vector3 vector = lhs - rhs;
			sqrMag = vector.sqrMagnitude;
			if (sqrMag > (float)(MaximumRange * MaximumRange))
			{
				return false;
			}
			return (int)Mathf.Abs(vector.y * 0.004f) <= VerticalPenetration;
		}
	}
}
