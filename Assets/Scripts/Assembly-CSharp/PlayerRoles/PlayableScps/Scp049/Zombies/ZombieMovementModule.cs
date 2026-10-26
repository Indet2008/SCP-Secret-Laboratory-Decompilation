using PlayerRoles.FirstPersonControl;
using UnityEngine;

namespace PlayerRoles.PlayableScps.Scp049.Zombies
{
	public class ZombieMovementModule : FirstPersonMovementModule
	{
		public const float MaxTargetTime = 5f;

		private const float MinTargetTime = 1f;

		private const float SpeedPerTick = 0.05f;

		[SerializeField]
		private ZombieRole _role;

		private ZombieBloodlustAbility _visionTracker;

		private float _speedTickTimer;

		private bool _bloodlustActive;

		private float _lookingTimer;

		public bool CanMove { get; set; }

		public float BloodlustSpeed { get; private set; }

		public float NormalSpeed { get; private set; }

		private float MovementSpeed
		{
			get
			{
				return WalkSpeed;
			}
			set
			{
				WalkSpeed = value;
				SprintSpeed = value;
			}
		}

		public void ForceBloodlustSpeed()
		{
			MovementSpeed = BloodlustSpeed;
		}

		private void Awake()
		{
			NormalSpeed = WalkSpeed;
			BloodlustSpeed = SprintSpeed;
			_role.SubroutineModule.TryGetSubroutine<ZombieBloodlustAbility>(out _visionTracker);
		}

		protected override void UpdateMovement()
		{
			float deltaTime = Time.deltaTime;
			UpdateBloodlustState(deltaTime);
			UpdateSpeed(deltaTime);
			base.UpdateMovement();
		}

		private void UpdateBloodlustState(float deltaTime)
		{
			float value = _lookingTimer + (_visionTracker.LookingAtTarget ? deltaTime : (0f - deltaTime));
			_lookingTimer = Mathf.Clamp(value, 0f, 5f);
			if (_lookingTimer > 1f)
			{
				_bloodlustActive = true;
			}
			else if (_lookingTimer == 0f)
			{
				_bloodlustActive = false;
			}
		}

		private void UpdateSpeed(float deltaTime)
		{
			_speedTickTimer += deltaTime;
			if (!(_speedTickTimer < 1f))
			{
				_speedTickTimer = 0f;
				float value = MovementSpeed + (_bloodlustActive ? 0.05f : (-0.1f));
				MovementSpeed = Mathf.Clamp(value, NormalSpeed, BloodlustSpeed);
			}
		}
	}
}
