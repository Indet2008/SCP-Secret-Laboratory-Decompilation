namespace LabApi.Events.Arguments.Scp173Events
{
	public class Scp173CreatedTantrumEventArgs : global::System.EventArgs, global::LabApi.Events.Arguments.Interfaces.IPlayerEvent, global::LabApi.Events.Arguments.Interfaces.ITantrumEvent, global::LabApi.Events.Arguments.Interfaces.IHazardEvent
	{
		public global::LabApi.Features.Wrappers.TantrumHazard Tantrum { get; }

		public global::LabApi.Features.Wrappers.Player Player { get; }

		[global::System.Obsolete("Use Tantrum instead")]
		public global::Hazards.TantrumEnvironmentalHazard TantrumInstance => Tantrum.Base;

		public Scp173CreatedTantrumEventArgs(global::Hazards.TantrumEnvironmentalHazard tantrumInstance, ReferenceHub hub)
		{
			Tantrum = global::LabApi.Features.Wrappers.TantrumHazard.Get(tantrumInstance);
			Player = global::LabApi.Features.Wrappers.Player.Get(hub);
		}
	}
}
