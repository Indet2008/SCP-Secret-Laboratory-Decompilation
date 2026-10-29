namespace LabApi.Events.Arguments.PlayerEvents
{
	public class PlayerInteractingScp330EventArgs : global::System.EventArgs, global::LabApi.Events.Arguments.Interfaces.IPlayerEvent, global::LabApi.Events.Arguments.Interfaces.ICancellableEvent
	{
		public global::LabApi.Features.Wrappers.Player Player { get; }

		public int Uses { get; set; }

		public bool PlaySound { get; set; }

		public bool AllowPunishment { get; set; }

		public global::InventorySystem.Items.Usables.Scp330.CandyKindID CandyType { get; set; }

		public bool IsAllowed { get; set; }

		public PlayerInteractingScp330EventArgs(ReferenceHub hub, int uses, bool playSound, bool allowPunishment, global::InventorySystem.Items.Usables.Scp330.CandyKindID type)
		{
			IsAllowed = true;
			Player = global::LabApi.Features.Wrappers.Player.Get(hub);
			Uses = uses;
			PlaySound = playSound;
			AllowPunishment = allowPunishment;
			CandyType = type;
		}
	}
}
