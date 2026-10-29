namespace LabApi.Events.Arguments.ServerEvents
{
	public class WaveRespawnedEventArgs : global::System.EventArgs
	{
		public global::LabApi.Features.Wrappers.RespawnWave Wave { get; }

		public global::System.Collections.Generic.IReadOnlyList<global::LabApi.Features.Wrappers.Player> Players { get; }

		public WaveRespawnedEventArgs(global::Respawning.Waves.SpawnableWaveBase wave, global::System.Collections.Generic.List<global::LabApi.Features.Wrappers.Player> players)
		{
			Players = players;
			Wave = global::LabApi.Features.Wrappers.RespawnWaves.Get(wave);
		}
	}
}
