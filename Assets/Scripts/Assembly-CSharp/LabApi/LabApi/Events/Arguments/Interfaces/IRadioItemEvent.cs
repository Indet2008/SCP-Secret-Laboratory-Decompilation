namespace LabApi.Events.Arguments.Interfaces
{
	public interface IRadioItemEvent : global::LabApi.Events.Arguments.Interfaces.IItemEvent
	{
		global::LabApi.Features.Wrappers.Item? global::LabApi.Events.Arguments.Interfaces.IItemEvent.Item => RadioItem;

		global::LabApi.Features.Wrappers.RadioItem? RadioItem { get; }
	}
}
