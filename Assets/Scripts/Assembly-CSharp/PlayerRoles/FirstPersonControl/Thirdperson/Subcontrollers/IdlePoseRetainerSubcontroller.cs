using RelativePositioning;
using UnityEngine;

namespace PlayerRoles.FirstPersonControl.Thirdperson.Subcontrollers
{
	public class IdlePoseRetainerSubcontroller : SubcontrollerBehaviour, IRotationRetainer
	{
		private enum TurnStatus
		{
			Idle = 0,
			TurningRight = 1,
			TurningLeft = 2
		}

		private static readonly int TurnTriggerHash = Animator.StringToHash("StartTurn");

		private static readonly int TurnBlendHash = Animator.StringToHash("TurnDirection");

		private static readonly AnimationCurve TurningCurve = new AnimationCurve(new Keyframe(0f, 0f), new Keyframe(0.114f, 4.725f, 123.39f, 123.39f), new Keyframe(0.4377f, 65.381f, 65.75f, 65.75f), new Keyframe(0.557f, 68.14f, -2.257f, -2.257f), new Keyframe(0.7f, 66f));

		private const float TurnAngle = 66f;

		private const float FullTurnTime = 0.7f;

		private const float FastTurnTime = 0.45f;

		private const float TurnAnimCooldown = 0.3f;

		private const float UncomfortableAngle = 35f;

		private const float UncomfortableTurnDelay = 2.5f;

		private const float MaxAngularDesync = 95f;

		private const float LayerAdjustSpeed = 5f;

		private const float FullLockThreshold = 0.12f;

		private const float UnlockThreshold = 0.3f;

		private float _uncomfortableElapsed;

		private float _startTurningRotation;

		private float _targetTurningRotation;

		private float _turningElapsed;

		private float _turningAnimCooldown;

		private TurnStatus _turnStatus;

		private float _prevAngleDelta;

		private Quaternion _relativeRotation;

		private byte _lastWaypointId;

		private Transform _lastOwnerRoot;

		public float AngleDelta { get; private set; }

		public float AngleAbsDiff { get; private set; }

		public float RetentionWeight => 1f - base.Model.WalkLayerWeight;

		public bool IsTurning => _turnStatus != TurnStatus.Idle;

		private float OwnerRotation => _lastOwnerRoot.eulerAngles.y;

		private float ModelRotation
		{
			get
			{
				return WaypointBase.GetWorldRotation(_lastWaypointId, _relativeRotation).eulerAngles.y;
			}
			set
			{
				Quaternion quaternion = Quaternion.Euler(Vector3.up * value);
				WaypointBase.GetRelativeRotation(base.ModelTr.position, quaternion, out _lastWaypointId, out _relativeRotation);
				base.ModelTr.rotation = quaternion;
			}
		}

		public override void OnReassigned()
		{
			base.OnReassigned();
			_lastOwnerRoot = base.OwnerHub.transform;
		}

		public override void Init(AnimatedCharacterModel model, int index)
		{
			base.Init(model, index);
			model.OnPlayerMoved += OnPlayerMoved;
		}

		private void OnPlayerMoved()
		{
			float walkLayerWeight = base.Model.WalkLayerWeight;
			float target = Mathf.InverseLerp(0.12f, 0.3f, new Vector2(base.Model.TargetForward, base.Model.TargetStrafe).magnitude);
			walkLayerWeight = Mathf.MoveTowards(walkLayerWeight, target, base.Model.LastMovedDeltaT * 5f);
			ModelRotation = Mathf.LerpAngle(ModelRotation, OwnerRotation, walkLayerWeight);
			base.Model.WalkLayerWeight = walkLayerWeight;
		}

		private void Update()
		{
			if (base.HasOwner)
			{
				CalculateDeltas();
				ClampOwner();
				if (!IsTurning || _turningElapsed > 0.45f)
				{
					UpdateComfort();
				}
				if (IsTurning)
				{
					UpdateTurning();
				}
			}
		}

		private void CalculateDeltas()
		{
			if (_lastOwnerRoot == null)
			{
				string text = ((base.Model.LastRole as PlayerRoleBase == null) ? "Null" : (base.Model.LastRole as PlayerRoleBase).ToString());
				bool flag = base.OwnerHub == null;
				if (base.OwnerHub == null)
				{
					bool num = base.transform.TryGetComponentInParent<ReferenceHub>(out var comp);
					base.Model.OwnerHub = comp;
					if (!num)
					{
						Debug.LogError("Phoenix - Idle - unrecoverable - " + base.name);
						return;
					}
				}
				_lastOwnerRoot = base.OwnerHub.transform;
				string text2 = ((base.transform.parent == null) ? "noparent" : base.transform.parent.name);
				Debug.LogError($"Phoenix - Idle - {base.name} -1- {text} -2- {flag} -3- {base.OwnerHub} -4- {base.OwnerHub.roleManager.CurrentRole} -5- {base.Model.Pooled} -6- {base.Model.DetachedFromPool} -7- {text2}");
			}
			_prevAngleDelta = AngleDelta;
			AngleDelta = Mathf.DeltaAngle(ModelRotation, OwnerRotation);
			AngleAbsDiff = Mathf.Abs(AngleDelta);
		}

		private void ClampOwner()
		{
			float num = AngleAbsDiff - 95f;
			if (!(num <= 0f))
			{
				if (AngleDelta > 0f)
				{
					ModelRotation += num;
				}
				else
				{
					ModelRotation -= num;
				}
				CalculateDeltas();
				StartTurning();
			}
		}

		private void UpdateTurning()
		{
			if (base.Model.WalkLayerWeight > 0f)
			{
				_turnStatus = TurnStatus.Idle;
				return;
			}
			float num = Mathf.DeltaAngle(_startTurningRotation, _targetTurningRotation);
			base.Animator.SetFloat(TurnBlendHash, num / 66f);
			float num2 = _startTurningRotation;
			float num3 = _targetTurningRotation;
			if (_turnStatus == TurnStatus.TurningLeft)
			{
				for (; num2 < num3; num2 += 360f)
				{
				}
			}
			else
			{
				for (; num2 > num3; num3 += 360f)
				{
				}
			}
			_turningElapsed += Time.deltaTime;
			_turningAnimCooldown -= Time.deltaTime;
			float t = TurningCurve.Evaluate(_turningElapsed) / 66f;
			ModelRotation = Mathf.LerpUnclamped(num2, num3, t);
			if (_turningElapsed > 0.7f)
			{
				_turnStatus = TurnStatus.Idle;
			}
		}

		private void UpdateComfort()
		{
			if (AngleAbsDiff < 35f || !AngleDelta.SameSign(_prevAngleDelta))
			{
				_uncomfortableElapsed = 0f;
				return;
			}
			if (!IsTurning)
			{
				_uncomfortableElapsed += Time.deltaTime;
			}
			float num = Remap.Evaluate(35f, 66f, 2.5f, 0f, AngleAbsDiff);
			if (_uncomfortableElapsed > num)
			{
				_uncomfortableElapsed = 0f;
				StartTurning();
			}
		}

		private void StartTurning()
		{
			if (_turnStatus == TurnStatus.Idle || _turningAnimCooldown <= 0f)
			{
				_turningAnimCooldown = 0.3f;
				base.Animator.SetTrigger(TurnTriggerHash);
			}
			_turnStatus = ((AngleDelta > 0f) ? TurnStatus.TurningRight : TurnStatus.TurningLeft);
			_turningElapsed = 0f;
			_startTurningRotation = ModelRotation;
			_targetTurningRotation = OwnerRotation;
		}
	}
}
