namespace LabApi.Features.Wrappers
{
	public class PocketItem
	{
		private static readonly global::System.Collections.Generic.Dictionary<global::InventorySystem.Items.Pickups.ItemPickupBase, global::LabApi.Features.Wrappers.PocketItem> Dictionary = new global::System.Collections.Generic.Dictionary<global::InventorySystem.Items.Pickups.ItemPickupBase, global::LabApi.Features.Wrappers.PocketItem>();

		public static global::System.Collections.Generic.IReadOnlyCollection<global::LabApi.Features.Wrappers.PocketItem> List => Dictionary.Values;

		public global::LabApi.Features.Wrappers.Pickup Pickup { get; }

		public global::PlayerRoles.PlayableScps.Scp106.Scp106PocketItemManager.PocketItem Base { get; }

		public double TriggerDelay
		{
			get
			{
				return Base.TriggerTime - global::Mirror.NetworkTime.time;
			}
			set
			{
				Base.TriggerTime = global::Mirror.NetworkTime.time + value;
			}
		}

		public bool WillBeDestroyed
		{
			get
			{
				return Base.Remove;
			}
			set
			{
				Base.Remove = value;
			}
		}

		public global::UnityEngine.Vector3 DropPosition
		{
			get
			{
				return Base.DropPosition.Position;
			}
			set
			{
				Base.DropPosition = new global::RelativePositioning.RelativePosition(value);
			}
		}

		public bool IsWarningSent => Base.WarningSent;

		public static bool TryGet(global::LabApi.Features.Wrappers.Pickup pickup, [global::System.Diagnostics.CodeAnalysis.NotNullWhen(true)] out global::LabApi.Features.Wrappers.PocketItem? pocketItem)
		{
			return Dictionary.TryGetValue(pickup.Base, out pocketItem);
		}

		public static global::LabApi.Features.Wrappers.PocketItem? Get(global::LabApi.Features.Wrappers.Pickup pickup)
		{
			if (!TryGet(pickup, out global::LabApi.Features.Wrappers.PocketItem pocketItem))
			{
				return null;
			}
			return pocketItem;
		}

		public static global::LabApi.Features.Wrappers.PocketItem GetOrAdd(global::LabApi.Features.Wrappers.Pickup pickup)
		{
			if (Dictionary.TryGetValue(pickup.Base, out global::LabApi.Features.Wrappers.PocketItem value))
			{
				return value;
			}
			pickup.Position = global::LabApi.Features.Wrappers.PocketDimension.Instance.Position + global::UnityEngine.Vector3.up;
			global::PlayerRoles.PlayableScps.Scp106.Scp106PocketItemManager.AddItem(pickup.Base);
			return Get(pickup);
		}

		[global::Generators.InitializeWrapper(128)]
		internal static void Initialize()
		{
			global::PlayerRoles.PlayableScps.Scp106.Scp106PocketItemManager.OnPocketItemAdded += (global::InventorySystem.Items.Pickups.ItemPickupBase itemPickupBase, global::PlayerRoles.PlayableScps.Scp106.Scp106PocketItemManager.PocketItem pocketItem) =>
			{
				new global::LabApi.Features.Wrappers.PocketItem(itemPickupBase, pocketItem);
			};
			global::PlayerRoles.PlayableScps.Scp106.Scp106PocketItemManager.OnPocketItemRemoved += (global::InventorySystem.Items.Pickups.ItemPickupBase itemPickupBase) =>
			{
				Dictionary.Remove(itemPickupBase);
			};
		}

		internal PocketItem(global::InventorySystem.Items.Pickups.ItemPickupBase pickup, global::PlayerRoles.PlayableScps.Scp106.Scp106PocketItemManager.PocketItem pocketItem)
		{
			Dictionary.Add(pickup, this);
			Pickup = global::LabApi.Features.Wrappers.Pickup.Get(pickup);
			Base = pocketItem;
		}
	}
}
