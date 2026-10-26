using System;
using System.Diagnostics;
using CameraShaking;
using CustomPlayerEffects;
using LabApi.Events.Arguments.Scp939Events;
using LabApi.Events.Handlers;
using Mirror;
using PlayerRoles.Spectating;
using PlayerRoles.Subroutines;
using RelativePositioning;
using UnityEngine;

namespace PlayerRoles.PlayableScps.Scp939
{
	public class Scp939FocusAbility : StandardSubroutine<Scp939Role>, IShakeEffect
	{
		private SoundtrackMute _muteEffect;

		private Scp939FocusKeySync _keySync;

		private Scp939ClawAbility _clawAbility;

		private Scp939LungeAbility _lungeAbility;

		private Transform _ownerTransform;

		private float _state;

		private bool _targetState;

		private float _offsetMultiplier;

		private float _relativeFreezeRot;

		private byte _relativeWaypoint;

		[SerializeField]
		private float _transitionSpeed;

		[SerializeField]
		private AudioSource _focusInSource;

		[SerializeField]
		private AnimationCurve _cameraHeightOffset;

		[SerializeField]
		private AnimationCurve _cameraForwardOffset;

		[SerializeField]
		private float _cameraFov;

		private bool _hitAnimationPlaying;

		private const int RotationSpeed = 480;

		private const float RotationRestartState = 0.9f;

		private const float OffsetLerpSpeed = 15f;

		private const float CamMinRadius = 0.16f;

		private const float SourceDecaySpeed = 10f;

		private static readonly CachedLayerMask VisibilityMask = new CachedLayerMask("Default", "Glass", "CCTV", "Door");

		private readonly AbilityCooldown _serverSendCooldown = new AbilityCooldown();

		private readonly Stopwatch _frozenSw = new Stopwatch();

		private const int AngleSyncAccuracy = 64;

		private const float ResendCooldown = 1.5f;

		public float State
		{
			get
			{
				return _state;
			}
			set
			{
				value = Mathf.Clamp01(value);
				if (value != _state)
				{
					_state = value;
					OnStateChanged?.Invoke();
				}
			}
		}

		public bool TargetState
		{
			get
			{
				if (!_targetState)
				{
					return _lungeAbility.State == Scp939LungeState.Triggered;
				}
				return true;
			}
			private set
			{
				if (_targetState != value)
				{
					if (value && State == 0f)
					{
						_relativeWaypoint = CurrentWaypointId;
						_relativeFreezeRot = WaypointBase.GetRelativeRotation(_relativeWaypoint, _ownerTransform.rotation).eulerAngles.y;
						_frozenSw.Restart();
					}
					_targetState = value;
					_serverSendCooldown.Clear();
					Scp939Events.OnFocused(new Scp939FocusedEventArgs(base.Owner, value));
				}
			}
		}

		public bool IsVisuallyFocused
		{
			get
			{
				if (!base.Role.TryGetOwner(out var hub))
				{
					return false;
				}
				if (hub.playerEffectsController.GetEffect<FocusedVision>().IsEnabled)
				{
					return true;
				}
				return State >= 1f;
			}
		}

		public float FrozenTime => (float)_frozenSw.Elapsed.TotalSeconds;

		public float FrozenRotation => WaypointBase.GetWorldRotation(_relativeWaypoint, Quaternion.Euler(Vector3.up * _relativeFreezeRot)).eulerAngles.y;

		public float AngularDeviation
		{
			get
			{
				if (!(State > 0f))
				{
					return 0f;
				}
				return Mathf.DeltaAngle(FrozenRotation, _ownerTransform.eulerAngles.y);
			}
		}

		private byte CurrentWaypointId => new RelativePosition(base.CastRole.FpcModule.Position).WaypointId;

		private bool IsAvailable => base.CastRole.FpcModule.IsGrounded;

		public event Action OnStateChanged;

		private void Update()
		{
			State += Time.deltaTime * (TargetState ? _transitionSpeed : (0f - _transitionSpeed));
			if (!TargetState)
			{
				_focusInSource.volume -= Time.deltaTime * 10f;
			}
			if (NetworkServer.active)
			{
				TargetState = IsAvailable && _keySync.FocusKeyHeld && _clawAbility.Cooldown.IsReady && (_targetState || State == 0f);
				_muteEffect.IsEnabled = TargetState;
				UpdateRelativeRotation();
				if (_serverSendCooldown.IsReady)
				{
					ServerSendRpc(toAll: true);
					_serverSendCooldown.Trigger(1.5);
				}
			}
		}

