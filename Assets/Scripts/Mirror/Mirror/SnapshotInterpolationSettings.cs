namespace Mirror
{
	[global::System.Serializable]
	public class SnapshotInterpolationSettings
	{
		[global::UnityEngine.Header("Buffering")]
		[global::UnityEngine.Tooltip("Local simulation is behind by sendInterval * multiplier seconds.\n\nThis guarantees that we always have enough snapshots in the buffer to mitigate lags & jitter.\n\nIncrease this if the simulation isn't smooth. By default, it should be around 2.")]
		public double bufferTimeMultiplier = 2.0;

		[global::UnityEngine.Tooltip("If a client can't process snapshots fast enough, don't store too many.")]
		public int bufferLimit = 32;

		[global::UnityEngine.Header("Catchup / Slowdown")]
		[global::UnityEngine.Tooltip("Slowdown begins when the local timeline is moving too fast towards remote time. Threshold is in frames worth of snapshots.\n\nThis needs to be negative.\n\nDon't modify unless you know what you are doing.")]
		public float catchupNegativeThreshold = -1f;

		[global::UnityEngine.Tooltip("Catchup begins when the local timeline is moving too slow and getting too far away from remote time. Threshold is in frames worth of snapshots.\n\nThis needs to be positive.\n\nDon't modify unless you know what you are doing.")]
		public float catchupPositiveThreshold = 1f;

		[global::UnityEngine.Tooltip("Local timeline acceleration in % while catching up.")]
		[global::UnityEngine.Range(0f, 1f)]
		public double catchupSpeed = 0.019999999552965164;

		[global::UnityEngine.Tooltip("Local timeline slowdown in % while slowing down.")]
		[global::UnityEngine.Range(0f, 1f)]
		public double slowdownSpeed = 0.03999999910593033;

		[global::UnityEngine.Tooltip("Catchup/Slowdown is adjusted over n-second exponential moving average.")]
		public int driftEmaDuration = 1;

		[global::UnityEngine.Header("Dynamic Adjustment")]
		[global::UnityEngine.Tooltip("Automatically adjust bufferTimeMultiplier for smooth results.\nSets a low multiplier on stable connections, and a high multiplier on jittery connections.")]
		public bool dynamicAdjustment = true;

		[global::UnityEngine.Tooltip("Safety buffer that is always added to the dynamic bufferTimeMultiplier adjustment.")]
		public float dynamicAdjustmentTolerance = 1f;

		[global::UnityEngine.Tooltip("Dynamic adjustment is computed over n-second exponential moving average standard deviation.")]
		public int deliveryTimeEmaDuration = 2;
	}
}
