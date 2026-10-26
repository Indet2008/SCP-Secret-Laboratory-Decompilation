using System.Diagnostics;
using AudioPooling;
using CustomPlayerEffects;
using Mirror;
using PlayerRoles.FirstPersonControl;
using PlayerRoles.FirstPersonControl.Thirdperson;
using PlayerRoles.PlayableScps.Subroutines;
using PlayerRoles.Spectating;
using UnityEngine;

namespace PlayerRoles.PlayableScps.Scp939
{
	public class Scp939Model : AnimatedCharacterModel
	{
		[SerializeField]
		private Animator _animator;

		[SerializeField]
		private AnimationCurve _focusOverrideAnim;

		[SerializeField]
		private AnimationCurve _tiltOverTime;

		[SerializeField]
		private AnimationCurve _focusParamsCorrectionCurve;

		[SerializeField]
		private AudioClip[] _damagedVariants;

		[SerializeField]
		private AudioClip _cloudPlaceSound;

		[SerializeField]
		private float _tiltLerp;

		[SerializeField]
		private float _fadeSpeed;

		[SerializeField]
		private Vector2 _footstepPitchRand;

		[SerializeField]
		private float _amnesiaVisibleRange;

		private Scp939Role _scp939;

		private Scp939ClawAbility _clawAbility;

		private Scp939FocusAbility _focusAbility;

		private Scp939LungeAbility _lungeAbility;

		private Scp939AmnesticCloudAbility _amnesticAbility;

		private Transform _trModel;

		private Transform _trHub;

		private bool _prevFocus;

		private bool _isLunging;

		private float _curTilt;

		private readonly Stopwatch _lungeStopwatch = new Stopwatch();

		private readonly Stopwatch _fadeoutStopwatch = Stopwatch.StartNew();

		private const int FocusOverrideLayer = 4;

		private const int FocusHeadDirLayer = 6;

		private const float FocusHeadFadeTime = 0.4f;

		private const float FocusRotateRate = 3f;

		private const float LungeRotateSpeed = 7.5f;

		private const float DamagedSoundRange = 19f;

		private const float CloudSoundRange = 8f;

		private const float HiddenHeight = -3000f;

		private const float FullVisCooldown = 30f;

		private static readonly int GroundedHash = Animator.StringToHash("IsGrounded");

		private static readonly int ClawHash = Animator.StringToHash("Claw");

		private static readonly int FocusStateHash = Animator.StringToHash("Focus");

		private static readonly int FocusHeadDirHash = Animator.StringToHash("FocusDirection");

		private static readonly int LungeStateHash = Animator.StringToHash("LungeState");

		private static readonly int LungeTriggerHash = Animator.StringToHash("LungeTrigger");

		private static readonly int DamagedVariantHash = Animator.StringToHash("DamagedVariant");

		private static readonly int DamagedTriggerHash = Animator.StringToHash("DamagedTrigger");

		private static readonly int AmnesticChargingHash = Animator.StringToHash("AmnesticCharging");

		private static readonly int AmnesticTriggerHash = Animator.StringToHash("AmnesticCreated");

		private bool Visible
		{
			get
			{
				if (!ReferenceHub.TryGetPovHub(out var hub))
				{
					return true;
				}
				if (!HitboxIdentity.IsEnemy(base.OwnerHub, hub))
				{
					return true;
				}
				if (!(hub.roleManager.CurrentRole is IFpcRole fpcRole))
				{
					return true;
				}
				Vector3 position = fpcRole.FpcModule.Position;
				if (Vector3.Distance(position, _scp939.FpcModule.Position) < _amnesiaVisibleRange)
				{
					return true;
				}
				if (!hub.playerEffectsController.TryGetEffect<AmnesiaVision>(out var playerEffect))
				{
					return true;
				}
				if (playerEffect.IsEnabled)
				{
					return false;
				}
				if (playerEffect.LastActive < 30f)
				{
					return true;
				}
				foreach (Scp939AmnesticCloudInstance activeInstance in Scp939AmnesticCloudInstance.ActiveInstances)
				{
					if (activeInstance.IsInArea(activeInstance.SourcePosition, position))
					{
						return false;
					}
				}
				return true;
			}
		}

		public override bool FootstepPlayable
		{
			get
			{
				if (base.FootstepPlayable)
				{
					return base.FpcModule.CurrentMovementState == PlayerMovementState.Sprinting;
				}
				return false;
			}
		}

		public bool IsInHiddenPosition => base.FpcModule.Position == Vector3.up * -3000f;

		private void PlayClawAttack(AttackResult attackRes)
		{
			if (attackRes != AttackResult.None)
			{
				_animator.SetTrigger(ClawHash);
			}
		}

		private void ProcessLungeState(Scp939LungeState newState)
		{
			switch (newState)
			{
			case Scp939LungeState.Triggered:
				_lungeStopwatch.Restart();
				break;
			case Scp939LungeState.None:
				_isLunging = false;
				return;
			}
			_isLunging = true;
			_animator.SetInteger(LungeStateHash, (int)newState);
			_animator.SetTrigger(LungeTriggerHash);
		}

		private void OnSpectatorTargetChanged()
		{
			ForceFade(1f);
		}

		private void UpdateFade()
		{
			ForceFade(_fadeSpeed * Time.deltaTime);
		}

		private void ForceFade(float delta)
		{
			Fade += (Visible ? delta : (0f - delta));
			if (!(Fade > 0f) && !base.Role.IsLocalPlayer && !NetworkServer.active)
			{
				_fadeoutStopwatch.Restart();
				base.FpcModule.Position = Vector3.up * -3000f;
			}
		}

