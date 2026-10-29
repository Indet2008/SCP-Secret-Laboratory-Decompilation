using PlayerRoles.RoleAssign;
using UnityEngine;
using UserSettings.ControlsSettings;

namespace OperationalGuide
{
	public class PannableObject : MonoBehaviour
	{
		private const float RotationSpeed = 400f;

		private const float IdleRotationSpeed = 25f;

		private const float InertiaDecay = 0.9875f;

		private const float SlowAmount = 0.1f;

		private const float AgressiveInertiaDecay = 0.96f;

		public bool UserInput;

		public float XAxisModifer = -1f;

		public float YAxisModifer = 1f;

		private float _verticalInertia;

		private float _horizontalInertia;

		// Drag with LMB to spin, inertia decays afterwards; idles with a slow turn until the user touches it.
		private void FixedUpdate()
		{
			if (Input.GetMouseButton(0) && !ScpPreferenceSlider.AnyHighlighted)
			{
				UserInput = true;
				_verticalInertia = Input.GetAxis("Mouse Y") * 400f * Time.deltaTime * YAxisModifer * SensitivitySettings.SensMultiplier;
				_horizontalInertia = Input.GetAxis("Mouse X") * 400f * Time.deltaTime * XAxisModifer * SensitivitySettings.SensMultiplier;
			}
			else
			{
				float num = ((Mathf.Abs(_horizontalInertia) > 0.1f) ? 0.9875f : 0.96f);
				_horizontalInertia *= num;
				_verticalInertia *= num;
			}
			base.transform.Rotate(new Vector3(_verticalInertia, _horizontalInertia, 0f), Space.World);
			if (!UserInput)
			{
				base.transform.Rotate(new Vector3(0f, Time.deltaTime * 25f, 0f), Space.World);
			}
			OnUpdate();
		}

		public virtual void OnUpdate()
		{
		}

		private void OnEnable()
		{
			UserInput = false;
			Enable();
		}

		public virtual void Enable()
		{
		}

		private void OnDisable()
		{
			UserInput = false;
			Disable();
		}

		public virtual void Disable()
		{
		}

		public virtual void OnStart()
		{
		}

		private void Start()
		{
			OnStart();
		}
	}
}
