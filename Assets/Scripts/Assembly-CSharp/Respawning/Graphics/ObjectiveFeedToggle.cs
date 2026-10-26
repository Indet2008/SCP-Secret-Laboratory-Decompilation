using UnityEngine;
using UserSettings.GUIElements;

namespace Respawning.Graphics
{
	public class ObjectiveFeedToggle : UserSettingsToggle
	{
		[SerializeField]
		private RectTransform _targetTransform;

		[SerializeField]
		private float _disabledRotation = 180f;

		[SerializeField]
		private float _rotationSpeed = 7.5f;

		private float _targetRotation;

		private float _cachedRotation;

		protected override void SetValueAndTriggerEvent(bool val)
		{
			base.SetValueAndTriggerEvent(val);
			SetRotationStatus(val);
		}

		protected override void SetValueWithoutNotify(bool val)
		{
			base.SetValueWithoutNotify(val);
			SetRotationStatus(val);
		}

		protected override void Awake()
		{
			base.Awake();
			_cachedRotation = _targetTransform.eulerAngles.z;
			SetRotationStatus(base.StoredValue, instantRotation: true);
		}

		private void SetRotationStatus(bool isEnabled, bool instantRotation = false)
		{
			_targetRotation = (isEnabled ? _cachedRotation : _disabledRotation);
			if (instantRotation)
			{
				Vector3 eulerAngles = _targetTransform.eulerAngles;
				_targetTransform.rotation = Quaternion.Euler(eulerAngles.x, eulerAngles.y, _targetRotation);
			}
		}

		private void Update()
		{
			Vector3 eulerAngles = _targetTransform.eulerAngles;
			if (eulerAngles.z != _targetRotation)
			{
				float z = Mathf.LerpAngle(eulerAngles.z, _targetRotation, _rotationSpeed * Time.deltaTime);
				_targetTransform.rotation = Quaternion.Euler(eulerAngles.x, eulerAngles.y, z);
			}
		}
	}
}
