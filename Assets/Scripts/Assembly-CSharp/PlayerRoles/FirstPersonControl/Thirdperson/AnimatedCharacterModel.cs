using System;
using System.Collections.Generic;
using System.Diagnostics;
using System.Linq;
using AnimatorLayerManagement;
using AudioPooling;
using CameraShaking;
using CustomPlayerEffects;
using PlayerRoles.FirstPersonControl.Thirdperson.Subcontrollers;
using PlayerRoles.Spectating;
using UnityEngine;

namespace PlayerRoles.FirstPersonControl.Thirdperson
{
	public class AnimatedCharacterModel : CharacterModel, IAnimatorLayerSource
	{
		private enum FootstepLoudness
		{
			Civilian = 8,
			FoundationForces = 12,
			Chaos = 30,
			Scp = 35
		}

		public static Action<AnimatedCharacterModel, float> OnFootstepPlayed;

		private static readonly int HashForward = Animator.StringToHash("Forward");

		private static readonly int HashGrounded = Animator.StringToHash("Grounded");

		private static readonly int HashStrafe = Animator.StringToHash("Strafe");

		private static readonly int HashSpeed = Animator.StringToHash("Speed");

		private readonly Stopwatch _lastTouchdownSw = Stopwatch.StartNew();

		private readonly Stopwatch _lastMovedSw = Stopwatch.StartNew();

		private int _lastFootstep;

		private bool _forceUpdate;

		private float _lastMovedDeltaT;

		private IAnimatedModelSubcontroller[] _subcontrollers;

		private HashSet<int> _allParameterHashes;

		private float? _lastAppliedWalkLayerWeight;

		private const float SilentVelocityMultiplier = 0.7f;

		private const float SprintingLoudnessMultiplier = 2f;

		private const float MinimalFootstepSoundCooldown = 0.2f;

		private const float SpawnGroundedSuppression = 0.3f;

		private const float TimeSkipOnSetupSeconds = 10f;

		[Header("Animation settings")]
		[SerializeField]
		private float _firstpersonDampTime;

		[SerializeField]
		private float _thirdpersonDampTime;

		[SerializeField]
		private LayerRefId _walkLayer;

		[SerializeField]
		private AnimationCurve _walkVelocityScale;

		[Header("Footsteps")]
		[SerializeField]
		private AudioClip[] _footstepClips;

		[Range(0f, 1f)]
		[SerializeField]
		private float[] _footstepTimes;

		[SerializeField]
		private FootstepLoudness _footstepLoudness;

		public ModelSharedSettings SharedSettings;

		public AudioClip RandomFootstep => _footstepClips.RandomItem();

		public Vector3 HeadBobPosition { get; protected set; }

		public virtual bool ApplyHeadBobbingShake
		{
			get
			{
				if (IsTracked)
				{
					return (object)FpcModule.CharacterModelInstance == this;
				}
				return false;
			}
		}

		public bool IsTracked
		{
			get
			{
				if (!base.Pooled)
				{
					if (!base.OwnerHub.isLocalPlayer)
					{
						return base.OwnerHub.IsLocallySpectated();
					}
					return true;
				}
				return false;
			}
		}

		public float LastMovedDeltaT
		{
			get
			{
				if (!base.HasOwner)
				{
					return Time.deltaTime;
				}
				return _lastMovedDeltaT;
			}
		}

		internal Animator Animator { get; private set; }

		public AnimatorLayerManager LayerManager { get; private set; }

		internal AnimatorOverrideController AnimatorOverride { get; private set; }

		protected FirstPersonMovementModule FpcModule { get; private set; }

		protected PlayerRoleBase Role { get; private set; }

		public virtual float FootstepLoudnessDistance
		{
			get
			{
				float num = (float)_footstepLoudness;
				if (FpcModule.CurrentMovementState == PlayerMovementState.Sprinting)
				{
					num *= 2f;
				}
				return num;
			}
		}

		public virtual bool FootstepPlayable
		{
			get
			{
				if (!FpcModule.IsGrounded || !FpcModule.Motor.MovementDetected)
				{
					return false;
				}
				float num = FpcModule.VelocityForState(PlayerMovementState.Sneaking, applyCrouch: false);
				float maxMovementSpeed = FpcModule.MaxMovementSpeed;
				if (maxMovementSpeed <= num && maxMovementSpeed > 0f)
				{
					return false;
				}
				num *= 0.7f;
				return FpcModule.Motor.Velocity.SqrMagnitudeIgnoreY() >= num * num;
			}
		}

		public virtual bool LandingFootstepPlayable => true;

		public float WalkCycle
		{
			get
			{
				float walkCycleRaw = WalkCycleRaw;
				if (!float.IsNaN(walkCycleRaw))
				{
					return walkCycleRaw - (float)(int)walkCycleRaw;
				}
				return 0f;
			}
		}

