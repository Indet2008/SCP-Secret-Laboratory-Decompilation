namespace LabApi.Features.Wrappers
{
	public class MicroHIDPickup : global::LabApi.Features.Wrappers.Pickup
	{
		public new static global::System.Collections.Generic.Dictionary<global::InventorySystem.Items.MicroHID.MicroHIDPickup, global::LabApi.Features.Wrappers.MicroHIDPickup> Dictionary { get; } = new global::System.Collections.Generic.Dictionary<global::InventorySystem.Items.MicroHID.MicroHIDPickup, global::LabApi.Features.Wrappers.MicroHIDPickup>();

		public new static global::System.Collections.Generic.IReadOnlyCollection<global::LabApi.Features.Wrappers.MicroHIDPickup> List => Dictionary.Values;

		public new global::InventorySystem.Items.MicroHID.MicroHIDPickup Base { get; }

		public global::InventorySystem.Items.MicroHID.Modules.CycleController BaseCycleController { get; }

		public global::InventorySystem.Items.MicroHID.Modules.MicroHidPhase Phase
		{
			get
			{
				return BaseCycleController.Phase;
			}
			set
			{
				BaseCycleController.Phase = value;
			}
		}

		public global::InventorySystem.Items.MicroHID.Modules.MicroHidFiringMode FiringMode
		{
			get
			{
				return BaseCycleController.LastFiringMode;
			}
			set
			{
				BaseCycleController.LastFiringMode = value;
			}
		}

		public float Energy
		{
			get
			{
				return global::InventorySystem.Items.MicroHID.Modules.EnergyManagerModule.GetEnergy(base.Serial);
			}
			set
			{
				if (!global::InventorySystem.InventoryItemLoader.TryGetItem<global::InventorySystem.Items.MicroHID.MicroHIDItem>(ItemType.MicroHID, out var result))
				{
					global::LabApi.Features.Console.Logger.Error("Unable to get the base microhid item!");
				}
				else
				{
					result.EnergyManager.ServerSetEnergy(base.Serial, value);
				}
			}
		}

		public float WindUpProgress => BaseCycleController.ServerWindUpProgress;

		public float PhaseElapsed => BaseCycleController.CurrentPhaseElapsed;

		[return: global::System.Diagnostics.CodeAnalysis.NotNullIfNotNull("pickup")]
		public static global::LabApi.Features.Wrappers.MicroHIDPickup? Get(global::InventorySystem.Items.MicroHID.MicroHIDPickup? pickup)
		{
			if (pickup == null)
			{
				return null;
			}
			if (!Dictionary.TryGetValue(pickup, out global::LabApi.Features.Wrappers.MicroHIDPickup value))
			{
				return (global::LabApi.Features.Wrappers.MicroHIDPickup)global::LabApi.Features.Wrappers.Pickup.CreateItemWrapper(pickup);
			}
			return value;
		}

		internal MicroHIDPickup(global::InventorySystem.Items.MicroHID.MicroHIDPickup baseMicroHIDPickup)
			: base(baseMicroHIDPickup)
		{
			Base = baseMicroHIDPickup;
			BaseCycleController = global::InventorySystem.Items.MicroHID.Modules.CycleSyncModule.GetCycleController(base.Serial);
			if (base.CanCache)
			{
				Dictionary.Add(baseMicroHIDPickup, this);
			}
		}

		internal override void OnRemove()
		{
			base.OnRemove();
			Dictionary.Remove(Base);
		}
	}
}
