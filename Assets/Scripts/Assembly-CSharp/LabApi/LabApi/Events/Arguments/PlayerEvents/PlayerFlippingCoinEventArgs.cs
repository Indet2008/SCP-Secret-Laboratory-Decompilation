namespace LabApi.Events.Arguments.PlayerEvents
{
	public class PlayerFlippingCoinEventArgs : global::System.EventArgs, global::LabApi.Events.Arguments.Interfaces.ICancellableEvent, global::LabApi.Events.Arguments.Interfaces.ICoinItemEvent, global::LabApi.Events.Arguments.Interfaces.IItemEvent, global::LabApi.Events.Arguments.Interfaces.IPlayerEvent
	{
		public global::LabApi.Features.Wrappers.Player Player { get; }

		public global::LabApi.Features.Wrappers.CoinItem CoinItem { get; }

		public bool IsTails { get; set; }

		public bool IsAllowed { get; set; }

		[global::System.Obsolete("Use CoinItem instead")]
		public global::LabApi.Features.Wrappers.Item Item => CoinItem;

		public PlayerFlippingCoinEventArgs(ReferenceHub hub, global::InventorySystem.Items.Coin.Coin coin, bool isTails)
		{
			Player = global::LabApi.Features.Wrappers.Player.Get(hub);
			CoinItem = global::LabApi.Features.Wrappers.CoinItem.Get(coin);
			IsTails = isTails;
			IsAllowed = true;
		}
	}
}
