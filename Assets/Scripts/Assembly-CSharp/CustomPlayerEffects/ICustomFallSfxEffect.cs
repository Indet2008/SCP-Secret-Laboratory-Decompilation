using UnityEngine;

namespace CustomPlayerEffects
{
	public interface ICustomFallSfxEffect
	{
		AudioClip FallSfxClip { get; }

		float FallSfxVolume => 1f;
	}
}