		public float WalkCycleRaw => Animator.GetCurrentAnimatorStateInfo(WalkLayerIndex).normalizedTime;

		public float WalkLayerWeight
		{
			get
			{
				float valueOrDefault = _lastAppliedWalkLayerWeight.GetValueOrDefault();
				if (!_lastAppliedWalkLayerWeight.HasValue)
				{
					valueOrDefault = LayerManager.GetLayerWeight(_walkLayer);
					_lastAppliedWalkLayerWeight = valueOrDefault;
				}
				return _lastAppliedWalkLayerWeight.Value;
			}
			set
			{
				float num = Mathf.Clamp01(value);
				LayerManager.SetLayerWeight(_walkLayer, num);
				_lastAppliedWalkLayerWeight = num;
			}
		}

		public ReadOnlySpan<IAnimatedModelSubcontroller> AllSubcontrollers => new ReadOnlySpan<IAnimatedModelSubcontroller>(_subcontrollers);

		public float CurrentStafe => Animator.GetFloat(HashStrafe);

		public float CurrentForward => Animator.GetFloat(HashForward);

		public float TargetStrafe { get; private set; }

		public float TargetForward { get; private set; }

		public RuntimeAnimatorController AnimLayersSource => GetComponentInChildren<Animator>().runtimeAnimatorController;

		private int WalkLayerIndex => LayerManager.GetLayerIndex(_walkLayer);

		public event Action<PooledAudioSource> OnFootstepAudioSpawned;

		protected override void Awake()
		{
			base.Awake();
			Animator = SetupAnimator();
			LayerManager = Animator.GetComponent<AnimatorLayerManager>();
			_allParameterHashes = new HashSet<int>(Animator.parameters.Select((AnimatorControllerParameter x) => x.nameHash));
			_subcontrollers = GetComponents<IAnimatedModelSubcontroller>();
			for (int num = 0; num < _subcontrollers.Length; num++)
			{
				_subcontrollers[num].Init(this, num);
			}
		}

		protected virtual void Update()
		{
			if (!base.Pooled)
			{
				float dampTime = (base.OwnerHub.isLocalPlayer ? _firstpersonDampTime : _thirdpersonDampTime);
				float num = WalkCycleRaw;
				if (float.IsNaN(num))
				{
					num = 0f;
				}
				Vector2 movementDirection;
				float normalizedVelocity;
				if (!FpcModule.IsGrounded)
				{
					movementDirection = Vector2.zero;
					normalizedVelocity = 0f;
				}
				else
				{
					Vector3 vector = base.CachedTransform.InverseTransformDirection(FpcModule.Motor.Velocity);
					Vector2 vector2 = new Vector2(vector.x, vector.z);
					float magnitude = vector2.magnitude;
					movementDirection = ((magnitude <= float.Epsilon) ? Vector2.zero : (vector2 / magnitude));
					float walkSpeed = FpcModule.WalkSpeed;
					normalizedVelocity = ((walkSpeed == 0f) ? 1f : (magnitude / walkSpeed));
				}
				UpdateHeadBob(num);
				UpdateFootsteps(num);
				UpdateAnimatorParameters(movementDirection, normalizedVelocity, dampTime);
				if (HasParameter(HashGrounded))
				{
					bool value = FpcModule.Noclip.IsActive || Role.ActiveTime < 0.3f || FpcModule.IsGrounded;
					Animator.SetBool(HashGrounded, value);
				}
			}
		}

		public override void OnPlayerMove()
		{
			float a = (float)_lastMovedSw.Elapsed.TotalSeconds;
			_lastMovedSw.Restart();
			_lastMovedDeltaT = Mathf.Min(a, Time.maximumDeltaTime);
			base.OnPlayerMove();
		}

		protected virtual Animator SetupAnimator()
		{
			Animator componentInChildren = GetComponentInChildren<Animator>();
			AnimatorOverride = new AnimatorOverrideController(componentInChildren.runtimeAnimatorController);
			componentInChildren.runtimeAnimatorController = AnimatorOverride;
			return componentInChildren;
		}

		protected virtual PooledAudioSource PlayFootstepAudioClip(AudioClip clip, float dis, float vol)
		{
			return AudioSourcePoolManager.PlayOnTransform(RandomFootstep, base.transform, dis, vol, FalloffType.Footstep);
		}

		private void UpdateHeadBob(float time)
		{
			if (!base.Pooled && (base.OwnerHub.isLocalPlayer || base.OwnerHub.IsLocallySpectated()))
			{
				Vector2 animDirection = new Vector2(Animator.GetFloat(HashStrafe), Animator.GetFloat(HashForward));
				HeadBobPosition = SharedSettings.GetHeadBob(time, animDirection);
			}
		}

