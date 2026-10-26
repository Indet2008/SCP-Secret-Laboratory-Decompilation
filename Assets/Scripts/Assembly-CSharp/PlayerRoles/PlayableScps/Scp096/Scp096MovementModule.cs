using System.Collections.Generic;
using System.Diagnostics;
using Interactables.Interobjects;
using Mirror;
using PlayerRoles.FirstPersonControl;
using UnityEngine;

namespace PlayerRoles.PlayableScps.Scp096
{
	public class Scp096MovementModule : FirstPersonMovementModule
	{
		[SerializeField]
		private float _jumpSpeedRage;

		private const float SlowedSpeed = 3.9f;

		private const float NormalSpeed = 4.2f;

		private const float RageSpeed = 8f;

		private const float ChargeSpeed = 18.5f;

		private const float PryGateDuration = 2f;

		private const float AngleAdjustSpeed = 120f;

		private Scp096StateController _stateController;

		private float _gateLookAngle;

		private float _normalJumpSpeed;

		private readonly Stopwatch _gatePrySw = Stopwatch.StartNew();

		private readonly AnimationCurve _gatePryX = new AnimationCurve(TemplateKeyframes);

		private readonly AnimationCurve _gatePryZ = new AnimationCurve(TemplateKeyframes);

		private readonly List<Transform> _pryablePoints = new List<Transform>();

		private static readonly Keyframe[] TemplateKeyframes = new Keyframe[3]
		{
			new Keyframe(0f, 1f, 0f, 0f, 0f, 0.3f),
			new Keyframe(0.35f, 0.2f, -0f, -0f, 0.5f, 0.4f),
			new Keyframe(1f, 0f, -0f, -0f, 0.2f, 0f)
		};

		private float MovementSpeed
		{
			set
			{
				SneakSpeed = value;
				WalkSpeed = value;
				SprintSpeed = value;
			}
		}

		public override bool LockMovement
		{
			get
			{
				if (!base.Hub.isLocalPlayer)
				{
					return false;
				}
				Scp096AbilityState abilityState = _stateController.AbilityState;
				if (abilityState - 3 <= Scp096AbilityState.TryingNotToCry)
				{
					return true;
				}
				return base.LockMovement;
			}
		}

		protected override FpcMotor NewMotor => new Scp096Motor(base.Hub, base.Role as Scp096Role, FallDamageSettings);

		protected override void UpdateMovement()
		{
			UpdateSpeedAndOverrides();
			base.UpdateMovement();
		}

		private void UpdateSpeedAndOverrides()
		{
			switch (_stateController.AbilityState)
			{
			case Scp096AbilityState.Charging:
				MovementSpeed = 18.5f;
				(base.Motor as Scp096Motor).SetOverride(base.transform.forward);
				return;
			case Scp096AbilityState.PryingGate:
				MovementSpeed = 4.2f;
				UpdateGatePrying();
				return;
			}
			switch (_stateController.RageState)
			{
			case Scp096RageState.Distressed:
			case Scp096RageState.Calming:
				MovementSpeed = 3.9f;
				JumpSpeed = _normalJumpSpeed;
				break;
			case Scp096RageState.Enraged:
				MovementSpeed = 8f;
				JumpSpeed = _jumpSpeedRage;
				break;
			default:
				MovementSpeed = 4.2f;
				JumpSpeed = _normalJumpSpeed;
				break;
			}
		}

		private void UpdateGatePrying()
		{
			float num = (float)_gatePrySw.Elapsed.TotalSeconds;
			if (num > 2f)
			{
				if (NetworkServer.active)
				{
					_stateController.SetAbilityState(Scp096AbilityState.None);
				}
			}
			else if (base.Role.IsLocalPlayer)
			{
				num /= 2f;
				base.Position = new Vector3(_gatePryX.Evaluate(num), base.Position.y, _gatePryZ.Evaluate(num));
				base.MouseLook.CurrentHorizontal = Mathf.MoveTowardsAngle(base.MouseLook.CurrentHorizontal, _gateLookAngle, Time.deltaTime * 120f);
				base.MouseLook.CurrentVertical = Mathf.MoveTowardsAngle(base.MouseLook.CurrentVertical, 0f, Time.deltaTime * 120f);
			}
		}

		private void SetGatePryCurves(int index, Vector3 pos)
		{
			Keyframe[] keys = _gatePryX.keys;
			keys[index].value = pos.x;
			_gatePryX.keys = keys;
			Keyframe[] keys2 = _gatePryZ.keys;
			keys2[index].value = pos.z;
			_gatePryZ.keys = keys2;
		}

		private void Awake()
		{
			_normalJumpSpeed = JumpSpeed;
		}

		public override void SpawnObject()
		{
			base.SpawnObject();
			_stateController = (base.Role as Scp096Role).StateController;
		}

		public void SetTargetGate(PryableDoor door)
		{
			if (door.PryPositions.Length == 0)
			{
				return;
			}
			_gatePrySw.Restart();
			if (base.Role.IsLocalPlayer)
			{
				SetGatePryCurves(0, base.Position);
				_pryablePoints.Clear();
				_pryablePoints.AddRange(door.PryPositions);
				_pryablePoints.Sort((Transform x, Transform y) =>
				{
					float sqrMagnitude = (base.Position - x.position).sqrMagnitude;
					float sqrMagnitude2 = (base.Position - y.position).sqrMagnitude;
					return sqrMagnitude.CompareTo(sqrMagnitude2);
				});
				Transform transform = _pryablePoints[0];
				Transform transform2 = _pryablePoints[_pryablePoints.Count - 1];
				SetGatePryCurves(1, transform.position);
				SetGatePryCurves(2, transform2.position);
				Vector3 normalized = (transform2.position - transform.position).normalized;
				_gateLookAngle = Vector3.Angle(normalized, Vector3.forward) * Mathf.Sign(Vector3.Dot(normalized, Vector3.right));
			}
			if (NetworkServer.active)
			{
				_stateController.SetAbilityState(Scp096AbilityState.PryingGate);
			}
		}
	}
}
