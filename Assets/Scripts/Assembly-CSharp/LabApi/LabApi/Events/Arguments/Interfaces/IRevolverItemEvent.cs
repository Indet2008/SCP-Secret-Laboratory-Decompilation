namespace LabApi.Events.Arguments.Interfaces
{
	public interface IRevolverItemEvent : global::LabApi.Events.Arguments.Interfaces.IItemEvent
	{
		global::LabApi.Features.Wrappers.Item? global::LabApi.Events.Arguments.Interfaces.IItemEvent.Item => Revolver;

		global::LabApi.Features.Wrappers.RevolverFirearm? Revolver { get; }
	}
}
