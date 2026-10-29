namespace LabApi.Events.Arguments.Interfaces
{
	public interface ILightItemEvent : global::LabApi.Events.Arguments.Interfaces.IItemEvent
	{
		global::LabApi.Features.Wrappers.Item? global::LabApi.Events.Arguments.Interfaces.IItemEvent.Item => LightItem;

		global::LabApi.Features.Wrappers.LightItem? LightItem { get; }
	}
}
