namespace LabApi.Features.Wrappers
{
	public class MtfWave : global::LabApi.Features.Wrappers.RespawnWave
	{
		public new global::Respawning.Waves.NtfSpawnWave Base { get; private set; }

		[global::System.Obsolete("Use SergeantsPercentage instead", true)]
		public int MaxSergeants
		{
			get
			{
				return 0;
			}
			set
			{
				global::LabApi.Features.Console.Logger.Error("Plugin Error. Cannot set MaxSergeants, use SergeantsPercentage instead.");
			}
		}

		public float SergeantsPercentage
		{
			get
			{
				return Base.SergeantPercent;
			}
			set
			{
				Base.SergeantPercent = value;
			}
		}

		[global::System.Obsolete("Use CaptainsPercentage instead", true)]
		public int MaxCaptains
		{
			get
			{
				return 0;
			}
			set
			{
				global::LabApi.Features.Console.Logger.Error("Plugin Error. Cannot set MaxCaptains, use CaptainsPercentage instead.");
			}
		}

		public float CaptainsPercentage
		{
			get
			{
				return Base.CaptainPercent;
			}
			set
			{
				Base.CaptainPercent = value;
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
				if (Base.Configuration is global::Respawning.Config.PrimaryWaveConfig<global::Respawning.Waves.NtfSpawnWave> primaryWaveConfig)
				{
					primaryWaveConfig.SizePercentage = sizePercentage;
				}
			}
		}

		internal MtfWave(global::Respawning.Waves.NtfSpawnWave wave)
			: base(wave)
		{
			Base = wave;
		}
	}
}
