namespace LabApi.Events.Arguments.Interfaces
{
	public interface IBodyArmorItemEvent : global::LabApi.Events.Arguments.Interfaces.IItemEvent
	{
		global::LabApi.Features.Wrappers.Item? global::LabApi.Events.Arguments.Interfaces.IItemEvent.Item => BodyArmorItem;

		global::LabApi.Features.Wrappers.BodyArmorItem? BodyArmorItem { get; }
	}
}
