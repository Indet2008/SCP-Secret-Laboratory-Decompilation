using UnityEngine;

namespace CustomPlayerEffects
{
	public abstract class PostProcessEffectWave : MonoBehaviour
	{
		// Client-only serialized fields restored from the v14 client layout (server build stripped them).
		public float WaveIntensity;

		public float speedMultiplier;

		public float disableTolerance;


	}
}
