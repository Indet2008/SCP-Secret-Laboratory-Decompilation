using PlayerRoles;
using PlayerStatsSystem;
using UnityEngine;

namespace DeathAnimations
{
	public class HeadSpin : DeathAnimation
	{
		private const float NeckSpinAngle = 140f;

		private const float NeckSnapSpeed = 30f;

		private float _snapAngle;

		private int _randomSnapDirection;

		private CharacterJoint _joint;

		protected override void OnAnimationStarted()
		{
			if (base.TargetRagdoll.Info.Handler is ScpDamageHandler scpDamageHandler && scpDamageHandler.Attacker.Role == RoleTypeId.Scp173)
			{
				base.enabled = true;
				_randomSnapDirection = ((Random.Range(0, 2) == 1) ? (-1) : 1);
				_joint = GetComponent<CharacterJoint>();
				_joint.swing2Limit = new SoftJointLimit
				{
					limit = 180f
				};
			}
			else
			{
				Object.Destroy(this);
			}
		}

		private void Update()
		{
			if (_snapAngle < 140f)
			{
				_snapAngle += 30f;
				base.transform.Rotate(Vector3.up * ((float)_randomSnapDirection * 30f), Space.Self);
				return;
			}
			_joint.swing1Limit = new SoftJointLimit
			{
				limit = 40f
			};
			_joint.swing2Limit = new SoftJointLimit
			{
				limit = 35f
			};
			Vector3 axis = _joint.axis;
			Vector3 axis2 = _joint.axis;
			_joint.axis = new Vector3(axis.x, axis2.y, (float)_randomSnapDirection * _snapAngle);
			Object.Destroy(this);
		}
	}
}
