namespace LabApi.Events.Arguments.Interfaces
{
	public interface IThrowableItemEvent : global::LabApi.Events.Arguments.Interfaces.IItemEvent
	{
		global::LabApi.Features.Wrappers.Item? global::LabApi.Events.Arguments.Interfaces.IItemEvent.Item => ThrowableItem;

		global::LabApi.Features.Wrappers.ThrowableItem? ThrowableItem { get; }
	}
}
