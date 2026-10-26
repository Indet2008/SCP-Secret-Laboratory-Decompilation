using UnityEngine;

namespace InventorySystem.Items.Keycards
{
	public abstract class DetailBase : MonoBehaviour
	{
		public abstract void ApplyDetail(KeycardGfx gfxTarget, KeycardItem template);
	}
}
