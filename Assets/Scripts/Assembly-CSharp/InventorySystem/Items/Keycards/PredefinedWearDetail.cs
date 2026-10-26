using UnityEngine;

namespace InventorySystem.Items.Keycards
{
	public class PredefinedWearDetail : DetailBase
	{
		[SerializeField]
		private int _wearLevel;

		public override void ApplyDetail(KeycardGfx gfxTarget, KeycardItem template)
		{
			for (int i = 0; i < gfxTarget.ElementVariants.Length; i++)
			{
				gfxTarget.ElementVariants[i].SetActive(i == _wearLevel);
			}
		}
	}
}