		private void UpdateFootsteps(float time)
		{
			time -= (float)(int)time;
			int num = _footstepTimes.Length;
			if (_lastFootstep < num)
			{
				if (!(time < _footstepTimes[_lastFootstep]))
				{
					_lastFootstep++;
					if (FootstepPlayable)
					{
						PlayFootstep();
					}
				}
			}
			else if (num > 0 && time < _footstepTimes[0])
			{
				_lastFootstep = 0;
			}
		}

		private void OnGrounded()
		{
			if (!(base.OwnerHub.roleManager.CurrentRole.ActiveTime < 0.3f) && LandingFootstepPlayable)
			{
				PlayFootstep();
				_lastTouchdownSw.Restart();
				if (IsTracked)
				{
					SharedSettings.PlayLandingAnimation();
				}
			}
		}

		private void PlayFootstep()
		{
			float footstepLoudnessDistance = FootstepLoudnessDistance;
			float num = 1f;
			bool flag = true;
			PlayerEffectsController playerEffectsController = base.OwnerHub.playerEffectsController;
			int num2 = playerEffectsController.AllEffects.Length;
			for (int i = 0; i < num2; i++)
			{
				if (playerEffectsController.AllEffects[i].IsEnabled && playerEffectsController.AllEffects[i] is IFootstepEffect footstepEffect)
				{
					float num3 = footstepEffect.ProcessFootstepOverrides(this, footstepLoudnessDistance);
					if (num3 >= 0f)
					{
						flag = false;
					}
					num = Mathf.Min(num, num3);
				}
			}
			if (!flag || num >= 0f)
			{
				if (num > 0f && _footstepClips != null && _footstepClips.Length > 0)
				{
					PooledAudioSource source = PlayFootstepAudioClip(RandomFootstep, footstepLoudnessDistance, num);
					OnFootstepAudioSpawned?.Invoke(source);
				}
				OnFootstepPlayed?.Invoke(this, footstepLoudnessDistance);
			}
		}

		public bool HasParameter(int hash)
		{
			return _allParameterHashes.Contains(hash);
		}

		public bool TryGetSubcontroller<T>(out T subcontroller) where T : class
		{
			IAnimatedModelSubcontroller[] subcontrollers = _subcontrollers;
			for (int i = 0; i < subcontrollers.Length; i++)
			{
				if (subcontrollers[i] is T val)
				{
					subcontroller = val;
					return true;
				}
			}
			subcontroller = null;
			return false;
		}

		public virtual void UpdateAnimatorParameters(Vector2 movementDirection, float normalizedVelocity, float dampTime)
		{
			float value = _walkVelocityScale.Evaluate(normalizedVelocity);
			movementDirection *= normalizedVelocity;
			TargetStrafe = movementDirection.x;
			TargetForward = movementDirection.y;
			if (_forceUpdate)
			{
				Animator.SetFloat(HashForward, TargetForward);
				Animator.SetFloat(HashStrafe, TargetStrafe);
				Animator.SetFloat(HashSpeed, value);
			}
			else
			{
				Animator.SetFloat(HashForward, TargetForward, dampTime, Time.deltaTime);
				Animator.SetFloat(HashStrafe, TargetStrafe, dampTime, Time.deltaTime);
				Animator.SetFloat(HashSpeed, value, dampTime, Time.deltaTime);
			}
		}

		public virtual void ForceUpdate()
		{
			_forceUpdate = true;
			Update();
			_forceUpdate = false;
		}

		public override void ResetObject()
		{
			base.ResetObject();
			FirstPersonMovementModule fpcModule = FpcModule;
			fpcModule.OnGrounded = (Action)Delegate.Remove(fpcModule.OnGrounded, new Action(OnGrounded));
		}

		public override void Setup(ReferenceHub owner, IFpcRole role, Vector3 localPos, Quaternion localRot)
		{
			base.Setup(owner, role, localPos, localRot);
			Role = role as PlayerRoleBase;
			FpcModule = role.FpcModule;
			FirstPersonMovementModule fpcModule = FpcModule;
			fpcModule.OnGrounded = (Action)Delegate.Combine(fpcModule.OnGrounded, new Action(OnGrounded));
			Animator.Rebind();
			Animator.Update(10f);
			HitboxIdentity[] hitboxes = base.Hitboxes;
			foreach (HitboxIdentity hitboxIdentity in hitboxes)
			{
				HitboxIdentity.Instances.Add(hitboxIdentity);
				hitboxIdentity.SetColliders(!base.OwnerHub.isLocalPlayer);
			}
			IAnimatedModelSubcontroller[] subcontrollers = _subcontrollers;
			for (int i = 0; i < subcontrollers.Length; i++)
			{
				subcontrollers[i].OnReassigned();
			}
			if (ApplyHeadBobbingShake)
			{
				CameraShakeController.AddEffect(new HeadbobShake(this));
			}
		}

		public override void SetAsOwnerless()
		{
			base.SetAsOwnerless();
			Awake();
		}
	}
}
