using System;
using AnimatorLayerManagement;
using PlayerRoles.FirstPersonControl.Thirdperson;

namespace InventorySystem.Items.Thirdperson
{
	[Serializable]
	public class ItemLayerLink
	{
		public AnimItemLayer3p Layer3p;

		public LayerRefId LayerRef;

		private int? _cachedIndex;

		public int GetLayerIndex(AnimatedCharacterModel model)
		{
			if (!_cachedIndex.HasValue)
			{
				_cachedIndex = model.LayerManager.GetLayerIndex(LayerRef);
			}
			return _cachedIndex.Value;
		}
	}
}
