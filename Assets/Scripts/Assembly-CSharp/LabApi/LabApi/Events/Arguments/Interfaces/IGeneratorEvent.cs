namespace LabApi.Events.Arguments.Interfaces
{
	public interface IGeneratorEvent : global::LabApi.Events.Arguments.Interfaces.IStructureEvent
	{
		global::LabApi.Features.Wrappers.Structure? global::LabApi.Events.Arguments.Interfaces.IStructureEvent.Structure => Generator;

		global::LabApi.Features.Wrappers.Generator? Generator { get; }
	}
}
