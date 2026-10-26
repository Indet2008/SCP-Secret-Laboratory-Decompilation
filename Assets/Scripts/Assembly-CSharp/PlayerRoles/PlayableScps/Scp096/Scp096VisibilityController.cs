using PlayerRoles.FirstPersonControl;
using PlayerRoles.Visibility;
using UnityEngine;

namespace PlayerRoles.PlayableScps.Scp096
{
	public class Scp096VisibilityController : FpcVisibilityController
	{
		private const float RageRangeBuffer = 10f;

		private Scp096Role _role;

		private Scp096TargetsTracker _targetsTracker;

		public override InvisibilityFlags IgnoredFlags
		{
			get
			{
				InvisibilityFlags invisibilityFlags = base.IgnoredFlags;
				if (HideNonTargets)
				{
					invisibilityFlags |= (InvisibilityFlags)3u;
				}
				return invisibilityFlags;
			}
		}

		protected override int NormalMaxRangeSqr => EnsureVisiblityForState(base.NormalMaxRangeSqr);

		protected override int SurfaceMaxRangeSqr => EnsureVisiblityForState(base.SurfaceMaxRangeSqr);

		private bool HideNonTargets
		{
			get
			{
				if (!_role.IsRageState(Scp096RageState.Distressed))
				{
					return _role.IsRageState(Scp096RageState.Enraged);
				}
				return true;
			}
		}

		private int EnsureVisiblityForState(int defaultRange)
		{
			if (!Scp096AudioPlayer.TryGetAudioForState(_role.StateController.RageState, out var stateAudio))
			{
				return defaultRange;
			}
			float num = stateAudio.MaxDistance + 10f;
			return Mathf.Max(Mathf.RoundToInt(num * num), defaultRange);
		}

		public override InvisibilityFlags GetActiveFlags(ReferenceHub observer)
		{
			return base.GetActiveFlags(observer);
		}

		public override bool ValidateVisibility(ReferenceHub target)
		{
			if (HideNonTargets)
			{
				if (_targetsTracker.HasTarget(target))
				{
					return base.ValidateVisibility(target);
				}
				return false;
			}
			return base.ValidateVisibility(target);
		}

		public override void SpawnObject()
		{
			base.SpawnObject();
			_role = base.Role as Scp096Role;
			_role.SubroutineModule.TryGetSubroutine<Scp096TargetsTracker>(out _targetsTracker);
		}
	}
}
