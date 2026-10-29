namespace LabApi.Features.Wrappers
{
	public class CoinItem : global::LabApi.Features.Wrappers.Item
	{
		public new static global::System.Collections.Generic.Dictionary<global::InventorySystem.Items.Coin.Coin, global::LabApi.Features.Wrappers.CoinItem> Dictionary { get; } = new global::System.Collections.Generic.Dictionary<global::InventorySystem.Items.Coin.Coin, global::LabApi.Features.Wrappers.CoinItem>();

		public new static global::System.Collections.Generic.IReadOnlyCollection<global::LabApi.Features.Wrappers.CoinItem> List => Dictionary.Values;

		public new global::InventorySystem.Items.Coin.Coin Base { get; }

		public bool? LastFlipResult
		{
			get
			{
				if (!global::InventorySystem.Items.Coin.Coin.FlipTimes.TryGetValue(base.Serial, out var value))
				{
					return null;
				}
				return value > 0.0;
			}
		}

		public double? LastFlipTime
		{
			get
			{
				if (!global::InventorySystem.Items.Coin.Coin.FlipTimes.TryGetValue(base.Serial, out var value))
				{
					return null;
				}
				return global::System.Math.Abs(value);
			}
		}

		[return: global::System.Diagnostics.CodeAnalysis.NotNullIfNotNull("coin")]
		public static global::LabApi.Features.Wrappers.CoinItem? Get(global::InventorySystem.Items.Coin.Coin? coin)
		{
			if (coin == null)
			{
				return null;
			}
			if (!Dictionary.TryGetValue(coin, out global::LabApi.Features.Wrappers.CoinItem value))
			{
				return (global::LabApi.Features.Wrappers.CoinItem)global::LabApi.Features.Wrappers.Item.CreateItemWrapper(coin);
			}
			return value;
		}

		internal CoinItem(global::InventorySystem.Items.Coin.Coin coin)
			: base(coin)
		{
			Base = coin;
			if (base.CanCache)
			{
				Dictionary.Add(coin, this);
			}
		}

		internal override void OnRemove()
		{
			base.OnRemove();
			Dictionary.Remove(Base);
		}
	}
}
