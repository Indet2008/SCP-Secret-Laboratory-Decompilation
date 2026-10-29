namespace LabApi.Features.Wrappers
{
	public static class RespawnWaves
	{
		public static global::LabApi.Features.Wrappers.MtfWave? PrimaryMtfWave { get; private set; }

		public static global::LabApi.Features.Wrappers.ChaosWave? PrimaryChaosWave { get; private set; }

		public static global::LabApi.Features.Wrappers.MiniMtfWave? MiniMtfWave { get; private set; }

		public static global::LabApi.Features.Wrappers.MiniChaosWave? MiniChaosWave { get; private set; }

		public static global::LabApi.Features.Wrappers.RespawnWave? Get(global::Respawning.Waves.SpawnableWaveBase? baseWave)
		{
			if (!(baseWave is global::Respawning.Waves.NtfSpawnWave))
			{
				if (!(baseWave is global::Respawning.Waves.ChaosSpawnWave))
				{
					if (!(baseWave is global::Respawning.Waves.NtfMiniWave))
					{
						if (baseWave is global::Respawning.Waves.ChaosMiniWave)
						{
							return MiniChaosWave ?? (MiniChaosWave = new global::LabApi.Features.Wrappers.MiniChaosWave((global::Respawning.Waves.ChaosMiniWave)baseWave));
						}
						return null;
					}
					return MiniMtfWave ?? (MiniMtfWave = new global::LabApi.Features.Wrappers.MiniMtfWave((global::Respawning.Waves.NtfMiniWave)baseWave));
				}
				return PrimaryChaosWave ?? (PrimaryChaosWave = new global::LabApi.Features.Wrappers.ChaosWave((global::Respawning.Waves.ChaosSpawnWave)baseWave));
			}
			return PrimaryMtfWave ?? (PrimaryMtfWave = new global::LabApi.Features.Wrappers.MtfWave((global::Respawning.Waves.NtfSpawnWave)baseWave));
		}

		[global::Generators.InitializeWrapper(128)]
		internal static void Initialize()
		{
			foreach (global::Respawning.Waves.SpawnableWaveBase wave in global::Respawning.WaveManager.Waves)
			{
				Get(wave);
			}
		}
	}
}
