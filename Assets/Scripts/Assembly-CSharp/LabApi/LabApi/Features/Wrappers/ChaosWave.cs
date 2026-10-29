namespace LabApi.Features.Wrappers
{
	public class ChaosWave : global::LabApi.Features.Wrappers.RespawnWave
	{
		public new global::Respawning.Waves.ChaosSpawnWave Base { get; private set; }

		public float LogicerPercent
		{
			get
			{
				return Base.LogicerPercent;
			}
			set
			{
				Base.LogicerPercent = value;
			}
		}

		public float ShotgunPercent
		{
			get
			{
				return Base.ShotgunPercent;
			}
			set
			{
				Base.ShotgunPercent = value;
			}
		}

		public override int MaxWaveSize
		{
			get
			{
				return Base.MaxWaveSize;
			}
			set
			{
				float sizePercentage = (float)value / (float)ReferenceHub.AllHubs.Count;
				if (Base.Configuration is global::Respawning.Config.PrimaryWaveConfig<global::Respawning.Waves.ChaosSpawnWave> primaryWaveConfig)
				{
					primaryWaveConfig.SizePercentage = sizePercentage;
				}
			}
		}

		internal ChaosWave(global::Respawning.Waves.ChaosSpawnWave wave)
			: base(wave)
		{
			Base = wave;
		}
	}
}
