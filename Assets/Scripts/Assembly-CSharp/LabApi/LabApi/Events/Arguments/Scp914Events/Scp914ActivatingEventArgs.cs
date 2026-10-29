namespace LabApi.Events.Arguments.Scp914Events
{
	public class Scp914ActivatingEventArgs : global::System.EventArgs, global::LabApi.Events.Arguments.Interfaces.IScp914Event, global::LabApi.Events.Arguments.Interfaces.IPlayerEvent, global::LabApi.Events.Arguments.Interfaces.ICancellableEvent
	{
		public global::Scp914.Scp914KnobSetting KnobSetting { get; set; }

		public global::LabApi.Features.Wrappers.Player Player { get; }

		public bool IsAllowed { get; set; }

		public Scp914ActivatingEventArgs(global::Scp914.Scp914KnobSetting knobSetting, ReferenceHub hub)
		{
			IsAllowed = true;
			KnobSetting = knobSetting;
			Player = global::LabApi.Features.Wrappers.Player.Get(hub);
		}
	}
}
