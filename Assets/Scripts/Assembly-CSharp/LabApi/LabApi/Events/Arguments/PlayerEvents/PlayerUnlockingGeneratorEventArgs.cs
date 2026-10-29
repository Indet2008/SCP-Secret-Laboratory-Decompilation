namespace LabApi.Events.Arguments.PlayerEvents
{
	public class PlayerUnlockingGeneratorEventArgs : global::System.EventArgs, global::LabApi.Events.Arguments.Interfaces.IPlayerEvent, global::LabApi.Events.Arguments.Interfaces.IGeneratorEvent, global::LabApi.Events.Arguments.Interfaces.IStructureEvent, global::LabApi.Events.Arguments.Interfaces.ICancellableEvent
	{
		public global::LabApi.Features.Wrappers.Player Player { get; }

		public global::LabApi.Features.Wrappers.Generator Generator { get; }

		public bool CanOpen { get; set; }

		public bool IsAllowed { get; set; }

		public PlayerUnlockingGeneratorEventArgs(ReferenceHub hub, global::MapGeneration.Distributors.Scp079Generator generator, bool canOpen)
		{
			Player = global::LabApi.Features.Wrappers.Player.Get(hub);
			Generator = global::LabApi.Features.Wrappers.Generator.Get(generator);
			IsAllowed = true;
			CanOpen = canOpen;
		}
	}
}
