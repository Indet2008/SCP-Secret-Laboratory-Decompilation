namespace Mirror
{
	public class HistoryCollider : global::UnityEngine.MonoBehaviour
	{
		[global::UnityEngine.Header("Components")]
		[global::UnityEngine.Tooltip("The object's actual collider. We need to know where it is, and how large it is.")]
		public global::UnityEngine.Collider actualCollider;

		[global::UnityEngine.Tooltip("The helper collider that the history bounds are projected onto.\nNeeds to be added to a child GameObject to counter-rotate an axis aligned Bounding Box onto it.\nThis is only used by this component.")]
		public global::UnityEngine.BoxCollider boundsCollider;

		[global::UnityEngine.Header("History")]
		[global::UnityEngine.Tooltip("Keep this many past bounds in the buffer. The larger this is, the further we can raycast into the past.\nMaximum time := historyAmount * captureInterval")]
		public int boundsLimit = 8;

		[global::UnityEngine.Tooltip("Gather N bounds at a time into a bucket for faster encapsulation. A factor of 2 will be twice as fast, etc.")]
		public int boundsPerBucket = 2;

		[global::UnityEngine.Tooltip("Capture bounds every 'captureInterval' seconds. Larger values will require fewer computations, but may not capture every small move.")]
		public float captureInterval = 0.1f;

		private double lastCaptureTime;

		[global::UnityEngine.Header("Debug")]
		public global::UnityEngine.Color historyColor = new global::UnityEngine.Color(1f, 0.5f, 0f, 1f);

		public global::UnityEngine.Color currentColor = global::UnityEngine.Color.red;

		protected global::Mirror.HistoryBounds history;

		protected virtual void Awake()
		{
			history = new global::Mirror.HistoryBounds(boundsLimit, boundsPerBucket);
			if (actualCollider == null)
			{
				global::UnityEngine.Debug.LogError("HistoryCollider: actualCollider was not set.");
			}
			if (boundsCollider == null)
			{
				global::UnityEngine.Debug.LogError("HistoryCollider: boundsCollider was not set.");
			}
			if (boundsCollider.transform.parent != base.transform)
			{
				global::UnityEngine.Debug.LogError("HistoryCollider: boundsCollider must be a child of this GameObject.");
			}
			if (!boundsCollider.isTrigger)
			{
				global::UnityEngine.Debug.LogError("HistoryCollider: boundsCollider must be a trigger.");
			}
		}

		protected virtual void FixedUpdate()
		{
			if (global::Mirror.NetworkTime.localTime >= lastCaptureTime + (double)captureInterval)
			{
				lastCaptureTime = global::Mirror.NetworkTime.localTime;
				CaptureBounds();
			}
			ProjectBounds();
		}

		protected virtual void CaptureBounds()
		{
			global::UnityEngine.Bounds bounds = actualCollider.bounds;
			history.Insert(bounds);
		}

		protected virtual void ProjectBounds()
		{
			global::UnityEngine.Bounds total = history.total;
			if (history.boundsCount != 0)
			{
				if (base.transform.lossyScale != global::UnityEngine.Vector3.one)
				{
					global::UnityEngine.Debug.LogWarning("HistoryCollider: " + base.name + "'s transform global scale must be (1,1,1).");
					return;
				}
				boundsCollider.transform.localRotation = global::UnityEngine.Quaternion.Inverse(base.transform.rotation);
				boundsCollider.center = boundsCollider.transform.InverseTransformPoint(total.center);
				boundsCollider.size = total.size;
			}
		}

		protected virtual void OnDrawGizmos()
		{
			global::UnityEngine.Gizmos.color = historyColor;
			global::UnityEngine.Gizmos.DrawWireCube(history.total.center, history.total.size);
			global::UnityEngine.Gizmos.color = currentColor;
			global::UnityEngine.Gizmos.DrawWireCube(actualCollider.bounds.center, actualCollider.bounds.size);
		}
	}
}
