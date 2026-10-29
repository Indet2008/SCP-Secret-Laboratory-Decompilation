namespace LabApi.Events.Arguments.PlayerEvents
{
	public class PlayerClosedGeneratorEventArgs : global::System.EventArgs, global::LabApi.Events.Arguments.Interfaces.IPlayerEvent, global::LabApi.Events.Arguments.Interfaces.IGeneratorEvent, global::LabApi.Events.Arguments.Interfaces.IStructureEvent
	{
		public global::LabApi.Features.Wrappers.Player Player { get; }

		public global::LabApi.Features.Wrappers.Generator Generator { get; }

		public PlayerClosedGeneratorEventArgs(ReferenceHub hub, global::MapGeneration.Distributors.Scp079Generator generator)
		{
			Player = global::LabApi.Features.Wrappers.Player.Get(hub);
			Generator = global::LabApi.Features.Wrappers.Generator.Get(generator);
		}
	}
}
