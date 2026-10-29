namespace LabApi.Events.Arguments.Interfaces
{
	public interface ICancellableEvent
	{
		bool IsAllowed { get; set; }
	}
}
