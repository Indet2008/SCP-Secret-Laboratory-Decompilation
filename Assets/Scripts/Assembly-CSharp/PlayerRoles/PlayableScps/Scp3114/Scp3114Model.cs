using System;
using AnimatorLayerManagement;
using PlayerRoles.FirstPersonControl;
using PlayerRoles.FirstPersonControl.Thirdperson;
using PlayerRoles.FirstPersonControl.Thirdperson.Subcontrollers;
using UnityEngine;

namespace PlayerRoles.PlayableScps.Scp3114
{
	public class Scp3114Model : AnimatedCharacterModel, ISubcontrollerRpcRedirector
	{
		[Serializable]
		public struct HumanoidBone
		{
			public HumanBodyBones BoneType;

			public Transform Transform;
		}

		private static readonly int HashStrangling = Animator.StringToHash("Strangling");

		private static readonly int HashDanceVariant = Animator.StringToHash("DanceVariant");

		private static readonly int HashSlapTrigger = Animator.StringToHash("SlapTrigger");

		private static readonly int HashSlapMirror = Animator.StringToHash("MirrorSlap");

		private static readonly int HashStealing = Animator.StringToHash("Stealing");

		private static readonly int HashReveal = Animator.StringToHash("Reveal");

		private Scp3114Strangle _strangle;

		private Scp3114Slap _slap;

		private Scp3114Dance _dance;

		private Scp3114FakeModelManager _fakeModel;

		private bool _hadIdentity;

		[SerializeField]
		private LayerRefId _strangleLayer;

		[SerializeField]
		private LayerRefId _danceLayer;

		[SerializeField]
		private float _layerWeightAdjustSpeed;

		[SerializeField]
		private ParticleSystem _revealParticles;

		[SerializeField]
		private GameObject _skeletonFormItemRoot;

		[field: SerializeField]
		public HumanoidBone[] HumanoidBones { get; private set; }

		public override bool FootstepPlayable
		{
			get
			{
				if (base.FootstepPlayable)
				{
					return ScpRole.SkeletonIdle;
				}
				return false;
			}
		}

		public override bool LandingFootstepPlayable
		{
			get
			{
				if (base.LandingFootstepPlayable)
				{
					return ScpRole.SkeletonIdle;
				}
				return false;
			}
		}

		public AnimatedCharacterModel RpcTarget => _fakeModel.RpcTarget;

		private Scp3114Role ScpRole => base.Role as Scp3114Role;

		public override void Setup(ReferenceHub owner, IFpcRole role, Vector3 localPos, Quaternion localRot)
		{
			base.Setup(owner, role, localPos, localRot);
			ScpRole.SubroutineModule.TryGetSubroutine<Scp3114FakeModelManager>(out _fakeModel);
			ScpRole.SubroutineModule.TryGetSubroutine<Scp3114Strangle>(out _strangle);
			ScpRole.SubroutineModule.TryGetSubroutine<Scp3114Dance>(out _dance);
			ScpRole.SubroutineModule.TryGetSubroutine<Scp3114Slap>(out _slap);
			_slap.OnTriggered += OnSlapTriggered;
			ScpRole.CurIdentity.OnStatusChanged += OnIdentityChanged;
		}

		public override void OnPlayerMove()
		{
			base.OnPlayerMove();
			_fakeModel.OnPlayerMove();
		}

		public override void ResetObject()
		{
			base.ResetObject();
			_hadIdentity = false;
			_slap.OnTriggered -= OnSlapTriggered;
			ScpRole.CurIdentity.OnStatusChanged -= OnIdentityChanged;
		}

		protected override void Update()
		{
			base.Update();
			if (!base.Pooled)
			{
				bool hasValue = _strangle.SyncTarget.HasValue;
				base.Animator.SetBool(HashStrangling, hasValue);
				base.Animator.SetFloat(HashDanceVariant, _dance.DanceVariant);
				base.Animator.SetBool(HashStealing, ScpRole.CurIdentity.Status == Scp3114Identity.DisguiseStatus.Equipping);
				AdjustWeight(_strangleLayer, hasValue);
				AdjustWeight(_danceLayer, _dance.IsDancing);
			}
		}

		private void AdjustWeight(LayerRefId layerId, bool isActive)
		{
			int layerIndex = base.LayerManager.GetLayerIndex(layerId);
			float layerWeight = base.Animator.GetLayerWeight(layerIndex);
			float num = Time.deltaTime * _layerWeightAdjustSpeed;
			float value = (isActive ? (layerWeight + num) : (layerWeight - num));
			base.Animator.SetLayerWeight(layerIndex, Mathf.Clamp01(value));
		}

		private void OnIdentityChanged()
		{
			_skeletonFormItemRoot.SetActive(ScpRole.SkeletonIdle);
			switch (ScpRole.CurIdentity.Status)
			{
			case Scp3114Identity.DisguiseStatus.Active:
				_hadIdentity = true;
				break;
			case Scp3114Identity.DisguiseStatus.None:
				if (_hadIdentity)
				{
					_hadIdentity = false;
					_revealParticles.Play(withChildren: true);
					base.Animator.SetTrigger(HashReveal);
				}
				break;
			}
		}

		private void OnSlapTriggered()
		{
			base.Animator.SetBool(HashSlapMirror, !base.Animator.GetBool(HashSlapMirror));
			base.Animator.SetTrigger(HashSlapTrigger);
		}
	}
}
