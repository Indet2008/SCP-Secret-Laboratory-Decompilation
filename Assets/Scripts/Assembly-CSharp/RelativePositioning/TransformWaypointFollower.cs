using UnityEngine;

namespace RelativePositioning
{
	public class TransformWaypointFollower : WaypointFollowerBase
	{
		private const float MinWaypointUpdateDistance = 0.1f;

		private const float SqrMinWaypointUpdateDistance = 0.010000001f;

		private Transform _cachedTransform;

		private Vector3 _lastLocalPos;

		protected void Awake()
		{
			_cachedTransform = base.gameObject.transform;
		}

		protected void LateUpdate()
		{
			Vector3 localPosition = _cachedTransform.localPosition;
			if (!((_lastLocalPos - localPosition).sqrMagnitude < 0.010000001f))
			{
				_lastLocalPos = localPosition;
				base.LastPosition = new RelativePosition(_cachedTransform.position);
			}
		}
	}
}
