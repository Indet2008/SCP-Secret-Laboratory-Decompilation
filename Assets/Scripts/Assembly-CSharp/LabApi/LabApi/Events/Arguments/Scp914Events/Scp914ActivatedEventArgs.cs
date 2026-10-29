namespace LabApi.Events.Arguments.Scp914Events
{
	public class Scp914ActivatedEventArgs : global::System.EventArgs, global::LabApi.Events.Arguments.Interfaces.IScp914Event, global::LabApi.Events.Arguments.Interfaces.IPlayerEvent
	{
		public global::Scp914.Scp914KnobSetting KnobSetting { get; }

		public global::LabApi.Features.Wrappers.Player Player { get; }

		public Scp914ActivatedEventArgs(global::Scp914.Scp914KnobSetting knobSetting, ReferenceHub hub)
		{
			KnobSetting = knobSetting;
			Player = global::LabApi.Features.Wrappers.Player.Get(hub);
		}
	}
}
