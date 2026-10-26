using System.Collections.Generic;
using Mirror;

namespace Respawning.Waves
{
	public abstract class TimeBasedWave : SpawnableWaveBase
	{
		public float AdditionalSecondsPerSpawn = 10f;

		public abstract float InitialSpawnInterval { get; }

		public WaveTimer Timer { get; private set; }

		public virtual bool ReceiveObjectiveRewards => true;

		public virtual bool PauseOnTrigger => true;

		public virtual bool IsReadyToSpawn => Timer.IsReadyToSpawn;

		protected override void OnInstanceCreated()
		{
			base.OnInstanceCreated();
			Timer = new WaveTimer(this);
		}

		protected override void OnInstanceDestroyed()
		{
			base.OnInstanceDestroyed();
			Timer?.Destroy();
		}

		protected override void OnAnyWaveSpawned(SpawnableWaveBase wave, List<ReferenceHub> spawnedPlayers)
		{
			base.OnAnyWaveSpawned(wave, spawnedPlayers);
			if (NetworkServer.active && wave == this)
			{
				Timer.SpawnIntervalSeconds += (float)spawnedPlayers.Count * AdditionalSecondsPerSpawn;
				WaveUpdateMessage.ServerSendUpdate(this, UpdateMessageFlags.Timer | UpdateMessageFlags.Spawn);
			}
		}
	}
}
