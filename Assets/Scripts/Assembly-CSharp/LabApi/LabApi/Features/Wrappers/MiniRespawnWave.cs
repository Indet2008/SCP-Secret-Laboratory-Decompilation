namespace LabApi.Features.Wrappers
{
	public abstract class MiniRespawnWave : global::LabApi.Features.Wrappers.RespawnWave
	{
		public new global::Respawning.Waves.IMiniWave Base { get; private set; }

		public override int MaxWaveSize
		{
			get
			{
				if (Base is global::Respawning.Waves.TimeBasedWave timeBasedWave)
				{
					return timeBasedWave.MaxWaveSize;
				}
				return 0;
			}
			set
			{
				if (value >= 0)
				{
					float waveSizeMultiplier = (float)value / (float)ReferenceHub.AllHubs.Count;
					Base.WaveSizeMultiplier = waveSizeMultiplier;
				}
			}
		}

		public global::PlayerRoles.RoleTypeId DefaultRole
		{
			get
			{
				return Base.DefaultRole;
			}
			set
			{
				Base.DefaultRole = value;
			}
		}

		public global::PlayerRoles.RoleTypeId SpecialRole
		{
			get
			{
				return Base.SpecialRole;
			}
			set
			{
				Base.SpecialRole = value;
			}
		}

		internal MiniRespawnWave(global::Respawning.Waves.IMiniWave miniWave)
			: base((global::Respawning.Waves.TimeBasedWave)miniWave)
		{
			Base = miniWave;
		}

		public override void InitiateRespawn()
		{
			Unlock();
			base.InitiateRespawn();
		}

		public virtual void Unlock()
		{
			Base.Unlock();
		}

		public virtual void Lock()
		{
			Base.ResetTokens();
		}
	}
}
