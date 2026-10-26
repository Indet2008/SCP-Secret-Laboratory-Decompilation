using UnityEngine;

namespace CustomPlayerEffects
{
	public abstract class PostProcessEffectPulse : MonoBehaviour
	{
		// Client-only serialized fields restored from the v14 client layout (server build stripped them).
		[global::UnityEngine.SerializeField]
		[global::UnityEngine.Serialization.FormerlySerializedAs("PulseIntensity")]
		private float _pulseIntensity;

		public float animationSpeedMultiplier;


		public void Pulse()
		{
		}
	}
}
