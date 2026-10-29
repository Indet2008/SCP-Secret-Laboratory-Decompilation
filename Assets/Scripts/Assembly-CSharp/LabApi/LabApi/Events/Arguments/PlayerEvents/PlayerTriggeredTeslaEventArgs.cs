namespace LabApi.Events.Arguments.PlayerEvents
{
	public class PlayerTriggeredTeslaEventArgs : global::System.EventArgs, global::LabApi.Events.Arguments.Interfaces.IPlayerEvent, global::LabApi.Events.Arguments.Interfaces.ITeslaEvent
	{
		public global::LabApi.Features.Wrappers.Player Player { get; }

		public global::LabApi.Features.Wrappers.Tesla Tesla { get; }

		public PlayerTriggeredTeslaEventArgs(ReferenceHub hub, TeslaGate gate)
		{
			Player = global::LabApi.Features.Wrappers.Player.Get(hub);
			Tesla = global::LabApi.Features.Wrappers.Tesla.Get(gate);
		}
	}
}
