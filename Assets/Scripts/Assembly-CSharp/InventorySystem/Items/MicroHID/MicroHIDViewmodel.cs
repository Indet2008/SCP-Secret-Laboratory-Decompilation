using AudioPooling;
using InventorySystem.Items.MicroHID.Modules;
using InventorySystem.Items.SwayControllers;
using UnityEngine;

namespace InventorySystem.Items.MicroHID
{
	public class MicroHIDViewmodel : StandardAnimatedViemodel
	{
		private static readonly int FiringModeHash = Animator.StringToHash("LastFiringMode");

		private static readonly int CurPhaseHash = Animator.StringToHash("CurPhase");

		private static readonly int PhaseChangedHash = Animator.StringToHash("OnPhaseChanged");

		private static readonly int InspectValidBoolHash = Animator.StringToHash("InspectValid");

		private static readonly int InspectStartTriggerHash = Animator.StringToHash("InspectStart");

		private static readonly int InspectTagNameHash = Animator.StringToHash("Inspect");

		private static readonly int FirstTimePickupFloatHash = Animator.StringToHash("DrawPickupBlend");

		private static readonly int IdleTagNameHash = Animator.StringToHash("Idle");

		private static readonly int BrokenHash = Animator.StringToHash("OnBroken");

		private const int InspectLayer = 0;

		private const int BrokenLayer = 3;

		private const int ShakeLayer = 4;

		private const int DecreaseVolumeSpeed = 3;

		private const int ShakeAdjustSpeed = 2;

		private MicroHidPhase? _prevPhase;

		private AudioPoolSession _inspectSoundSession;

		private float _brokenElapsed;

		private CycleController _cycle;

		[SerializeField]
		private AudioClip _inspectSound;

		[SerializeField]
		private MicroHIDParticles _particles;

		[SerializeField]
		private AnimationCurve _brokenWeightOverTime;

		[SerializeField]
		private AnimationCurve _shakingOverSustain;

		[SerializeField]
		private AnimationCurve _shakingOverWindupProgress;

		private bool IsInspecting
		{
			get
			{
				AnimatorStateInfo animatorStateInfo = AnimatorStateInfo(0);
				if (animatorStateInfo.tagHash != IdleTagNameHash)
				{
					return animatorStateInfo.tagHash == InspectTagNameHash;
				}
				return true;
			}
		}

		private bool ValidateStartInspect
		{
			get
			{
				AnimatorStateInfo animatorStateInfo = AnimatorStateInfo(0);
				bool flag = AnimatorInTransition(0);
				if (animatorStateInfo.tagHash == IdleTagNameHash)
				{
					return !flag;
				}
				return false;
			}
		}

		private float WindupShakeAmount
		{
			get
			{
				float progress = WindupSyncModule.GetProgress(base.ItemId.SerialNumber);
				return _shakingOverWindupProgress.Evaluate(progress);
			}
		}

		private float SustainShakeAmount
		{
			get
			{
				if (_cycle.Phase != MicroHidPhase.WoundUpSustain)
				{
					return 0f;
				}
				return _shakingOverSustain.Evaluate(_cycle.CurrentPhaseElapsed);
			}
		}

		protected override IItemSwayController GetNewSwayController()
		{
			return new WalkSway(new GoopSway.GoopSwaySettings(HandsPivot, 1.6f, 0.0015f, 0.04f, 4f, 6.5f, 0.025f, 2.6f, invertSway: false), this);
		}

		public override void InitSpectator(ReferenceHub ply, ItemIdentifier id, bool wasEquipped)
		{
			base.InitSpectator(ply, id, wasEquipped);
			UpdateAllAnims();
			if (wasEquipped)
			{
				AnimatorForceUpdate(base.SkipEquipTime, fastMode: false);
			}
		}

		public override void InitAny()
		{
			base.InitAny();
			BrokenSyncModule.OnBroken += OnBroken;
			DrawAndInspectorModule.OnInspectRequested += OnInspectRequested;
			if (BrokenSyncModule.GetBroken(base.ItemId.SerialNumber))
			{
				_brokenElapsed = _brokenWeightOverTime[_brokenWeightOverTime.length - 1].time;
			}
			_cycle = CycleSyncModule.GetCycleController(base.ItemId.SerialNumber);
			_particles.Init(base.ItemId.SerialNumber, base.Hub.PlayerCameraReference);
			ParticleSystem[] componentsInChildren = _particles.GetComponentsInChildren<ParticleSystem>(includeInactive: true);
			foreach (ParticleSystem particleSystem in componentsInChildren)
			{
				if (particleSystem.gameObject.layer == base.gameObject.layer)
				{
					WorldspaceLightParticleConverter.Convert(particleSystem, includeSubsystems: false);
				}
			}
		}

		private void OnBroken(ushort serial)
		{
			if (serial == base.ItemId.SerialNumber)
			{
				AnimatorSetLayerWeight(3, 1f);
				AnimatorSetTrigger(BrokenHash);
			}
		}

		private void OnInspectRequested(ushort serial)
		{
			if (serial == base.ItemId.SerialNumber && ValidateStartInspect)
			{
				AnimatorSetTrigger(InspectStartTriggerHash);
				AnimatorSetBool(InspectValidBoolHash, val: true);
				_inspectSoundSession = new AudioPoolSession(AudioSourcePoolManager.Play2DWithParent(_inspectSound, base.transform));
			}
		}

		private void OnDestroy()
		{
			BrokenSyncModule.OnBroken -= OnBroken;
			DrawAndInspectorModule.OnInspectRequested -= OnInspectRequested;
		}

		private void Update()
		{
			UpdateAllAnims();
		}

		private void UpdateAllAnims()
		{
			UpdateBroken();
			UpdatePickup();
			UpdateInspect();
			UpdateCycle();
			UpdateShaking();
		}

		private void UpdateBroken()
		{
			if (BrokenSyncModule.GetBroken(base.ItemId.SerialNumber))
			{
				_brokenElapsed += Time.deltaTime;
			}
			AnimatorSetLayerWeight(3, _brokenWeightOverTime.Evaluate(_brokenElapsed));
		}

		private void UpdatePickup()
		{
			bool flag = DrawAndInspectorModule.CheckPickupPreference(base.ItemId.SerialNumber);
			AnimatorSetFloat(FirstTimePickupFloatHash, flag ? 1 : 0);
		}

		private void UpdateInspect()
		{
			if (!IsInspecting && _inspectSoundSession.SameSession)
			{
				_inspectSoundSession.Source.volume -= Time.deltaTime * 3f;
			}
			AnimatorSetBool(InspectValidBoolHash, IsInspecting);
		}

		private void UpdateCycle()
		{
			AnimatorSetInt(CurPhaseHash, (int)_cycle.Phase);
			AnimatorSetInt(FiringModeHash, (int)_cycle.LastFiringMode);
			if (_prevPhase != _cycle.Phase)
			{
				_prevPhase = _cycle.Phase;
				AnimatorSetTrigger(PhaseChangedHash);
			}
		}

		private void UpdateShaking()
		{
			float current = AnimatorGetLayerWeight(4);
			float target = WindupShakeAmount + SustainShakeAmount;
			float maxDelta = Time.deltaTime * 2f;
			float val = Mathf.MoveTowards(current, target, maxDelta);
			AnimatorSetLayerWeight(4, val);
		}
	}
}
