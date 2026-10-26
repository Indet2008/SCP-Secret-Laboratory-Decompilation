namespace OperationalGuide
{
	public class PannableObject : global::UnityEngine.MonoBehaviour
	{
		private const float RotationSpeed = 400f;

		private const float IdleRotationSpeed = 25f;

		private const float InertiaDecay = 0.9875f;

		private const float SlowAmount = 0.1f;

		private const float AgressiveInertiaDecay = 0.96f;

		public bool UserInput;

		public float XAxisModifer;

		public float YAxisModifer;

		private float _verticalInertia;

		private float _horizontalInertia;

		private void FixedUpdate()
		{
		}

		public virtual void OnUpdate()
		{
		}

		private void OnEnable()
		{
		}

		public virtual void Enable()
		{
		}

		private void OnDisable()
		{
		}

		public virtual void Disable()
		{
		}

		public virtual void OnStart()
		{
		}

		private void Start()
		{
		}

		public PannableObject()
		{
		}
	}
}
