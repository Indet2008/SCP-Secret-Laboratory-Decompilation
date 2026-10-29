namespace LabApi.Events.Arguments.Interfaces
{
	public interface IScp127ItemEvent : global::LabApi.Events.Arguments.Interfaces.IItemEvent
	{
		global::LabApi.Features.Wrappers.Item? global::LabApi.Events.Arguments.Interfaces.IItemEvent.Item => Scp127Item;

		global::LabApi.Features.Wrappers.Scp127Firearm? Scp127Item { get; }
	}
}
