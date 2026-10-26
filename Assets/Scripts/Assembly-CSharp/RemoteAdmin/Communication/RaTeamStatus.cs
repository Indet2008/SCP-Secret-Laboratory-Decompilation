using NorthwoodLib.Pools;
using Respawning;
using Respawning.Waves;
using Respawning.Waves.Generic;

namespace RemoteAdmin.Communication
{
	public class RaTeamStatus : RaClientDataRequest
	{
		public override int DataId => 8;

		protected override void GatherData()
		{
			StringBuilderPool.Shared.Rent();
			foreach (TimeBasedWave wave in WaveManager.Waves)
			{
				AppendData((wave as ILimitedWave).RespawnTokens);
				float num = FactionInfluenceManager.Get(wave.TargetFaction);
				if (!RespawnTokensManager.TryGetNextThreshold(wave.TargetFaction, num, out var threshold))
				{
					threshold = -1;
				}
				AppendData((wave is IMiniWave miniWave) ? miniWave.GetInfluenceDifference(num) : num);
				AppendData((wave is IMiniWave) ? 10f : ((float)threshold));
				AppendData(wave.Timer.TimeLeft);
				AppendString($"{CastBool(wave.Timer.IsForcefullyPaused)};");
			}
		}
	}
}
