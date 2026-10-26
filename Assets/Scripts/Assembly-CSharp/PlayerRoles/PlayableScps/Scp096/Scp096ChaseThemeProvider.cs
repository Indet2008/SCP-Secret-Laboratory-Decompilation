using System;
using System.Collections.Generic;
using AudioPooling;
using FacilitySoundtrack.ChaseThemes;
using PlayerRoles.PlayableScps.Subroutines;
using UnityEngine;

namespace PlayerRoles.PlayableScps.Scp096
{
	public class Scp096ChaseThemeProvider : FpcStandardChaseThemeProvider<Scp096Role>
	{
		[Serializable]
		private class ChaseThemeVariant
		{
			public AudioClip Docile;

			public AudioClip Enraged;

			public AudioClip EnragingDrums;

			public void FadeoutFast(List<DesiredChaseClip> themesToFadeout)
			{
				themesToFadeout.Add(new DesiredChaseClip(Docile, 0f));
				themesToFadeout.Add(new DesiredChaseClip(Enraged, 0f));
				themesToFadeout.Add(new DesiredChaseClip(EnragingDrums, 0f));
			}
		}

		[SerializeField]
		private AudioClip _subtleJumpscare;

		[SerializeField]
		private float _docileDominance;

		[SerializeField]
		private int _targettedPriority;

		[SerializeField]
		private float _enragedFadeSpeed;

		[SerializeField]
		private ChaseThemeVariant _nonTargetVariant;

		[SerializeField]
		private ChaseThemeVariant _targetedVariant;

		[SerializeField]
		private AnimationCurve _mainVolumeOverDistressed;

		[SerializeField]
		private AnimationCurve _drumsVolumeOverDistressed;

		private bool _wasDistressed;

		private float _distressProgress;

		private Scp096TargetsTracker _targetsTracker;

		private Scp096Role _scp096Role;

		private int _priority;

		private float _dominanceScale;

		public override int Priority => _priority;

		public override float DominanceScale => _dominanceScale;

		protected override void Awake()
		{
			base.Awake();
			_scp096Role = base.Role as Scp096Role;
			_scp096Role.SubroutineModule.TryGetSubroutine<Scp096TargetsTracker>(out _targetsTracker);
		}

		public override AudioPoolSession? OnChaseStarted(List<AudioPoolSession> alreadyPlayedStingers)
		{
			base.OnChaseStarted(alreadyPlayedStingers);
			if (alreadyPlayedStingers.Count > 0)
			{
				return null;
			}
			return FpcStandardChaseThemeProvider<Scp096Role>.PlayStinger(_subtleJumpscare);
		}

		public override bool TryStartChase()
		{
			if (!base.TryStartChase())
			{
				return GetLocalPlayerTargetedStatus();
			}
			return true;
		}

		public override bool UpdateChase()
		{
			base.ClipsToPlay.Clear();
			_dominanceScale = GetDominanceFromDistance();
			_priority = 0;
			bool localPlayerTargetedStatus = GetLocalPlayerTargetedStatus();
			ChaseThemeVariant chaseThemeVariant = (localPlayerTargetedStatus ? _targetedVariant : _nonTargetVariant);
			Scp096RageState rageState = _scp096Role.StateController.RageState;
			switch (rageState)
			{
			case Scp096RageState.Calming:
				SyncEnragedClips(0, 0.2f);
				goto case Scp096RageState.Docile;
			case Scp096RageState.Docile:
				if (!localPlayerTargetedStatus)
				{
					_dominanceScale *= _docileDominance;
				}
				base.ClipsToPlay.Add(new DesiredChaseClip(chaseThemeVariant.Docile));
				break;
			case Scp096RageState.Distressed:
				if (localPlayerTargetedStatus)
				{
					_priority = _targettedPriority;
				}
				if (!_wasDistressed)
				{
					OnStartDistressed(chaseThemeVariant);
					_wasDistressed = true;
				}
				else
				{
					UpdateDistressed(localPlayerTargetedStatus);
				}
				base.ClipsToPlay.Add(new DesiredChaseClip(chaseThemeVariant.Docile));
				break;
			case Scp096RageState.Enraged:
				if (localPlayerTargetedStatus)
				{
					_nonTargetVariant.FadeoutFast(base.ClipsToPlay);
					_priority = _targettedPriority;
				}
				base.ClipsToPlay.Add(new DesiredChaseClip(chaseThemeVariant.Docile, 0f));
				base.ClipsToPlay.Add(new DesiredChaseClip(chaseThemeVariant.EnragingDrums, 0f));
				base.ClipsToPlay.Add(new DesiredChaseClip(chaseThemeVariant.Enraged, 1f, _enragedFadeSpeed));
				break;
			}
			if (localPlayerTargetedStatus)
			{
				base.ClipsToPlay.Add(new DesiredChaseClip(_nonTargetVariant.Docile, 0f));
			}
			if (rageState != Scp096RageState.Distressed)
			{
				_wasDistressed = false;
			}
			return base.UpdateChase() | localPlayerTargetedStatus;
		}

