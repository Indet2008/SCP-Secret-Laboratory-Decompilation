namespace LabApi.Events.Arguments.PlayerEvents
{
	public class PlayerInteractedScp330EventArgs : global::System.EventArgs, global::LabApi.Events.Arguments.Interfaces.IPlayerEvent
	{
		public global::LabApi.Features.Wrappers.Player Player { get; }

		public int Uses { get; }

		public bool PlaySound { get; }

		public bool AllowPunishment { get; }

		public global::InventorySystem.Items.Usables.Scp330.CandyKindID CandyType { get; }

		public PlayerInteractedScp330EventArgs(ReferenceHub hub, int uses, bool playSound, bool allowPunishment, global::InventorySystem.Items.Usables.Scp330.CandyKindID type)
		{
			Player = global::LabApi.Features.Wrappers.Player.Get(hub);
			Uses = uses;
			PlaySound = playSound;
			AllowPunishment = allowPunishment;
			CandyType = type;
		}
	}
}
