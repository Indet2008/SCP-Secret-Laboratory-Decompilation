namespace LabApi.Events.Arguments.PlayerEvents
{
	public class PlayerIdlingTeslaEventArgs : global::System.EventArgs, global::LabApi.Events.Arguments.Interfaces.IPlayerEvent, global::LabApi.Events.Arguments.Interfaces.ITeslaEvent, global::LabApi.Events.Arguments.Interfaces.ICancellableEvent
	{
		public global::LabApi.Features.Wrappers.Player Player { get; }

		public global::LabApi.Features.Wrappers.Tesla Tesla { get; }

		public bool IsAllowed { get; set; }

		public PlayerIdlingTeslaEventArgs(ReferenceHub hub, TeslaGate gate)
		{
			IsAllowed = true;
			Player = global::LabApi.Features.Wrappers.Player.Get(hub);
			Tesla = global::LabApi.Features.Wrappers.Tesla.Get(gate);
		}
	}
}
