using UnityEngine;

namespace AnimatorLayerManagement
{
	public interface IAnimatorLayerSource
	{
		RuntimeAnimatorController AnimLayersSource { get; }
	}
}
