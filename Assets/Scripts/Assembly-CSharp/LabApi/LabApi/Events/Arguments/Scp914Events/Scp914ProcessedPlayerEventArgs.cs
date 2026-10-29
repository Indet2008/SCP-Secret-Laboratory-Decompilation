namespace LabApi.Events.Arguments.Scp914Events
{
	public class Scp914ProcessedPlayerEventArgs : global::System.EventArgs, global::LabApi.Events.Arguments.Interfaces.IScp914Event, global::LabApi.Events.Arguments.Interfaces.IPlayerEvent
	{
		public global::UnityEngine.Vector3 NewPosition { get; }

		public global::Scp914.Scp914KnobSetting KnobSetting { get; }

		public global::LabApi.Features.Wrappers.Player Player { get; }

		public Scp914ProcessedPlayerEventArgs(global::UnityEngine.Vector3 newPosition, global::Scp914.Scp914KnobSetting knobSetting, ReferenceHub hub)
		{
			NewPosition = newPosition;
			KnobSetting = knobSetting;
			Player = global::LabApi.Features.Wrappers.Player.Get(hub);
		}
	}
}
