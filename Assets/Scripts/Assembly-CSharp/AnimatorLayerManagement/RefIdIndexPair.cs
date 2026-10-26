using System;

namespace AnimatorLayerManagement
{
	[Serializable]
	public struct RefIdIndexPair
	{
		public LayerRefId RefId;

		public int LayerIndex;

		public RefIdIndexPair(LayerRefId refId, int layerIndex)
		{
			RefId = refId;
			LayerIndex = layerIndex;
		}
	}
}
