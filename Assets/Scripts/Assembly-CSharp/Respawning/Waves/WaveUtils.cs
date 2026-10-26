using System;
using System.Text;
using Mirror;
using NorthwoodLib.Pools;
using PlayerRoles;
using Respawning.Waves.Generic;
using UnityEngine;

namespace Respawning.Waves
{
	public static class WaveUtils
	{
		public static void WriteWave(this NetworkWriter writer, SpawnableWaveBase wave)
		{
			writer.WriteInt(WaveManager.Waves.IndexOf(wave));
		}

		public static bool TryReadWave(this NetworkReader reader, out SpawnableWaveBase wave)
		{
			int index = reader.ReadInt();
			return WaveManager.Waves.TryGet(index, out wave);
		}

		public static bool TryReadWave<T>(this NetworkReader reader, out T wave) where T : SpawnableWaveBase
		{
			wave = null;
			if (!reader.TryReadWave(out var wave2))
			{
				return false;
			}
			if (!(wave2 is T val))
			{
				return false;
			}
			wave = val;
			return true;
		}

		public static string CreateDebugString(this SpawnableWaveBase wave)
		{
			StringBuilder stringBuilder = StringBuilderPool.Shared.Rent();
			Faction targetFaction = wave.TargetFaction;
			Type type = wave.GetType();
			Type[] interfaces = type.GetInterfaces();
			stringBuilder.Append("<b>Instance:</b> ").Append(type.Name);
			if (interfaces.Length != 0)
			{
				stringBuilder.Append(" (");
				for (int i = 0; i < interfaces.Length; i++)
				{
					Type type2 = interfaces[i];
					stringBuilder.Append(type2.Name);
					if (i != interfaces.Length - 1)
					{
						stringBuilder.Append(", ");
					}
				}
				stringBuilder.Append(")");
			}
			if (wave is TimeBasedWave timedWave)
			{
				AppendTimerData(stringBuilder, timedWave);
			}
			if (wave is ILimitedWave limitedWave)
			{
				AppendTokenData(stringBuilder, limitedWave);
			}
			if (!(wave is IMiniWave))
			{
				float value = FactionInfluenceManager.Get(targetFaction);
				stringBuilder.Append("\n").Append(targetFaction.ToString()).Append(" <b>has</b> ")
					.Append(value)
					.Append(" <b>points.</b>");
			}
			return StringBuilderPool.Shared.ToStringReturn(stringBuilder);
		}

		private static void AppendTokenData(StringBuilder sb, ILimitedWave limitedWave)
		{
			sb.Append("\n<b>Wave has</b> ").Append(limitedWave.RespawnTokens).Append(" <b>tokens.</b>");
			sb.Append("\n<b>Wave starts with</b> ").Append(limitedWave.InitialRespawnTokens).Append(" <b>tokens.</b>");
		}

		private static void AppendTimerData(StringBuilder sb, TimeBasedWave timedWave)
		{
			WaveTimer timer = timedWave.Timer;
			sb.Append("\n<b>Time Passed:</b> ").Append(timer.TimePassed);
			sb.Append("\n<b>Time Left:</b> ").Append(timer.TimeLeft);
			sb.Append("\n<b>Spawns after</b> ").Append(timer.SpawnIntervalSeconds).Append(" <b>seconds.</b>");
			sb.Append("\n<b>Timer ");
			if (timer.IsPaused)
			{
				sb.Append("<u>IS</u> paused for</b> ").Append(Mathf.RoundToInt(timer.PauseTimeLeft)).Append("<b>.</b>");
			}
			else
			{
				sb.Append("is <u>NOT</u> paused.</b>");
			}
			sb.Append("\n<b>Wave ");
			if (timedWave.Configuration.IsEnabled)
			{
				sb.Append(timer.IsReadyToSpawn ? "<u>IS</u> ready to spawn." : "is <u>NOT</u> ready to spawn.</b>");
			}
			else
			{
				sb.Append("is <color=red>disabled</color>.");
			}
			sb.Append("\n<b>Wave Size:</b> ").Append(timedWave.MaxWaveSize);
		}
	}
}
