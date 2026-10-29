namespace LabApi.Events.Arguments.PlayerEvents
{
	public class PlayerDroppingAmmoEventArgs : global::System.EventArgs, global::LabApi.Events.Arguments.Interfaces.ICancellableEvent, global::LabApi.Events.Arguments.Interfaces.IPlayerEvent
	{
		public global::LabApi.Features.Wrappers.Player Player { get; }

		public ItemType Type { get; set; }

		public int Amount { get; set; }

		public bool IsAllowed { get; set; }

		public PlayerDroppingAmmoEventArgs(ReferenceHub hub, ItemType type, int amount)
		{
			IsAllowed = true;
			Player = global::LabApi.Features.Wrappers.Player.Get(hub);
			Type = type;
			Amount = amount;
		}
	}
}
