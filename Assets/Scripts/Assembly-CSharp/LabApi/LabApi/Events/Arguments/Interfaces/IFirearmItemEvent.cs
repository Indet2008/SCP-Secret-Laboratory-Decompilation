namespace LabApi.Events.Arguments.Interfaces
{
	public interface IFirearmItemEvent : global::LabApi.Events.Arguments.Interfaces.IItemEvent
	{
		global::LabApi.Features.Wrappers.Item? global::LabApi.Events.Arguments.Interfaces.IItemEvent.Item => FirearmItem;

		global::LabApi.Features.Wrappers.FirearmItem? FirearmItem { get; }
	}
}
