using UnityEngine;

namespace RelativePositioning
{
	public class RigidBodyWaypointFollower : WaypointFollowerBase
	{
		private const float MinWaypointUpdateDistance = 0.1f;

		private const float SqrMinWaypointUpdateDistance = 0.010000001f;

		public Rigidbody Rigidbody;

		private Transform _cachedTransform;

		private Vector3 _lastLocalPos;

		private bool _unlinked;

		protected void Awake()
		{
			_cachedTransform = base.transform;
		}

		protected void LateUpdate()
		{
			if (!_unlinked && !Rigidbody.IsSleeping())
			{
				Vector3 localPosition = _cachedTransform.localPosition;
				if (!((_lastLocalPos - localPosition).sqrMagnitude < 0.010000001f))
				{
					_lastLocalPos = localPosition;
					base.LastPosition = new RelativePosition(_cachedTransform.position);
				}
			}
		}

		private void Reset()
		{
			Rigidbody = GetComponent<Rigidbody>();
		}

		public void Unlink()
		{
			_unlinked = true;
		}
	}
}
