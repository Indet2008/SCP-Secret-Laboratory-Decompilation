namespace LabApi.Events.Arguments.Interfaces.Items
{
	public interface IJailbirdEvent : global::LabApi.Events.Arguments.Interfaces.IItemEvent
	{
		global::LabApi.Features.Wrappers.Item? global::LabApi.Events.Arguments.Interfaces.IItemEvent.Item => JailbirdItem;

		global::LabApi.Features.Wrappers.JailbirdItem? JailbirdItem { get; }
	}
}
