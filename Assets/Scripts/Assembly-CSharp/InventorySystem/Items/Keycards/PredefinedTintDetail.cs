using UnityEngine;

namespace InventorySystem.Items.Keycards
{
	public class PredefinedTintDetail : DetailBase
	{
		[SerializeField]
		private Color _color;

		public override void ApplyDetail(KeycardGfx gfxTarget, KeycardItem template)
		{
			gfxTarget.SetTint(_color);
		}
	}
}
