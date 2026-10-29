namespace LabApi.Events.Arguments.Scp914Events
{
	public class Scp914KnobChangedEventArgs : global::System.EventArgs, global::LabApi.Events.Arguments.Interfaces.IScp914Event, global::LabApi.Events.Arguments.Interfaces.IPlayerEvent
	{
		public global::Scp914.Scp914KnobSetting OldKnobSetting { get; }

		public global::Scp914.Scp914KnobSetting KnobSetting { get; }

		public global::LabApi.Features.Wrappers.Player Player { get; }

		public Scp914KnobChangedEventArgs(global::Scp914.Scp914KnobSetting oldKnobSetting, global::Scp914.Scp914KnobSetting knobSetting, ReferenceHub hub)
		{
			OldKnobSetting = oldKnobSetting;
			KnobSetting = knobSetting;
			Player = global::LabApi.Features.Wrappers.Player.Get(hub);
		}
	}
}
