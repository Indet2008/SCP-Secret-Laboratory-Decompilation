namespace LabApi.Events.Arguments.Interfaces
{
	public interface IAmnesticCloudEvent : global::LabApi.Events.Arguments.Interfaces.IHazardEvent
	{
		global::LabApi.Features.Wrappers.Hazard? global::LabApi.Events.Arguments.Interfaces.IHazardEvent.Hazard => AmnesticCloud;

		global::LabApi.Features.Wrappers.AmnesticCloudHazard? AmnesticCloud { get; }
	}
}
