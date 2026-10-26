using System.Collections.Generic;
using CustomPlayerEffects;
using MEC;
using PlayerRoles;
using UnityEngine;

namespace Christmas.Scp2536.Gifts
{
	public class TargetFinder : Scp2536AnomalousGiftBase
	{
		private const float EffectDuration = 15f;

		private const int MaxTargetCount = 5;

		private CoroutineHandle _coroutineHandle;

		private float _timeLeft;

		public override UrgencyLevel Urgency => UrgencyLevel.One;

		public override bool CanBeGranted(ReferenceHub hub)
		{
			int num = RoundSummary.singleton.TargetCount + RoundSummary.singleton.ExtraTargets;
			if (num > 5 || num == 0)
			{
				return false;
			}
			if (base.CanBeGranted(hub))
			{
				return !_coroutineHandle.IsRunning;
			}
			return false;
		}

		public override void ServerGrant(ReferenceHub hub)
		{
			base.ServerGrant(hub);
			_coroutineHandle = Timing.RunCoroutine(ApplyEffect().CancelWith(Scp2536Controller.Singleton.gameObject));
		}

		private IEnumerator<float> ApplyEffect()
		{
			yield return float.NegativeInfinity;
			_timeLeft = 15f;
			while (_timeLeft > 0f)
			{
				_timeLeft -= Time.deltaTime;
				foreach (ReferenceHub allHub in ReferenceHub.AllHubs)
				{
					Team team = allHub.roleManager.CurrentRole.Team;
					if (team != Team.SCPs && team != Team.Dead)
					{
						AnomalousTarget effect = allHub.playerEffectsController.GetEffect<AnomalousTarget>();
						if (!effect.IsEnabled)
						{
							effect.ServerSetState(1, _timeLeft);
						}
					}
				}
			}
		}
	}
}
