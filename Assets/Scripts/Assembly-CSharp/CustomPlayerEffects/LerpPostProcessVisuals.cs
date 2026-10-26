using UnityEngine;
using UnityEngine.Rendering;

namespace CustomPlayerEffects
{
	[RequireComponent(typeof(Volume))]
	public class LerpPostProcessVisuals : LerpVisualsBase
	{
		private Volume _volume;

		protected Volume TargetVolume
		{
			get
			{
				if (_volume == null)
				{
					_volume = GetComponent<Volume>();
				}
				return _volume;
			}
		}

		protected override void ApplyWeight(float weight)
		{
			Volume targetVolume = TargetVolume;
			if (!(targetVolume == null))
			{
				targetVolume.weight = weight;
				targetVolume.enabled = weight > 0f;
			}
		}
	}
}
