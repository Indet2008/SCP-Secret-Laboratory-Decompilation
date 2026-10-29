namespace LabApi.Events.Arguments.PlayerEvents
{
	public class PlayerToggledNoclipEventArgs : global::System.EventArgs, global::LabApi.Events.Arguments.Interfaces.IPlayerEvent
	{
		public global::LabApi.Features.Wrappers.Player Player { get; }

		public bool IsNoclipping { get; }

		public PlayerToggledNoclipEventArgs(ReferenceHub hub, bool isNoclipping)
		{
			Player = global::LabApi.Features.Wrappers.Player.Get(hub);
			IsNoclipping = isNoclipping;
		}
	}
}
