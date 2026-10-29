namespace LabApi.Features.Wrappers
{
	public class MiniMtfWave : global::LabApi.Features.Wrappers.MiniRespawnWave
	{
		public new global::Respawning.Waves.NtfMiniWave Base { get; private set; }

		internal MiniMtfWave(global::Respawning.Waves.NtfMiniWave miniWave)
			: base(miniWave)
		{
			Base = miniWave;
		}
	}
}
