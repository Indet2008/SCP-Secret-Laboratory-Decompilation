namespace LabApi.Events.Arguments.PlayerEvents
{
	public class PlayerOpeningGeneratorEventArgs : global::System.EventArgs, global::LabApi.Events.Arguments.Interfaces.IPlayerEvent, global::LabApi.Events.Arguments.Interfaces.IGeneratorEvent, global::LabApi.Events.Arguments.Interfaces.IStructureEvent, global::LabApi.Events.Arguments.Interfaces.ICancellableEvent
	{
		public global::LabApi.Features.Wrappers.Player Player { get; }

		public global::LabApi.Features.Wrappers.Generator Generator { get; }

		public bool PlayDeniedAnimation { get; set; }

		public bool IsAllowed { get; set; }

		public PlayerOpeningGeneratorEventArgs(ReferenceHub hub, global::MapGeneration.Distributors.Scp079Generator generator)
		{
			IsAllowed = true;
			Player = global::LabApi.Features.Wrappers.Player.Get(hub);
			Generator = global::LabApi.Features.Wrappers.Generator.Get(generator);
		}
	}
}
