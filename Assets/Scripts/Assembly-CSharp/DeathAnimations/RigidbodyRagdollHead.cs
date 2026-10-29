using PlayerRoles.FirstPersonControl;
using UnityEngine;

namespace DeathAnimations
{
	public class RigidbodyRagdollHead : RagdollHead
	{
		private Vector3 _localPos;

		private Transform _parent;

		private Transform _t;

		private Vector3 _lastOrigin;

		[SerializeField]
		private float _thickness;

		private static int Mask => FpcStateProcessor.Mask;

		protected override void OnAnimationStarted()
		{
			base.OnAnimationStarted();
			if (base.IsFirstperson)
			{
				_t = SpectatorCameraAnchor.transform;
				_lastOrigin = _t.position;
				_parent = _t.parent;
				_localPos = _t.localPosition;
				_t.parent = null;
			}
		}

		// The detached camera anchor follows the ragdoll head but is swept against walls so it cannot clip through.
		private void Update()
		{
			if (!base.IsPlaying)
			{
				return;
			}
			_t.rotation = _parent.rotation;
			Vector3 vector = _parent.TransformPoint(_localPos);
			Vector3 direction = vector - _lastOrigin;
			float maxDistance = direction.magnitude + _thickness;
			if (Physics.SphereCast(_lastOrigin, _thickness, direction, out var hitInfo, maxDistance, Mask))
			{
				_t.position = hitInfo.point + hitInfo.normal * _thickness;
				return;
			}
			_lastOrigin = _t.position;
			_t.position = vector;
		}
	}
}
