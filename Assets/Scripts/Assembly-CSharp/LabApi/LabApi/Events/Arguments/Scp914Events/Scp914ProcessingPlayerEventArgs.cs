namespace LabApi.Events.Arguments.Scp914Events
{
	public class Scp914ProcessingPlayerEventArgs : global::System.EventArgs, global::LabApi.Events.Arguments.Interfaces.IScp914Event, global::LabApi.Events.Arguments.Interfaces.IPlayerEvent, global::LabApi.Events.Arguments.Interfaces.ICancellableEvent
	{
		public global::UnityEngine.Vector3 NewPosition { get; set; }

		public global::Scp914.Scp914KnobSetting KnobSetting { get; set; }

		public global::LabApi.Features.Wrappers.Player Player { get; }

		public bool IsAllowed { get; set; }

		public Scp914ProcessingPlayerEventArgs(global::UnityEngine.Vector3 newPosition, global::Scp914.Scp914KnobSetting knobSetting, ReferenceHub hub)
		{
			IsAllowed = true;
			NewPosition = newPosition;
			KnobSetting = knobSetting;
			Player = global::LabApi.Features.Wrappers.Player.Get(hub);
		}
	}
}
