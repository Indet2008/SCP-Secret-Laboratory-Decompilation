namespace LabApi.Events.Arguments.Interfaces
{
	public interface ICandyItemEvent : global::LabApi.Events.Arguments.Interfaces.IItemEvent
	{
		global::LabApi.Features.Wrappers.Item? global::LabApi.Events.Arguments.Interfaces.IItemEvent.Item => CandyItem;

		global::LabApi.Features.Wrappers.Scp330Item? CandyItem { get; }
	}
}
