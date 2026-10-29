namespace LabApi.Events.Arguments.Interfaces
{
	public interface IUsableItemEvent : global::LabApi.Events.Arguments.Interfaces.IItemEvent
	{
		global::LabApi.Features.Wrappers.Item? global::LabApi.Events.Arguments.Interfaces.IItemEvent.Item => UsableItem;

		global::LabApi.Features.Wrappers.UsableItem? UsableItem { get; }
	}
}
