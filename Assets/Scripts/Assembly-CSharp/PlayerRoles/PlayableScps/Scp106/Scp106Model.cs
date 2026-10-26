using PlayerRoles.FirstPersonControl;
using PlayerRoles.FirstPersonControl.Thirdperson;
using UnityEngine;

namespace PlayerRoles.PlayableScps.Scp106
{
	public class Scp106Model : AnimatedCharacterModel
	{
		// Client-only serialized fields restored from the v14 client layout (server build stripped them).
		[global::UnityEngine.SerializeField]
		private global::UnityEngine.Transform _balanceTransform;

		[global::UnityEngine.SerializeField]
		private global::UnityEngine.Transform _portalTransform;

		[global::UnityEngine.SerializeField]
		private global::UnityEngine.ParticleSystem _stalkParticles;

		[global::UnityEngine.SerializeField]
		private global::UnityEngine.AnimationCurve _portalScale;

		public global::UnityEngine.Transform[] VisibilityReferencePoints;


		private static readonly int SubmergeHash = Animator.StringToHash("IsSubmerged");

		private static readonly int SpeedHash = Animator.StringToHash("TransitionSpeed");

		[SerializeField]
		private AnimationCurve _submergeAnim;

		[SerializeField]
		private AnimationCurve _appearAnim;

		[SerializeField]
		private GameObject[] _hiddenObjects;

		private Transform _tr;

		private Vector3 _modelOffset;

		private Scp106SinkholeController _sinkhole;

		private Scp106StalkAbility _stalkAbility;

		private Scp106MovementModule _fpc;

		private const float DefaultEmergeAnimTime = 3.908f;

		private const float DefaultSubmergeAnimTime = 3.333f;

		public override bool FootstepPlayable
		{
			get
			{
				if (base.FpcModule.IsGrounded && base.FpcModule.Motor.MovementDetected)
				{
					return LandingFootstepPlayable;
				}
				return false;
			}
		}

		public override bool LandingFootstepPlayable => _sinkhole.SubmergeProgress == 0f;

		protected override Vector3 ModelPositionOffset => base.ModelPositionOffset + _modelOffset;

		private void LateUpdate()
		{
			if (!base.Pooled)
			{
				bool targetSubmerged = _sinkhole.TargetSubmerged;
				float targetTransitionDuration = _sinkhole.TargetTransitionDuration;
				float num = (targetSubmerged ? 3.333f : 3.908f);
				if (targetTransitionDuration > 0f)
				{
					base.Animator.SetFloat(SpeedHash, num / targetTransitionDuration);
				}
				bool isHidden = _sinkhole.IsHidden;
				GameObject[] hiddenObjects = _hiddenObjects;
				for (int i = 0; i < hiddenObjects.Length; i++)
				{
					hiddenObjects[i].SetActive(!isHidden);
				}
				if (base.IsTracked)
				{
					SetVisibility(_sinkhole.IsDuringAnimation);
				}
				base.Animator.SetBool(SubmergeHash, targetSubmerged);
				float submergeProgress = _sinkhole.SubmergeProgress;
				AnimationCurve animationCurve = (targetSubmerged ? _submergeAnim : _appearAnim);
				_modelOffset = Vector3.up * animationCurve.Evaluate(submergeProgress);
			}
		}

		protected override void Awake()
		{
			base.Awake();
			_tr = base.transform;
		}

		public override void Setup(ReferenceHub owner, IFpcRole fpc, Vector3 localPos, Quaternion localRot)
		{
			base.Setup(owner, fpc, localPos, localRot);
			Scp106Role scp106Role = base.OwnerHub.roleManager.CurrentRole as Scp106Role;
			scp106Role.SubroutineModule.TryGetSubroutine<Scp106StalkAbility>(out _stalkAbility);
			_fpc = scp106Role.FpcModule as Scp106MovementModule;
			_sinkhole = scp106Role.Sinkhole;
		}
	}
}
