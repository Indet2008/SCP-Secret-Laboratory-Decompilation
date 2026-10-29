namespace LabApi.Events.Arguments.Interfaces
{
	public interface ITantrumEvent : global::LabApi.Events.Arguments.Interfaces.IHazardEvent
	{
		global::LabApi.Features.Wrappers.Hazard? global::LabApi.Events.Arguments.Interfaces.IHazardEvent.Hazard => Tantrum;

		global::LabApi.Features.Wrappers.TantrumHazard? Tantrum { get; }
	}
}
