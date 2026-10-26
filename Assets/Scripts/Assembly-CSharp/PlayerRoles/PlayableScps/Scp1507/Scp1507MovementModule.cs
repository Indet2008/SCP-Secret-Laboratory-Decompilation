using PlayerRoles.FirstPersonControl;
using UnityEngine;

namespace PlayerRoles.PlayableScps.Scp1507
{
	public class Scp1507MovementModule : FirstPersonMovementModule
	{
		private const float SpeedPerSwarmAlly = 0.2f;

		[SerializeField]
		private Scp1507Role _scp1507;

		private Scp1507SwarmAbility _swarmAbility;

		private float _cachedDefaultSpeed;

		private float SpeedBoost => Mathf.Min((float)_swarmAbility.FlockSize * 0.2f, 1.4f);

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
				CrouchSpeed = value;
			}
		}

		protected override void UpdateMovement()
		{
			base.UpdateMovement();
			MovementSpeed = _cachedDefaultSpeed + SpeedBoost;
		}

		private void Awake()
		{
			_scp1507.SubroutineModule.TryGetSubroutine<Scp1507SwarmAbility>(out _swarmAbility);
			_cachedDefaultSpeed = MovementSpeed;
		}
	}
}
