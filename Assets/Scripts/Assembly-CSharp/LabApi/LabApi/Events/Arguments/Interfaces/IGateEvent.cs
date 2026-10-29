namespace LabApi.Events.Arguments.Interfaces
{
	public interface IGateEvent : global::LabApi.Events.Arguments.Interfaces.IDoorEvent
	{
		global::LabApi.Features.Wrappers.Door? global::LabApi.Events.Arguments.Interfaces.IDoorEvent.Door => Gate;

		global::LabApi.Features.Wrappers.Gate Gate { get; }
	}
}
