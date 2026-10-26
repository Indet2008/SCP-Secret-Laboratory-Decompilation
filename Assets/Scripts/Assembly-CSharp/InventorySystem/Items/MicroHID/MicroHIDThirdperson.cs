using AnimatorLayerManagement;
using InventorySystem.Items.MicroHID.Modules;
using InventorySystem.Items.Thirdperson;
using InventorySystem.Items.Thirdperson.LayerProcessors;
using PlayerRoles.FirstPersonControl.Thirdperson.Subcontrollers;
using UnityEngine;

namespace InventorySystem.Items.MicroHID
{
	public class MicroHIDThirdperson : ThirdpersonItemBase, ILookatModifier
	{
		[SerializeField]
		private MicroHIDParticles _particles;

		[SerializeField]
		private LayerProcessorBase _idleLayerProcessor;

		[SerializeField]
		private LayerProcessorBase _aimLayerProcessor;

		[SerializeField]
		private AnimationClip _animIdle;

		[SerializeField]
		private AnimationClip _animWindup;

		[SerializeField]
		private AnimationClip _animWinddown;

		[SerializeField]
		private AnimationClip _animShoot;

		[SerializeField]
		private Transform _leftHandIkTarget;

		[SerializeField]
		private LayerRefId _leftHandIkLayer;

		[SerializeField]
		private float _minWindupTime;

		[SerializeField]
		private float _blendDecayLerpSpeed;

		private float _windupElapsed;

		private MicroHidPhase _prevPhase;

		private CycleController _cycle;

		private float _lastWindupProgress;

		private const float WindingBlend = 1f;

		private const float ShootingBlend = 2f;

		private ushort Serial => base.ItemId.SerialNumber;

		internal override void Initialize(InventorySubcontroller subcontroller, ItemIdentifier id)
		{
			base.Initialize(subcontroller, id);
			SetAnim(AnimState3p.Override0, _animIdle);
			SetAnim(AnimState3p.Override1, _animWindup);
			SetAnim(AnimState3p.Override2, _animShoot);
			_prevPhase = MicroHidPhase.Standby;
			_cycle = CycleSyncModule.GetCycleController(Serial);
			_particles.Init(Serial, base.OwnerHub.PlayerCameraReference);
		}

		internal override void OnAnimIK(int layerIndex, float ikScale)
		{
			base.OnAnimIK(layerIndex, ikScale);
			AnimatorLayerManager layerManager = base.TargetModel.LayerManager;
			if (layerIndex == layerManager.GetLayerIndex(_leftHandIkLayer))
			{
				Animator animator = base.TargetModel.Animator;
				_leftHandIkTarget.GetPositionAndRotation(out var position, out var rotation);
				animator.SetIKPosition(AvatarIKGoal.LeftHand, position);
				animator.SetIKPositionWeight(AvatarIKGoal.LeftHand, 1f);
				animator.SetIKRotation(AvatarIKGoal.LeftHand, rotation);
				animator.SetIKRotationWeight(AvatarIKGoal.LeftHand, 1f);
			}
		}

		public override ThirdpersonLayerWeight GetWeightForLayer(AnimItemLayer3p layer)
		{
			ThirdpersonLayerWeight weightForLayer = _idleLayerProcessor.GetWeightForLayer(this, layer);
			ThirdpersonLayerWeight weightForLayer2 = _aimLayerProcessor.GetWeightForLayer(this, layer);
			return ThirdpersonLayerWeight.Lerp(weightForLayer, weightForLayer2, _lastWindupProgress);
		}

		protected override void Update()
		{
			base.Update();
			_lastWindupProgress = WindupSyncModule.GetProgress(Serial);
			base.OverrideBlend = Mathf.Lerp(base.OverrideBlend, 0f, Time.deltaTime * _blendDecayLerpSpeed);
			UpdatePhase();
			_prevPhase = _cycle.Phase;
		}

		private void UpdatePhase()
		{
			switch (_cycle.Phase)
			{
			case MicroHidPhase.WindingUp:
				if (_prevPhase != MicroHidPhase.WindingUp)
				{
					_windupElapsed = 0f;
					ReplayOverrideBlend(soft: false);
					SetAnim(AnimState3p.Override0, _animIdle);
				}
				base.OverrideBlend = 1f;
				_windupElapsed += Time.deltaTime;
				break;
			case MicroHidPhase.WindingDown:
				if (!(_windupElapsed < _minWindupTime))
				{
					base.OverrideBlend = 0f;
					if (_prevPhase != MicroHidPhase.WindingDown)
					{
						SetAnim(AnimState3p.Override0, _animWinddown);
						ReplayOverrideBlend(soft: false);
					}
				}
				break;
			case MicroHidPhase.WoundUpSustain:
				base.OverrideBlend = 1f;
				break;
			case MicroHidPhase.Firing:
				base.OverrideBlend = 2f;
				break;
			}
		}

		public LookatData ProcessLookat(LookatData data)
		{
			float num = 1f - Mathf.Clamp01(_lastWindupProgress * 3f);
			float num2 = num * num * num;
			data.BodyWeight = Mathf.Lerp(data.BodyWeight + 0.5f, 1f, 1f - num2);
			return data;
		}
	}
}
