namespace LabApi.Features.Wrappers
{
	public class MiniChaosWave : global::LabApi.Features.Wrappers.MiniRespawnWave
	{
		public new global::Respawning.Waves.ChaosMiniWave Base { get; private set; }

		internal MiniChaosWave(global::Respawning.Waves.ChaosMiniWave miniWave)
			: base(miniWave)
		{
			Base = miniWave;
		}
	}
}
