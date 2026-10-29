namespace LabApi.Events.Arguments.Scp079Events
{
	public class Scp079UsingTeslaEventArgs : global::System.EventArgs, global::LabApi.Events.Arguments.Interfaces.IPlayerEvent, global::LabApi.Events.Arguments.Interfaces.ITeslaEvent, global::LabApi.Events.Arguments.Interfaces.ICancellableEvent
	{
		public global::LabApi.Features.Wrappers.Player Player { get; }

		public global::LabApi.Features.Wrappers.Tesla Tesla { get; }

		public bool IsAllowed { get; set; }

		public Scp079UsingTeslaEventArgs(ReferenceHub hub, TeslaGate tesla)
		{
			Player = global::LabApi.Features.Wrappers.Player.Get(hub);
			Tesla = global::LabApi.Features.Wrappers.Tesla.Get(tesla);
			IsAllowed = true;
		}
	}
}
