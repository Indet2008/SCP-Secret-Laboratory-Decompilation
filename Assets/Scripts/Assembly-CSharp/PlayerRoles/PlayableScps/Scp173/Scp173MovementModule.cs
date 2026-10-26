using System.Diagnostics;
using Mirror;
using PlayerRoles.FirstPersonControl;
using UnityEngine;

namespace PlayerRoles.PlayableScps.Scp173
{
	public class Scp173MovementModule : FirstPersonMovementModule
	{
		private float _normalSpeed;

		private float _fastSpeed;

		private float _observerSpeed;

		private float _jumpSpeed;

		private Scp173Role _role;

		private Scp173BreakneckSpeedsAbility _breakneckSpeeds;

		private Scp173ObserversTracker _observersTracker;

		private static int _snapMask;

		private readonly Stopwatch _lookStopwatch = Stopwatch.StartNew();

		private const float ObserverSpeedMultiplier = 2f;

		private const float ServerStopTime = 0.4f;

		private const int GlassLayerMask = 16384;

		private const float GlassRaycastDis = 0.3f;

		private const float RaycastFloorHeight = 3.6f;

		private const float RaycastCeilHeight = 7.2f;

		private const float RaycastPilotRadius = 0.025f;

		private const float RaycastFloorDot = 0.15f;

		private const float RaycastCcRadiusMultiplier = 1.2f;

		private const float RaycastStabilityRadiusRatio = 0.5f;

		private const float RaycastStabilityDistance = 0.6f;

		private float MovementSpeed
		{
			set
			{
				SneakSpeed = value;
				WalkSpeed = value;
				SprintSpeed = value;
				JumpSpeed = ((value < _normalSpeed) ? 0f : _jumpSpeed);
			}
		}

		private float TargetSpeed
		{
			get
			{
				if (_observersTracker.IsObserved)
				{
					return 0f;
				}
				if (!_breakneckSpeeds.IsActive)
				{
					return _normalSpeed;
				}
				return _fastSpeed;
			}
		}

		private float ServerSpeed
		{
			get
			{
				float targetSpeed = TargetSpeed;
				if (targetSpeed > 0f)
				{
					_lookStopwatch.Restart();
					return targetSpeed;
				}
				if (!(_lookStopwatch.Elapsed.TotalSeconds < 0.4000000059604645))
				{
					return 0f;
				}
				return _normalSpeed;
			}
		}

		private static int TpMask
		{
			get
			{
				if (_snapMask != 0)
				{
					return _snapMask;
				}
				int layer = LayerMask.NameToLayer("Player");
				for (int i = 0; i < 32; i++)
				{
					if (!Physics.GetIgnoreLayerCollision(layer, i))
					{
						_snapMask |= 1 << i;
					}
				}
				return _snapMask;
			}
		}

		private void Awake()
		{
			_normalSpeed = WalkSpeed;
			_fastSpeed = SprintSpeed;
			_jumpSpeed = JumpSpeed;
			_observerSpeed = SprintSpeed * 2f;
			_role = GetComponent<Scp173Role>();
			_role.SubroutineModule.TryGetSubroutine<Scp173BreakneckSpeedsAbility>(out _breakneckSpeeds);
			_role.SubroutineModule.TryGetSubroutine<Scp173ObserversTracker>(out _observersTracker);
		}

		protected override void UpdateMovement()
		{
			MovementSpeed = (_role.IsLocalPlayer ? TargetSpeed : (NetworkServer.active ? ServerSpeed : _observerSpeed));
			base.UpdateMovement();
			UpdateGlassBreaking();
		}

		private void UpdateGlassBreaking()
		{
			if (NetworkServer.active && _breakneckSpeeds.IsActive)
			{
				Vector3 moveDirection = base.Motor.MoveDirection;
				float maxDistance = base.CharController.radius + 0.3f;
				if (Physics.Raycast(base.Position, moveDirection, out var hitInfo, maxDistance, 16384) && hitInfo.collider.TryGetComponent<BreakableWindow>(out var component))
				{
					component.Damage(component.Health, _role.DamageHandler, Vector3.zero);
				}
			}
		}

		public bool TryGetTeleportPos(float maxDis, out Vector3 pos, out float usedDistance)
		{
			Vector3 position = base.Hub.PlayerCameraReference.position;
			Vector3 forward = base.Hub.PlayerCameraReference.forward;
			if (!Physics.SphereCast(position, 0.025f, forward, out var hitInfo, maxDis, TpMask))
			{
				hitInfo.point = position + forward * maxDis;
				hitInfo.normal = Vector3.up;
				hitInfo.distance = maxDis;
			}
			usedDistance = hitInfo.distance;
			return CheckTeleportPosition(hitInfo, out pos);
		}

		private bool CheckTeleportPosition(RaycastHit hit, out Vector3 groundPoint)
		{
			groundPoint = Vector3.zero;
			float radius = CharacterControllerSettings.Radius;
			float num = radius * 1.2f;
			Vector3 vector = hit.point + hit.normal * num;
			if (Physics.CheckSphere(vector, radius, TpMask))
			{
				return false;
			}
			if (Physics.Raycast(hit.point, hit.normal, num, TpMask))
			{
				return false;
			}
			if (!Physics.SphereCast(vector, radius, Vector3.down, out var hitInfo, 3.6f, TpMask))
			{
				return false;
			}
			if (!Physics.SphereCast(new Ray(vector, Vector3.down), radius * 0.5f, hitInfo.distance + 0.6f, TpMask))
			{
				return false;
			}
			if (Vector3.Dot(Vector3.up, hitInfo.normal) < 0.15f)
			{
				return false;
			}
			if (!Physics.SphereCast(vector, radius, Vector3.up, out var hitInfo2, 7.2f, TpMask))
			{
				hitInfo2.point = vector + Vector3.up * 7.2f;
			}
			if (Mathf.Abs(hitInfo.point.y - hitInfo2.point.y) < CharacterControllerSettings.Height)
			{
				return false;
			}
			if (hitInfo.collider.TryGetComponent<PitKiller>(out var _))
			{
				return false;
			}
			groundPoint = hitInfo.point + (hitInfo.normal + Vector3.down) * radius;
			return true;
		}

		public void ServerTeleportTo(Vector3 pos)
		{
			if (NetworkServer.active)
			{
				ServerOverridePosition(pos);
			}
		}
	}
}
