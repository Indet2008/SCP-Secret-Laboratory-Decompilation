using UnityEngine;

namespace InventorySystem.Items.SwayControllers
{
	public class FixedSway : IItemSwayController
	{
		private readonly Vector3 _fixedPosition;

		private readonly Quaternion _fixedRotation;

		private Transform _transform;

		private bool _update;

		public FixedSway(Transform targetTransform, Vector3 fixedPosition, Vector3 fixedRotation)
		{
			_transform = targetTransform;
			_fixedPosition = fixedPosition;
			_fixedRotation = Quaternion.Euler(fixedRotation);
			_update = true;
		}

		public void SetTransform(Transform targetTransform)
		{
			_transform = targetTransform;
			_update = true;
		}

		public void UpdateSway()
		{
			if (_update && !(_transform == null))
			{
				_transform.localPosition = _fixedPosition;
				_transform.localRotation = _fixedRotation;
				_update = false;
			}
		}
	}
}
