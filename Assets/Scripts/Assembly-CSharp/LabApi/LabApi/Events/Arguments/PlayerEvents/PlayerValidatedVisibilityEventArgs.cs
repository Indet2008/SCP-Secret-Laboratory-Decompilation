namespace LabApi.Events.Arguments.PlayerEvents
{
	public class PlayerValidatedVisibilityEventArgs : global::System.EventArgs, global::LabApi.Events.Arguments.Interfaces.IPlayerEvent, global::LabApi.Events.Arguments.Interfaces.ITargetEvent
	{
		public global::LabApi.Features.Wrappers.Player Player { get; }

		public global::LabApi.Features.Wrappers.Player Target { get; }

		public bool IsVisible { get; set; }

		public PlayerValidatedVisibilityEventArgs(ReferenceHub observer, ReferenceHub target, bool isVisible)
		{
			Player = global::LabApi.Features.Wrappers.Player.Get(observer);
			Target = global::LabApi.Features.Wrappers.Player.Get(target);
			IsVisible = isVisible;
		}
	}
}
