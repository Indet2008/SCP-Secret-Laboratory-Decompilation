namespace LabApi.Events.Arguments.ServerEvents
{
	public class GeneratorActivatingEventArgs : global::System.EventArgs, global::LabApi.Events.Arguments.Interfaces.IGeneratorEvent, global::LabApi.Events.Arguments.Interfaces.IStructureEvent, global::LabApi.Events.Arguments.Interfaces.ICancellableEvent
	{
		public global::LabApi.Features.Wrappers.Generator Generator { get; }

		public bool IsAllowed { get; set; }

		public GeneratorActivatingEventArgs(global::MapGeneration.Distributors.Scp079Generator generator)
		{
			IsAllowed = true;
			Generator = global::LabApi.Features.Wrappers.Generator.Get(generator);
		}
	}
}
