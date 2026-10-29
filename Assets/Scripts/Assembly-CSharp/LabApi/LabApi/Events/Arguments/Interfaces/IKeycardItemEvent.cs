namespace LabApi.Events.Arguments.Interfaces
{
	public interface IKeycardItemEvent : global::LabApi.Events.Arguments.Interfaces.IItemEvent
	{
		global::LabApi.Features.Wrappers.Item? global::LabApi.Events.Arguments.Interfaces.IItemEvent.Item => KeycardItem;

		global::LabApi.Features.Wrappers.KeycardItem KeycardItem { get; }
	}
}
