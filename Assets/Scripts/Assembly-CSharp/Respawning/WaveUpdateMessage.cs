using Mirror;
using Respawning.Waves;
using Respawning.Waves.Generic;
using UnityEngine;
using Utils.Networking;

namespace Respawning
{
	public struct WaveUpdateMessage : NetworkMessage
	{
		public readonly float? SpawnIntervalSeconds;

		public readonly float? TimePassed;

		public readonly float? PauseDuration;

		public readonly int? RespawnTokens;

		private readonly UpdateMessageFlags _flags;

		private readonly int _index;

		public SpawnableWaveBase Wave { get; private set; }

		public bool IsTrigger => HasFlagFast(_flags, UpdateMessageFlags.Trigger);

		public bool IsSpawn => HasFlagFast(_flags, UpdateMessageFlags.Spawn);

		public bool IsMax => HasFlagFast(_flags, UpdateMessageFlags.Max);

		public bool IsForcePaused { get; }

		public static void ServerSendUpdate(SpawnableWaveBase wave, UpdateMessageFlags flags)
		{
			if (NetworkServer.active)
			{
				new WaveUpdateMessage(wave, flags).SendToAuthenticated();
			}
		}

		public WaveUpdateMessage(NetworkReader reader)
		{
			Wave = null;
			SpawnIntervalSeconds = null;
			TimePassed = null;
			PauseDuration = null;
			RespawnTokens = null;
			IsForcePaused = false;
			_index = reader.ReadInt();
			_flags = (UpdateMessageFlags)reader.ReadByte();
			if (!WaveManager.Waves.TryGet(_index, out var element))
			{
				Debug.LogError($"Phoenix - Failed to get spawnable wave of index: {_index}.");
				return;
			}
			Wave = element;
			RespawnTokens = null;
			SpawnIntervalSeconds = null;
			TimePassed = null;
			PauseDuration = null;
			if (HasFlagFast(_flags, UpdateMessageFlags.Tokens) && Wave is ILimitedWave)
			{
				RespawnTokens = reader.ReadInt();
			}
			if (Wave is TimeBasedWave)
			{
				if (HasFlagFast(_flags, UpdateMessageFlags.Timer))
				{
					SpawnIntervalSeconds = reader.ReadFloat();
					TimePassed = reader.ReadFloat();
				}
				if (HasFlagFast(_flags, UpdateMessageFlags.Pause))
				{
					PauseDuration = reader.ReadFloat();
				}
				IsForcePaused = reader.ReadBool();
			}
		}

		private WaveUpdateMessage(SpawnableWaveBase wave, UpdateMessageFlags flags)
		{
			SpawnIntervalSeconds = null;
			TimePassed = null;
			PauseDuration = null;
			RespawnTokens = null;
			IsForcePaused = false;
			Wave = wave;
			_flags = flags;
			_index = WaveManager.Waves.IndexOf(wave);
			if (_index < 0)
			{
				Debug.LogError("Phoenix - WaveUpdate failed: " + ((wave == null) ? "null" : wave.GetType().Name));
				return;
			}
			RespawnTokens = ((wave is ILimitedWave limitedWave) ? new int?(limitedWave.RespawnTokens) : ((int?)null));
			if (Wave is TimeBasedWave timeBasedWave)
			{
				SpawnIntervalSeconds = timeBasedWave.Timer.SpawnIntervalSeconds;
				TimePassed = timeBasedWave.Timer.TimePassed;
				PauseDuration = timeBasedWave.Timer.PauseTimeLeft;
				IsForcePaused = timeBasedWave.Timer.IsForcefullyPaused;
			}
			else
			{
				SpawnIntervalSeconds = null;
				TimePassed = null;
				PauseDuration = null;
				IsForcePaused = false;
			}
		}

		public void Write(NetworkWriter writer)
		{
			writer.WriteInt(_index);
			writer.WriteByte((byte)_flags);
			if (_index < 0)
			{
				return;
			}
			if (HasFlagFast(_flags, UpdateMessageFlags.Tokens) && Wave is ILimitedWave limitedWave)
			{
				writer.WriteInt(limitedWave.RespawnTokens);
			}
			if (Wave is TimeBasedWave timeBasedWave)
			{
				if (HasFlagFast(_flags, UpdateMessageFlags.Timer))
				{
					writer.WriteFloat(timeBasedWave.Timer.SpawnIntervalSeconds);
					writer.WriteFloat(timeBasedWave.Timer.TimePassed);
				}
				if (HasFlagFast(_flags, UpdateMessageFlags.Pause))
				{
					writer.WriteFloat(timeBasedWave.Timer.PauseTimeLeft);
				}
				writer.WriteBool(timeBasedWave.Timer.IsForcefullyPaused);
			}
		}

		private static bool HasFlagFast(UpdateMessageFlags flags, UpdateMessageFlags flag)
		{
			return (flags & flag) == flag;
		}
	}
}