		private void SyncEnragedClips(int offsetSamples, float speed)
		{
			DesiredChaseClip.Offset value = new DesiredChaseClip.Offset(0.0, offsetSamples);
			List<DesiredChaseClip> clipsToPlay = base.ClipsToPlay;
			AudioClip enraged = _nonTargetVariant.Enraged;
			DesiredChaseClip.Offset? offset = value;
			clipsToPlay.Add(new DesiredChaseClip(enraged, 0f, 10f, speed, offset));
			List<DesiredChaseClip> clipsToPlay2 = base.ClipsToPlay;
			AudioClip enragingDrums = _nonTargetVariant.EnragingDrums;
			offset = value;
			clipsToPlay2.Add(new DesiredChaseClip(enragingDrums, 0f, 10f, speed, offset));
			List<DesiredChaseClip> clipsToPlay3 = base.ClipsToPlay;
			AudioClip enraged2 = _targetedVariant.Enraged;
			offset = value;
			clipsToPlay3.Add(new DesiredChaseClip(enraged2, 0f, 10f, speed, offset));
			List<DesiredChaseClip> clipsToPlay4 = base.ClipsToPlay;
			AudioClip enragingDrums2 = _targetedVariant.EnragingDrums;
			offset = value;
			clipsToPlay4.Add(new DesiredChaseClip(enragingDrums2, 0f, 10f, speed, offset));
		}

		private void OnStartDistressed(ChaseThemeVariant variant)
		{
			_distressProgress = 0f;
			int num = (int)(6.1f * (float)variant.Enraged.frequency);
			ChaseClipUtils chaseClipUtils = new ChaseClipUtils(variant.Docile);
			chaseClipUtils.CurSample += num;
			chaseClipUtils.SampleIntoBar = 0;
			chaseClipUtils.CurrentBar++;
			SyncEnragedClips(-chaseClipUtils.CurSample, _enragedFadeSpeed);
		}

		private void UpdateDistressed(bool povIsTarget)
		{
			_distressProgress += Time.deltaTime / 6.1f;
			float num = _mainVolumeOverDistressed.Evaluate(_distressProgress);
			float num2 = _drumsVolumeOverDistressed.Evaluate(_distressProgress);
			base.ClipsToPlay.Add(new DesiredChaseClip(_nonTargetVariant.Enraged, povIsTarget ? 0f : num, _enragedFadeSpeed));
			base.ClipsToPlay.Add(new DesiredChaseClip(_nonTargetVariant.EnragingDrums, povIsTarget ? 0f : num2));
			base.ClipsToPlay.Add(new DesiredChaseClip(_targetedVariant.Enraged, povIsTarget ? num : 0f, _enragedFadeSpeed));
			base.ClipsToPlay.Add(new DesiredChaseClip(_targetedVariant.EnragingDrums, povIsTarget ? num2 : 0f));
		}

		private bool GetLocalPlayerTargetedStatus()
		{
			if (ReferenceHub.TryGetLocalHub(out var hub))
			{
				return _targetsTracker.Targets.Contains(hub);
			}
			return false;
		}
	}
}
