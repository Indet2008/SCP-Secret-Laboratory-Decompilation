namespace LabApi.Events.Arguments.Interfaces
{
	public interface ILockerEvent : global::LabApi.Events.Arguments.Interfaces.IStructureEvent
	{
		global::LabApi.Features.Wrappers.Structure? global::LabApi.Events.Arguments.Interfaces.IStructureEvent.Structure => Locker;

		global::LabApi.Features.Wrappers.Locker? Locker { get; }
	}
}
