using UnityEngine;

namespace InventorySystem.Items.ToggleableLights.Lantern
{
	public class LanternJointFix : MonoBehaviour
	{
		private Quaternion _initialLocalRotation;

		private Vector3 _initialLocalPosition;

		private Quaternion _localRotationOnDisable;

		private Vector3 _localPositionOnDisable;

		private bool _hasDisabled;

		private Transform _transform;

		private void Awake()
		{
			_transform = base.transform;
			_initialLocalRotation = _transform.localRotation;
			_initialLocalPosition = _transform.localPosition;
		}

		private void OnDisable()
		{
			_localRotationOnDisable = _transform.localRotation;
			_transform.localRotation = _initialLocalRotation;
			_localPositionOnDisable = _transform.localPosition;
			_transform.localPosition = _initialLocalPosition;
			_hasDisabled = true;
		}

		private void Update()
		{
			if (_hasDisabled)
			{
				_hasDisabled = false;
				_transform.localRotation = _localRotationOnDisable;
				_transform.localPosition = _localPositionOnDisable;
			}
		}
	}
}
