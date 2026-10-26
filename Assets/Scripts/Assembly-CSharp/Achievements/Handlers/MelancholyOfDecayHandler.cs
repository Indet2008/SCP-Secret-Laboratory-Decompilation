using System.Collections.Generic;
using Mirror;
using PlayerRoles.PlayableScps.Scp106;

namespace Achievements.Handlers
{
	public class MelancholyOfDecayHandler : AchievementHandlerBase
	{
		private const int TimeToCapture = 5;

		private static readonly Dictionary<uint, double> TimeframesPerNetId = new Dictionary<uint, double>();

		internal override void OnInitialize()
		{
			Scp106SinkholeController.OnSubmergeStateChange += OnSubmergeStateChange;
			Scp106Attack.OnPlayerTeleported += OnPlayerTeleported;
		}

		internal override void OnRoundStarted()
		{
			TimeframesPerNetId.Clear();
		}

		private void OnPlayerTeleported(ReferenceHub scp106, ReferenceHub hub)
		{
			if (TimeframesPerNetId.TryGetValue(scp106.netId, out var value) && !(NetworkTime.time > value))
			{
				AchievementHandlerBase.ServerAchieve(scp106.connectionToClient, AchievementName.MelancholyOfDecay);
			}
		}

		private void OnSubmergeStateChange(Scp106Role scp106, bool newTargetSubmerged)
		{
			if (NetworkServer.active && !newTargetSubmerged && scp106.TryGetOwner(out var hub))
			{
				TimeframesPerNetId[hub.netId] = NetworkTime.time + (double)scp106.Sinkhole.TargetTransitionDuration + 5.0;
			}
		}
	}
}
