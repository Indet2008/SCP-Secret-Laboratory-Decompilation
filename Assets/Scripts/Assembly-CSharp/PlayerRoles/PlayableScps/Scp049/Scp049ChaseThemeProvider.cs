using System;
using System.Collections.Generic;
using AudioPooling;
using FacilitySoundtrack.ChaseThemes;
using PlayerRoles.PlayableScps.Subroutines;
using UnityEngine;

namespace PlayerRoles.PlayableScps.Scp049
{
	public class Scp049ChaseThemeProvider : FpcStandardChaseThemeProvider<Scp049Role>
	{
		[Serializable]
		private struct VolumeSet
		{
			public float BaselineVolume;

			public float DrumsVolume;

			public float CrossfadeSpeed;
		}

		[Serializable]
		private class Stinger049 : StingerThresholdPair
		{
			public float CrossfadeSpeedOverride;
		}

		private Scp049SenseAbility _senseAbility;

		private float? _crossfadeSpeedOverride;

		[SerializeField]
		private AudioClip _baselineClip;

		[SerializeField]
		private AudioClip _drumsClip;

		[SerializeField]
		private AudioClip _senseClip;

		[SerializeField]
		private VolumeSet _normalVolumePair;

		[SerializeField]
		private VolumeSet _senseAbilityVolumePair;

		[SerializeField]
		private Stinger049[] _stingers;

		public override AudioPoolSession? OnChaseStarted(List<AudioPoolSession> alreadyPlayedStingers)
		{
			base.OnChaseStarted(alreadyPlayedStingers);
			if (alreadyPlayedStingers.Count > 0)
			{
				_crossfadeSpeedOverride = null;
				return null;
			}
			float perceivedJumpscareDistance = GetPerceivedJumpscareDistance();
			StingerThresholdPair[] stingers = _stingers;
			StingerThresholdPair best = StingerThresholdPair.GetBest(stingers, perceivedJumpscareDistance);
			_crossfadeSpeedOverride = (best as Stinger049).CrossfadeSpeedOverride;
			return FpcStandardChaseThemeProvider<Scp049Role>.PlayStinger(best.Clip);
		}

		protected override void Awake()
		{
			base.Awake();
			base.ScpRole.SubroutineModule.TryGetSubroutine<Scp049SenseAbility>(out _senseAbility);
		}

		public override bool UpdateChase()
		{
			base.ClipsToPlay.Clear();
			VolumeSet volumeSet;
			if (_senseAbility.HasTarget && _senseAbility.Target.isLocalPlayer)
			{
				volumeSet = _senseAbilityVolumePair;
				double secondsUntilNextBar = new ChaseClipUtils(_senseClip).SecondsUntilNextBar;
				DesiredChaseClip.Offset value = new DesiredChaseClip.Offset(secondsUntilNextBar, 0, dontSyncWithOthers: true);
				base.ClipsToPlay.Add(new DesiredChaseClip(_senseClip, 1f, 10f, 10f, value));
				_crossfadeSpeedOverride = null;
			}
			else
			{
				volumeSet = _normalVolumePair;
			}
			float num = _crossfadeSpeedOverride ?? volumeSet.CrossfadeSpeed;
			base.ClipsToPlay.Add(new DesiredChaseClip(_baselineClip, volumeSet.BaselineVolume, num, num));
			base.ClipsToPlay.Add(new DesiredChaseClip(_drumsClip, volumeSet.DrumsVolume, num, num));
			return base.UpdateChase();
		}
	}
}
