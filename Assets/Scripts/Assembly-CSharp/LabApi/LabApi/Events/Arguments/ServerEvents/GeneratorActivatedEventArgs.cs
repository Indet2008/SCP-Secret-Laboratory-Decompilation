namespace LabApi.Events.Arguments.ServerEvents
{
	public class GeneratorActivatedEventArgs : global::System.EventArgs, global::LabApi.Events.Arguments.Interfaces.IGeneratorEvent, global::LabApi.Events.Arguments.Interfaces.IStructureEvent
	{
		public global::LabApi.Features.Wrappers.Generator Generator { get; }

		public GeneratorActivatedEventArgs(global::MapGeneration.Distributors.Scp079Generator generator)
		{
			Generator = global::LabApi.Features.Wrappers.Generator.Get(generator);
		}
	}
}
