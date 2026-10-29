namespace LabApi.Events.Arguments.ServerEvents
{
	public class WaveTeamSelectingEventArgs : global::System.EventArgs, global::LabApi.Events.Arguments.Interfaces.ICancellableEvent
	{
		public global::Respawning.Waves.SpawnableWaveBase Wave { get; set; }

		public bool IsAllowed { get; set; }

		public WaveTeamSelectingEventArgs(global::Respawning.Waves.SpawnableWaveBase wave)
		{
			IsAllowed = true;
			Wave = wave;
		}
	}
}