		private void UpdateRelativeRotation()
		{
			if (TargetState)
			{
				byte currentWaypointId = CurrentWaypointId;
				if (currentWaypointId != _relativeWaypoint)
				{
					_relativeFreezeRot = WaypointBase.GetRelativeRotation(currentWaypointId, Quaternion.Euler(Vector3.up * FrozenRotation)).eulerAngles.y;
					_relativeWaypoint = currentWaypointId;
					_serverSendCooldown.Clear();
				}
			}
		}

		protected override void Awake()
		{
			base.Awake();
			GetSubroutine<Scp939FocusKeySync>(out _keySync);
			GetSubroutine<Scp939ClawAbility>(out _clawAbility);
			GetSubroutine<Scp939LungeAbility>(out _lungeAbility);
			_lungeAbility.OnStateChanged += (Scp939LungeState newState) =>
			{
				_hitAnimationPlaying = newState == Scp939LungeState.LandHit;
				if (newState != Scp939LungeState.None)
				{
					TargetState = false;
				}
			};
		}

		public override void ServerWriteRpc(NetworkWriter writer)
		{
			base.ServerWriteRpc(writer);
			int num = Mathf.RoundToInt(_relativeFreezeRot * 64f) + 1;
			if (!_targetState)
			{
				num *= -1;
			}
			writer.WriteShort((short)num);
			writer.WriteByte(_relativeWaypoint);
		}

		public override void ClientProcessRpc(NetworkReader reader)
		{
			base.ClientProcessRpc(reader);
			short num = reader.ReadShort();
			bool targetState = _targetState;
			_targetState = num > 0;
			_relativeWaypoint = reader.ReadByte();
			_relativeFreezeRot = ((float)Mathf.Abs(num) - 1f) / 64f;
			if (!(!_targetState | targetState))
			{
				if (_focusInSource.isPlaying)
				{
					_focusInSource.timeSamples = 0;
				}
				else
				{
					_focusInSource.Play();
				}
				_focusInSource.volume = 1f;
			}
		}

		public override void SpawnObject()
		{
			base.SpawnObject();
			_ownerTransform = base.Owner.transform;
			_offsetMultiplier = 1f;
			if (!CameraShakeController.CheckEffect(this))
			{
				CameraShakeController.AddEffect(this);
			}
			if (NetworkServer.active)
			{
				_muteEffect = base.Owner.playerEffectsController.GetEffect<SoundtrackMute>();
			}
		}

		public override void ResetObject()
		{
			base.ResetObject();
			_offsetMultiplier = 1f;
			_state = 0f;
			_targetState = false;
		}

		public bool GetEffect(ReferenceHub ply, out ShakeEffectValues shakeValues)
		{
			shakeValues = ShakeEffectValues.None;
			if (base.Role.Pooled)
			{
				return false;
			}
			if (!base.Owner.isLocalPlayer && !base.Owner.IsLocallySpectated())
			{
				return true;
			}
			if (State == 0f)
			{
				return true;
			}
			bool flag = base.Owner.isLocalPlayer && _lungeAbility.State == Scp939LungeState.Triggered;
			_offsetMultiplier = Mathf.Lerp(_offsetMultiplier, (!flag) ? 1 : 0, Time.deltaTime * 15f);
			float num = _cameraHeightOffset.Evaluate(State) * _offsetMultiplier;
			float num2 = _cameraForwardOffset.Evaluate(State) * _offsetMultiplier;
			Vector3 forward = _ownerTransform.forward;
			float num3 = (Physics.SphereCast(ply.PlayerCameraReference.position + Vector3.up * num, 0.16f, forward, out var hitInfo, 0.16f + num2, VisibilityMask) ? Mathf.Max(0f, hitInfo.distance - 0.16f) : num2);
			Vector3 value = Vector3.up * num + forward * num3;
			float num4 = Mathf.SmoothStep(1f, _cameraFov + 1f, State);
			Vector3? rootCameraPositionOffset;
			float fovPercent;
			if (!_hitAnimationPlaying || !base.Owner.isLocalPlayer)
			{
				rootCameraPositionOffset = value;
				fovPercent = num4;
				shakeValues = new ShakeEffectValues(null, null, rootCameraPositionOffset, fovPercent);
				return true;
			}
			float num5 = (0f - Time.deltaTime) * 480f;
			if (State < 0.9f)
			{
				_hitAnimationPlaying = false;
			}
			rootCameraPositionOffset = value;
			fovPercent = num4;
			float verticalLook = num5;
			shakeValues = new ShakeEffectValues(null, null, rootCameraPositionOffset, fovPercent, verticalLook);
			return true;
		}
	}
}
