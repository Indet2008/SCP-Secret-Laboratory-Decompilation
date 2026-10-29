namespace LabApi.Features.Wrappers
{
	public class Item
	{
		private static readonly global::System.Collections.Generic.Dictionary<global::System.Type, global::System.Func<global::InventorySystem.Items.ItemBase, global::LabApi.Features.Wrappers.Item>> TypeWrappers = new global::System.Collections.Generic.Dictionary<global::System.Type, global::System.Func<global::InventorySystem.Items.ItemBase, global::LabApi.Features.Wrappers.Item>>();

		public static global::System.Collections.Generic.Dictionary<global::InventorySystem.Items.ItemBase, global::LabApi.Features.Wrappers.Item> Dictionary { get; } = new global::System.Collections.Generic.Dictionary<global::InventorySystem.Items.ItemBase, global::LabApi.Features.Wrappers.Item>();

		public static global::System.Collections.Generic.IReadOnlyCollection<global::LabApi.Features.Wrappers.Item> List => Dictionary.Values;

		private static global::System.Collections.Generic.Dictionary<ushort, global::LabApi.Features.Wrappers.Item> SerialsCache { get; } = new global::System.Collections.Generic.Dictionary<ushort, global::LabApi.Features.Wrappers.Item>();

		public global::InventorySystem.Items.ItemBase Base { get; }

		public global::UnityEngine.GameObject GameObject => Base.gameObject;

		public bool IsDestroyed
		{
			get
			{
				if (!(Base == null))
				{
					return GameObject == null;
				}
				return true;
			}
		}

		public bool IsPrefab { get; }

		public ItemType Type => Base.ItemTypeId;

		public ItemCategory Category
		{
			get
			{
				return Base.Category;
			}
			set
			{
				Base.Category = value;
			}
		}

		public ItemTierFlags TierFlags
		{
			get
			{
				return Base.TierFlags;
			}
			set
			{
				Base.TierFlags = value;
			}
		}

		public global::InventorySystem.Items.ItemThrowSettings ThrowSettings
		{
			get
			{
				return Base.ThrowSettings;
			}
			set
			{
				Base.ThrowSettings = value;
			}
		}

		public global::InventorySystem.Items.ItemAddReason AddReason => Base.ServerAddReason;

		public bool IsEquipped => Base.IsEquipped;

		public bool CanEquip => Base.AllowEquip;

		public bool CanHolster => Base.AllowHolster;

		public bool CanDrop => Base.AllowDropping;

		public global::LabApi.Features.Wrappers.Player? CurrentOwner => global::LabApi.Features.Wrappers.Player.Get(Base.Owner);

		public ushort Serial => Base.ItemSerial;

		public float Weight => Base.Weight;

		protected bool CanCache
		{
			get
			{
				if (!IsDestroyed && !IsPrefab && Serial != 0)
				{
					return Base.isActiveAndEnabled;
				}
				return false;
			}
		}

		[return: global::System.Diagnostics.CodeAnalysis.NotNullIfNotNull("itemBase")]
		public static global::LabApi.Features.Wrappers.Item? Get(global::InventorySystem.Items.ItemBase? itemBase)
		{
			if (itemBase == null)
			{
				return null;
			}
			if (!Dictionary.TryGetValue(itemBase, out global::LabApi.Features.Wrappers.Item value))
			{
				return CreateItemWrapper(itemBase);
			}
			return value;
		}

		public static bool TryGet(global::InventorySystem.Items.ItemBase? itemBase, [global::System.Diagnostics.CodeAnalysis.NotNullWhen(true)] out global::LabApi.Features.Wrappers.Item? item)
		{
			item = Get(itemBase);
			return item != null;
		}

		public static global::LabApi.Features.Wrappers.Item? Get(ushort serial)
		{
			if (!TryGet(serial, out global::LabApi.Features.Wrappers.Item item))
			{
				return null;
			}
			return item;
		}

		public static bool TryGet(ushort serial, [global::System.Diagnostics.CodeAnalysis.NotNullWhen(true)] out global::LabApi.Features.Wrappers.Item? item)
		{
			item = null;
			if (SerialsCache.TryGetValue(serial, out item))
			{
				return true;
			}
			item = global::System.Linq.Enumerable.FirstOrDefault(List, (global::LabApi.Features.Wrappers.Item x) => x.Serial == serial);
			if (item == null)
			{
				return false;
			}
			SerialsCache[serial] = item;
			return true;
		}

		public static global::System.Collections.Generic.List<global::LabApi.Features.Wrappers.Item> GetAll(ItemType type)
		{
			global::System.Collections.Generic.List<global::LabApi.Features.Wrappers.Item> list = global::NorthwoodLib.Pools.ListPool<global::LabApi.Features.Wrappers.Item>.Shared.Rent();
			list.AddRange(global::System.Linq.Enumerable.Where(List, (global::LabApi.Features.Wrappers.Item n) => n.Type == type));
			return list;
		}

		public static global::System.Collections.Generic.List<global::LabApi.Features.Wrappers.Item> GetAll(ItemCategory category)
		{
			global::System.Collections.Generic.List<global::LabApi.Features.Wrappers.Item> list = global::NorthwoodLib.Pools.ListPool<global::LabApi.Features.Wrappers.Item>.Shared.Rent();
			list.AddRange(global::System.Linq.Enumerable.Where(List, (global::LabApi.Features.Wrappers.Item n) => n.Category == category));
			return list;
		}

		[global::Generators.InitializeWrapper(128)]
		internal static void Initialize()
		{
			Dictionary.Clear();
			global::InventorySystem.Items.ItemBase.OnItemAdded += AddItem;
			global::InventorySystem.Items.ItemBase.OnItemRemoved += RemoveItem;
			Register((global::InventorySystem.Items.ItemBase x) => new global::LabApi.Features.Wrappers.Item(x));
			Register((global::InventorySystem.Items.Usables.Consumable x) => new global::LabApi.Features.Wrappers.ConsumableItem(x));
			Register((global::InventorySystem.Items.Usables.Scp500 x) => new global::LabApi.Features.Wrappers.Scp500Item(x));
			Register((global::InventorySystem.Items.Usables.Scp1853Item x) => new global::LabApi.Features.Wrappers.Scp1853Item(x));
			Register((global::InventorySystem.Items.Usables.Painkillers x) => new global::LabApi.Features.Wrappers.PainkillersItem(x));
			Register((global::InventorySystem.Items.Usables.Adrenaline x) => new global::LabApi.Features.Wrappers.AdrenalineItem(x));
			Register((global::InventorySystem.Items.Usables.Medkit x) => new global::LabApi.Features.Wrappers.MedkitItem(x));
			Register((global::InventorySystem.Items.Usables.Scp207 x) => new global::LabApi.Features.Wrappers.Scp207Item(x));
			Register((global::InventorySystem.Items.Usables.AntiScp207 x) => new global::LabApi.Features.Wrappers.AntiScp207Item(x));
			Register((global::InventorySystem.Items.Usables.Scp021J x) => new global::LabApi.Features.Wrappers.Scp021JItem(x));
			Register((global::InventorySystem.Items.Usables.UsableItem x) => new global::LabApi.Features.Wrappers.UsableItem(x));
			Register((global::InventorySystem.Items.Usables.Scp1576.Scp1576Item x) => new global::LabApi.Features.Wrappers.Scp1576Item(x));
			Register((global::InventorySystem.Items.Usables.Scp330.Scp330Bag x) => new global::LabApi.Features.Wrappers.Scp330Item(x));
			Register((global::InventorySystem.Items.Usables.Scp244.Scp244Item x) => new global::LabApi.Features.Wrappers.Scp244Item(x));
			Register((global::InventorySystem.Items.Usables.Scp268 x) => new global::LabApi.Features.Wrappers.Scp268Item(x));
			Register((global::InventorySystem.Items.Usables.Scp1344.Scp1344Item x) => new global::LabApi.Features.Wrappers.Scp1344Item(x));
			Register((global::InventorySystem.Items.Scp1509.Scp1509Item x) => new global::LabApi.Features.Wrappers.Scp1509Item(x));
			Register<global::InventorySystem.Items.Firearms.Firearm>(global::LabApi.Features.Wrappers.FirearmItem.CreateFirearmWrapper);
			Register<global::InventorySystem.Items.Firearms.ParticleDisruptor>(global::LabApi.Features.Wrappers.FirearmItem.CreateFirearmWrapper);
			Register((global::InventorySystem.Items.Jailbird.JailbirdItem x) => new global::LabApi.Features.Wrappers.JailbirdItem(x));
			Register((global::InventorySystem.Items.Coin.Coin x) => new global::LabApi.Features.Wrappers.CoinItem(x));
			Register((global::InventorySystem.Items.MarshmallowMan.MarshmallowItem x) => new global::LabApi.Features.Wrappers.MarshmallowItem(x));
			Register((global::InventorySystem.Items.ToggleableLights.ToggleableLightItemBase x) => new global::LabApi.Features.Wrappers.LightItem(x));
			Register((global::InventorySystem.Items.ToggleableLights.Flashlight.FlashlightItem x) => new global::LabApi.Features.Wrappers.FlashlightItem(x));
			Register((global::InventorySystem.Items.ToggleableLights.Lantern.LanternItem x) => new global::LabApi.Features.Wrappers.LanternItem(x));
			Register((global::InventorySystem.Items.Radio.RadioItem x) => new global::LabApi.Features.Wrappers.RadioItem(x));
			Register((global::InventorySystem.Items.Firearms.Ammo.AmmoItem x) => new global::LabApi.Features.Wrappers.AmmoItem(x));
			Register((global::InventorySystem.Items.Armor.BodyArmor x) => new global::LabApi.Features.Wrappers.BodyArmorItem(x));
			Register((global::InventorySystem.Items.ThrowableProjectiles.ThrowableItem x) => new global::LabApi.Features.Wrappers.ThrowableItem(x));
			Register((global::InventorySystem.Items.ThrowableProjectiles.SnowballItem x) => new global::LabApi.Features.Wrappers.SnowballItem(x));
			Register((global::InventorySystem.Items.Keycards.KeycardItem x) => new global::LabApi.Features.Wrappers.KeycardItem(x));
			Register((global::InventorySystem.Items.Keycards.ChaosKeycardItem x) => new global::LabApi.Features.Wrappers.KeycardItem(x));
			Register((global::InventorySystem.Items.Keycards.SingleUseKeycardItem x) => new global::LabApi.Features.Wrappers.KeycardItem(x));
			Register((global::InventorySystem.Items.MicroHID.MicroHIDItem x) => new global::LabApi.Features.Wrappers.MicroHIDItem(x));
		}

		protected static global::LabApi.Features.Wrappers.Item CreateItemWrapper(global::InventorySystem.Items.ItemBase item)
		{
			global::System.Type type = item.GetType();
			if (!TypeWrappers.TryGetValue(type, out global::System.Func<global::InventorySystem.Items.ItemBase, global::LabApi.Features.Wrappers.Item> value))
			{
				return new global::LabApi.Features.Wrappers.Item(item);
			}
			return value(item);
		}

		private static void AddItem(global::InventorySystem.Items.ItemBase item)
		{
			try
			{
				if (!Dictionary.ContainsKey(item))
				{
					CreateItemWrapper(item);
				}
			}
			catch (global::System.Exception arg)
			{
				global::LabApi.Features.Console.Logger.InternalError($"Failed to handle item creation with error: {arg}");
			}
		}

		private static void RemoveItem(global::InventorySystem.Items.ItemBase itemBase)
		{
			try
			{
				SerialsCache.Remove(itemBase.ItemSerial);
				if (Dictionary.TryGetValue(itemBase, out global::LabApi.Features.Wrappers.Item value))
				{
					Dictionary.Remove(itemBase);
					value.OnRemove();
				}
			}
			catch (global::System.Exception arg)
			{
				global::LabApi.Features.Console.Logger.InternalError($"Failed to handle item destruction with error: {arg}");
			}
		}

		private static void Register<T>(global::System.Func<T, global::LabApi.Features.Wrappers.Item> constructor) where T : global::InventorySystem.Items.ItemBase
		{
			TypeWrappers.Add(typeof(T), (global::InventorySystem.Items.ItemBase x) => constructor((T)x));
		}

		protected Item(global::InventorySystem.Items.ItemBase itemBase)
		{
			Base = itemBase;
			IsPrefab = global::InventorySystem.InventoryItemLoader.TryGetItem<global::InventorySystem.Items.ItemBase>(itemBase.ItemTypeId, out var result) && result == itemBase;
			if (CanCache)
			{
				if (Dictionary.ContainsKey(itemBase))
				{
					global::LabApi.Features.Console.Logger.InternalError($"Failed to create an item for base: {itemBase}");
					return;
				}
				Dictionary[itemBase] = this;
				SerialsCache[itemBase.ItemSerial] = this;
			}
		}

		public global::LabApi.Features.Wrappers.Pickup DropItem()
		{
			return global::LabApi.Features.Wrappers.Pickup.Get(Base.ServerDropItem(spawn: true));
		}

		public void MoveTo(global::LabApi.Features.Wrappers.Player player)
		{
			player.AddItem(DropItem());
		}

		public override string ToString()
		{
			return $"[{GetType().Name}: Type={Type}, IsDestroyed={IsDestroyed}, IsEquipped={IsEquipped}, Serial={Serial}]";
		}

		internal virtual void OnRemove()
		{
		}
	}
}
