namespace LabApi.Events.Arguments.Scp079Events
{
	public class Scp079UsedTeslaEventArgs : global::System.EventArgs, global::LabApi.Events.Arguments.Interfaces.IPlayerEvent, global::LabApi.Events.Arguments.Interfaces.ITeslaEvent
	{
		public global::LabApi.Features.Wrappers.Player Player { get; }

		public global::LabApi.Features.Wrappers.Tesla Tesla { get; }

		public Scp079UsedTeslaEventArgs(ReferenceHub hub, TeslaGate tesla)
		{
			Player = global::LabApi.Features.Wrappers.Player.Get(hub);
			Tesla = global::LabApi.Features.Wrappers.Tesla.Get(tesla);
		}
	}
}
