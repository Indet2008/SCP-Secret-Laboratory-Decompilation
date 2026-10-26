using System.Collections.Generic;
using AudioPooling;
using FacilitySoundtrack.ChaseThemes;
using PlayerRoles.PlayableScps.Subroutines;
using UnityEngine;

namespace PlayerRoles.PlayableScps.Scp3114
{
	public class Scp3114ChaseThemeProvider : FpcStandardChaseThemeProvider<Scp3114Role>
	{
		private Scp3114StrangleAudio _strangleAudio;

		[SerializeField]
		private StingerThresholdPair[] _stingers;

		[SerializeField]
		private AudioClip _baselineClip;

		[SerializeField]
		private AudioClip _drumsClip;

		[SerializeField]
		private int _strangledPriority;

		[SerializeField]
		private float _regularDominanceScale;

		public override int Priority
		{
			get
			{
				if (!_strangleAudio.LocallyStrangled)
				{
					return base.Priority;
				}
				return _strangledPriority;
			}
		}

		public override float DominanceScale => (_strangleAudio.LocallyStrangled ? 1f : _regularDominanceScale) * base.DominanceScale;

		protected override void Awake()
		{
			base.Awake();
			base.ScpRole.SubroutineModule.TryGetSubroutine<Scp3114StrangleAudio>(out _strangleAudio);
		}

		public override AudioPoolSession? OnChaseStarted(List<AudioPoolSession> alreadyPlayedStingers)
		{
			base.OnChaseStarted(alreadyPlayedStingers);
			if (alreadyPlayedStingers.Count > 0)
			{
				return null;
			}
			return FpcStandardChaseThemeProvider<Scp3114Role>.PlayStinger(StingerThresholdPair.GetBest(_stingers, GetDominanceFromDistance()).Clip);
		}

		public override bool TryStartChase()
		{
			if (base.TryStartChase())
			{
				return base.ScpRole.SkeletonIdle;
			}
			return false;
		}

		public override bool UpdateChase()
		{
			base.ClipsToPlay.Clear();
			if (_strangleAudio.LocallyStrangled)
			{
				base.ClipsToPlay.Add(new DesiredChaseClip(_baselineClip, 0f));
			}
			else
			{
				double secondsUntilNextBar = new ChaseClipUtils(_baselineClip).SecondsUntilNextBar;
				DesiredChaseClip.Offset value = new DesiredChaseClip.Offset(secondsUntilNextBar, 0, dontSyncWithOthers: true);
				base.ClipsToPlay.Add(new DesiredChaseClip(_baselineClip, 1f, 1f / Time.deltaTime, 10f, value));
			}
			base.ClipsToPlay.Add(new DesiredChaseClip(_drumsClip));
			return base.UpdateChase();
		}
	}
}