		protected override void Awake()
		{
			base.Awake();
			_trModel = base.transform;
		}

		protected override void Update()
		{
			base.Update();
			base.Animator.SetBool(GroundedHash, base.FpcModule.IsGrounded);
			base.Animator.SetBool(AmnesticChargingHash, _amnesticAbility.TargetState);
			float state = _focusAbility.State;
			base.Animator.SetFloat(FocusStateHash, state);
			base.Animator.SetLayerWeight(6, state);
			if (_isLunging)
			{
				base.Animator.SetLayerWeight(4, 1f);
			}
			else
			{
				base.Animator.SetLayerWeight(4, _focusOverrideAnim.Evaluate(state));
			}
		}

		public void PlayDamagedEffect(int rand)
		{
			rand %= _damagedVariants.Length;
			_animator.SetFloat(DamagedVariantHash, rand);
			_animator.SetTrigger(DamagedTriggerHash);
			AudioSourcePoolManager.PlayOnTransform(_damagedVariants[rand], base.transform, 19f, 1f, FalloffType.Exponential, MixerChannel.NoDucking);
		}

		public void PlayCloudRelease()
		{
			_animator.SetTrigger(AmnesticTriggerHash);
			AudioSourcePoolManager.PlayOnTransform(_cloudPlaceSound, base.transform, 8f);
		}

		public override void UpdateAnimatorParameters(Vector2 movementDirection, float normalizedVelocity, float dampTime)
		{
			if (_focusAbility.State > 0f)
			{
				float b = _focusParamsCorrectionCurve.Evaluate(_focusAbility.State);
				float f = Vector3.Dot(movementDirection.normalized, Vector2.up);
				normalizedVelocity *= Mathf.Lerp(1f, b, Mathf.Abs(f));
			}
			base.UpdateAnimatorParameters(movementDirection, normalizedVelocity, dampTime);
		}

		private void LateUpdate()
		{
			float t = Time.deltaTime * _tiltLerp;
			if (_lungeAbility.State == Scp939LungeState.Triggered)
			{
				double totalSeconds = _lungeStopwatch.Elapsed.TotalSeconds;
				float b = _tiltOverTime.Evaluate((float)totalSeconds);
				_curTilt = Mathf.Lerp(_curTilt, b, t);
			}
			else
			{
				_curTilt = Mathf.Lerp(_curTilt, 0f, t);
			}
			if (_focusAbility.State == 0f)
			{
				if (_prevFocus)
				{
					_trModel.localRotation = Quaternion.identity;
					_prevFocus = false;
				}
				return;
			}
			if (!_prevFocus)
			{
				_prevFocus = true;
				return;
			}
			float t2;
			if (_isLunging)
			{
				double totalSeconds2 = _lungeStopwatch.Elapsed.TotalSeconds;
				t2 = 1f - (float)totalSeconds2 * 7.5f;
			}
			else
			{
				t2 = _focusAbility.State * 3f;
			}
			Quaternion b2 = Quaternion.Euler(0f, _focusAbility.FrozenRotation, 0f);
			_trModel.rotation = Quaternion.Slerp(_trHub.rotation, b2, t2);
			_trModel.Rotate(Vector3.right, _curTilt, Space.Self);
			float value = Mathf.DeltaAngle(_trHub.eulerAngles.y, _trModel.eulerAngles.y);
			base.Animator.SetFloat(FocusHeadDirHash, value, 0.4f, Time.deltaTime);
		}

		protected override Animator SetupAnimator()
		{
			return _animator;
		}

		protected override PooledAudioSource PlayFootstepAudioClip(AudioClip clip, float dis, float vol)
		{
			PooledAudioSource pooledAudioSource = base.PlayFootstepAudioClip(clip, dis, vol);
			pooledAudioSource.Source.pitch = Random.Range(_footstepPitchRand.x, _footstepPitchRand.y);
			return pooledAudioSource;
		}

		public override void Setup(ReferenceHub owner, IFpcRole role, Vector3 localPos, Quaternion localRot)
		{
			base.Setup(owner, role, localPos, localRot);
			_trHub = base.OwnerHub.transform;
			_scp939 = base.OwnerHub.roleManager.CurrentRole as Scp939Role;
			_scp939.SubroutineModule.TryGetSubroutine<Scp939ClawAbility>(out _clawAbility);
			_scp939.SubroutineModule.TryGetSubroutine<Scp939FocusAbility>(out _focusAbility);
			_scp939.SubroutineModule.TryGetSubroutine<Scp939LungeAbility>(out _lungeAbility);
			_scp939.SubroutineModule.TryGetSubroutine<Scp939AmnesticCloudAbility>(out _amnesticAbility);
			_clawAbility.OnAttacked += PlayClawAttack;
			_lungeAbility.OnStateChanged += ProcessLungeState;
			FirstPersonMovementModule.OnPositionUpdated += UpdateFade;
			SpectatorTargetTracker.OnTargetChanged += OnSpectatorTargetChanged;
		}

		public override void ResetObject()
		{
			base.ResetObject();
			_clawAbility.OnAttacked -= PlayClawAttack;
			_lungeAbility.OnStateChanged -= ProcessLungeState;
			_curTilt = 0f;
			_prevFocus = false;
			_isLunging = false;
			FirstPersonMovementModule.OnPositionUpdated -= UpdateFade;
			SpectatorTargetTracker.OnTargetChanged -= OnSpectatorTargetChanged;
		}
	}
}
