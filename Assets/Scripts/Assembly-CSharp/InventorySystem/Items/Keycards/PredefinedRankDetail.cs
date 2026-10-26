using UnityEngine;

namespace InventorySystem.Items.Keycards
{
	public class PredefinedRankDetail : DetailBase
	{
		[SerializeField]
		private Mesh _mesh;

		public override void ApplyDetail(KeycardGfx gfxTarget, KeycardItem template)
		{
			gfxTarget.RankFilter.sharedMesh = _mesh;
		}
	}
}
