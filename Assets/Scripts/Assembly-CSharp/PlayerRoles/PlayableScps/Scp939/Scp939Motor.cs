using System.Collections.Generic;
using Mirror;
using PlayerRoles.FirstPersonControl;
using UnityEngine;

namespace PlayerRoles.PlayableScps.Scp939
{
	public class Scp939Motor : FpcMotor
	{
		private const float MinDot = 0.4f;

		private const float LungeRadius = 0.6f;

		private const float FocusToleranceOffset = 0.13f;

		private const float FocusTimeTolerance = 3.5f;

		private const int MaxDetections = 32;

		private const float MinDistanceSqr = 0.4f;

		private readonly Scp939Role _role;

		private readonly Scp939FocusAbility _focus;

		private readonly Scp939LungeAbility _lunge;

		private readonly Scp939AmnesticCloudAbility _cloud;

		private static readonly Collider[] Detections = new Collider[32];

		private static readonly CachedLayerMask Mask = new CachedLayerMask("Hitbox", "Glass");

		private static readonly HashSet<FpcStandardRoleBase> DetectedTargets = new HashSet<FpcStandardRoleBase>();

		private bool IsLocalPlayer => ViewMode == FpcViewMode.LocalPlayer;

		private bool IsControllable
		{
			get
			{
				if (!IsLocalPlayer)
				{
					if (NetworkServer.active)
					{
						return Hub.IsDummy;
					}
					return false;
				}
				return true;
			}
		}

		private bool WantsToLunge
		{
			get
			{
				if (_lunge.IsReady)
				{
					if (!_lunge.LungeRequested)
					{
						return JumpController.WantsToJump;
					}
					return true;
				}
				return false;
			}
		}

		private bool IsLunging => _lunge.State == Scp939LungeState.Triggered;

		protected override float Speed
		{
			get
			{
				if (IsLunging)
				{
					return _lunge.LungeForwardSpeed;
				}
				if (IsLocalPlayer && _cloud.TargetState)
				{
					return base.Speed * Mathf.Clamp01(1f - _cloud.HoldDuration);
				}
				float num = _focus.State;
				if (NetworkServer.active && !IsLocalPlayer && _focus.TargetState)
				{
					if (_focus.FrozenTime > 3.5f)
					{
						return 0f;
					}
					num -= 0.13f;
				}
				return base.Speed * Mathf.Clamp01(1f - num);
			}
		}

		protected override Vector3 DesiredMove
		{
			get
			{
				if (!IsLocalPlayer || !IsLunging)
				{
					return base.DesiredMove;
				}
				return CachedTransform.forward;
			}
		}

		public override Vector3 Velocity
		{
			get
			{
				if (!NetworkServer.active || Hub.isLocalPlayer || !IsLunging)
				{
					return base.Velocity;
				}
				return CachedTransform.forward * _lunge.LungeForwardSpeed;
			}
		}

		public bool MovingForwards
		{
			get
			{
				if (IsLocalPlayer)
				{
					return Vector3.Dot(base.MoveDirection.NormalizeIgnoreY(), CachedTransform.forward) > 0.4f;
				}
				return true;
			}
		}

		private void ProcessHitboxCollision(HitboxIdentity hid)
		{
			if (IsControllable && HitboxIdentity.IsEnemy(Hub, hid.TargetHub) && hid.TargetHub.roleManager.CurrentRole is FpcStandardRoleBase fpcStandardRoleBase && !((MainModule.Position - fpcStandardRoleBase.FpcModule.Position).SqrMagnitudeIgnoreY() < 0.4f))
			{
				DetectedTargets.Add(fpcStandardRoleBase);
			}
		}

		private void ProcessWindowCollision(BreakableWindow window)
		{
			if (NetworkServer.active)
			{
				window.Damage(window.Health, new Scp939DamageHandler(_role, 120f, Scp939DamageType.LungeTarget), default);
				return;
			}
			Collider[] componentsInChildren = window.GetComponentsInChildren<Collider>();
			for (int i = 0; i < componentsInChildren.Length; i++)
			{
				componentsInChildren[i].enabled = false;
			}
		}

		private void OverlapCapsule(Vector3 point1, Vector3 point2)
		{
			int num = Physics.OverlapCapsuleNonAlloc(point1, point2, 0.6f, Detections, Mask);
			for (int i = 0; i < num; i++)
			{
				if (Detections[i].TryGetComponent<IDestructible>(out var component))
				{
					if (component is HitboxIdentity hid)
					{
						ProcessHitboxCollision(hid);
					}
					else if (component is BreakableWindow window)
					{
						ProcessWindowCollision(window);
					}
				}
			}
		}

		public override void UpdateFloating()
		{
			if (_focus.State == 1f && _lunge.State != Scp939LungeState.Triggered)
			{
				Vector3 moveDirection = base.MoveDirection;
				moveDirection.y = Mathf.Min(moveDirection.y, 0f - _lunge.LungeJumpSpeed);
				base.MoveDirection = moveDirection;
			}
			base.UpdateFloating();
		}

		public override void UpdateGrounded(ref bool sendJump, float jumpSpeed)
		{
			if (WantsToLunge)
			{
				_lunge.TriggerLunge();
				jumpSpeed = _lunge.LungeJumpSpeed;
				JumpController.WantsToJump = true;
			}
			else if (_focus.State > 0f || _cloud.TargetState)
			{
				jumpSpeed = 0f;
			}
			base.UpdateGrounded(ref sendJump, jumpSpeed);
		}

		protected override Vector3 GetFrameMove()
		{
			Vector3 frameMove = base.GetFrameMove();
			if (!IsLunging || (!NetworkServer.active && !IsLocalPlayer))
			{
				return frameMove;
			}
			DetectedTargets.Clear();
			Vector3 position = MainModule.Position;
			Vector3 vector = position + frameMove;
			Vector3 vector2 = Vector3.down * 0.6f;
			OverlapCapsule(position, vector);
			OverlapCapsule(position + vector2, vector + vector2);
			if (!IsControllable)
			{
				return frameMove;
			}
			FpcStandardRoleBase targetRole = null;
			float num = float.MaxValue;
			bool flag = false;
			foreach (FpcStandardRoleBase detectedTarget in DetectedTargets)
			{
				float sqrMagnitude = (detectedTarget.FpcModule.Position - vector).sqrMagnitude;
				if (!(sqrMagnitude >= num))
				{
					num = sqrMagnitude;
					if (!Physics.Linecast(detectedTarget.FpcModule.Position, vector, PlayerRolesUtils.AttackMask))
					{
						targetRole = detectedTarget;
						flag = true;
					}
				}
			}
			if (!flag)
			{
				return frameMove;
			}
			_lunge.ClientSendHit(targetRole);
			return _lunge.LungeJumpSpeed * Time.deltaTime * Vector3.down;
		}

		public Scp939Motor(ReferenceHub hub, Scp939Role role, FallDamageSettings fallDamageSettings)
			: base(hub, role.FpcModule, fallDamageSettings)
		{
			_role = role;
			role.SubroutineModule.TryGetSubroutine<Scp939FocusAbility>(out _focus);
			role.SubroutineModule.TryGetSubroutine<Scp939LungeAbility>(out _lunge);
			role.SubroutineModule.TryGetSubroutine<Scp939AmnesticCloudAbility>(out _cloud);
		}
	}
}
