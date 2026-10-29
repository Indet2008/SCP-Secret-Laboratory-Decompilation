namespace LabApi.Events.Arguments.ServerEvents
{
	public class WaveTeamSelectedEventArgs : global::System.EventArgs
	{
		public global::LabApi.Features.Wrappers.RespawnWave Wave { get; }

		public WaveTeamSelectedEventArgs(global::Respawning.Waves.SpawnableWaveBase wave)
		{
			Wave = global::LabApi.Features.Wrappers.RespawnWaves.Get(wave);
		}
	}
}
