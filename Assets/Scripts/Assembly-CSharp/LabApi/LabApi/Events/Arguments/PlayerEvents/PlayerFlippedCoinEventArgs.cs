namespace LabApi.Events.Arguments.PlayerEvents
{
	public class PlayerFlippedCoinEventArgs : global::System.EventArgs, global::LabApi.Events.Arguments.Interfaces.IPlayerEvent, global::LabApi.Events.Arguments.Interfaces.ICoinItemEvent, global::LabApi.Events.Arguments.Interfaces.IItemEvent
	{
		public global::LabApi.Features.Wrappers.Player Player { get; }

		public global::LabApi.Features.Wrappers.CoinItem CoinItem { get; }

		public bool IsTails { get; }

		[global::System.Obsolete("Use CoinItem instead")]
		public global::LabApi.Features.Wrappers.Item Item => CoinItem;

		public PlayerFlippedCoinEventArgs(ReferenceHub hub, global::InventorySystem.Items.Coin.Coin coin, bool isTails)
		{
			Player = global::LabApi.Features.Wrappers.Player.Get(hub);
			CoinItem = global::LabApi.Features.Wrappers.CoinItem.Get(coin);
			IsTails = isTails;
		}
	}
}
