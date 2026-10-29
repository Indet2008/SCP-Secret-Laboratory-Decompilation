namespace LabApi.Features.Wrappers
{
	public class PedestalLocker : global::LabApi.Features.Wrappers.Locker
	{
		public new static global::System.Collections.Generic.Dictionary<global::MapGeneration.Distributors.PedestalScpLocker, global::LabApi.Features.Wrappers.PedestalLocker> Dictionary { get; } = new global::System.Collections.Generic.Dictionary<global::MapGeneration.Distributors.PedestalScpLocker, global::LabApi.Features.Wrappers.PedestalLocker>();

		public new static global::System.Collections.Generic.IReadOnlyCollection<global::LabApi.Features.Wrappers.PedestalLocker> List => Dictionary.Values;

		public new global::MapGeneration.Distributors.PedestalScpLocker Base { get; }

		public global::LabApi.Features.Wrappers.LockerChamber Chamber => global::System.Linq.Enumerable.First(base.Chambers);

		public bool IsOpen
		{
			get
			{
				return Chamber.IsOpen;
			}
			set
			{
				Chamber.IsOpen = value;
			}
		}

		public bool CanInteract => Chamber.CanInteract;

		public global::Interactables.Interobjects.DoorUtils.DoorPermissionFlags RequiredPermissions
		{
			get
			{
				return Chamber.RequiredPermissions;
			}
			set
			{
				Chamber.RequiredPermissions = value;
			}
		}

		public float TargetCooldown
		{
			get
			{
				return Chamber.TargetCooldown;
			}
			set
			{
				Chamber.TargetCooldown = value;
			}
		}

		public ItemType[] AcceptableItems
		{
			get
			{
				return Chamber.AcceptableItems;
			}
			set
			{
				Chamber.AcceptableItems = value;
			}
		}

		[return: global::System.Diagnostics.CodeAnalysis.NotNullIfNotNull("basePedestal")]
		public static global::LabApi.Features.Wrappers.PedestalLocker? Get(global::MapGeneration.Distributors.PedestalScpLocker? basePedestal)
		{
			if (basePedestal == null)
			{
				return null;
			}
			if (!Dictionary.TryGetValue(basePedestal, out global::LabApi.Features.Wrappers.PedestalLocker value))
			{
				return (global::LabApi.Features.Wrappers.PedestalLocker)global::LabApi.Features.Wrappers.Structure.CreateStructureWrapper(basePedestal);
			}
			return value;
		}

		internal PedestalLocker(global::MapGeneration.Distributors.PedestalScpLocker pedestalScpLocker)
			: base(pedestalScpLocker)
		{
			Base = pedestalScpLocker;
			if (base.CanCache)
			{
				Dictionary.Add(pedestalScpLocker, this);
			}
		}

		public void Fill()
		{
			Chamber.Fill();
		}

		public global::System.Collections.Generic.HashSet<global::LabApi.Features.Wrappers.Pickup> GetAllItems()
		{
			return Chamber.GetAllItems();
		}

		public void RemoveAllItems()
		{
			Chamber.RemoveAllItems();
		}

		public void RemoveItem(global::LabApi.Features.Wrappers.Pickup pickup)
		{
			Chamber.RemoveItem(pickup);
		}

		public global::LabApi.Features.Wrappers.Pickup AddItem(ItemType type)
		{
			return Chamber.AddItem(type);
		}

		public void Interact(global::LabApi.Features.Wrappers.Player player)
		{
			Chamber.Interact(player);
		}

		public void PlayDeniedSound(global::Interactables.Interobjects.DoorUtils.DoorPermissionFlags flags = global::Interactables.Interobjects.DoorUtils.DoorPermissionFlags.None)
		{
			Chamber.PlayDeniedSound(flags);
		}

		internal override void OnRemove()
		{
			base.OnRemove();
			Dictionary.Remove(Base);
		}
	}
}
