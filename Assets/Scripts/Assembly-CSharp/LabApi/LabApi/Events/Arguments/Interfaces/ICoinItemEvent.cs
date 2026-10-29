namespace LabApi.Events.Arguments.Interfaces
{
	public interface ICoinItemEvent : global::LabApi.Events.Arguments.Interfaces.IItemEvent
	{
		global::LabApi.Features.Wrappers.Item? global::LabApi.Events.Arguments.Interfaces.IItemEvent.Item => CoinItem;

		global::LabApi.Features.Wrappers.CoinItem? CoinItem { get; }
	}
}
