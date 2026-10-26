using System;
using UnityEngine;

namespace InventorySystem.Items.Thirdperson
{
	[Serializable]
	public struct AnimOverrideState3pPair
	{
		public AnimState3p State;

		public AnimationClip Override;
	}
}
