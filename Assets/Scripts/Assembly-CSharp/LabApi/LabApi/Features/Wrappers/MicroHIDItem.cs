namespace LabApi.Features.Wrappers
{
	public class MicroHIDItem : global::LabApi.Features.Wrappers.Item
	{
		public new static global::System.Collections.Generic.Dictionary<global::InventorySystem.Items.MicroHID.MicroHIDItem, global::LabApi.Features.Wrappers.MicroHIDItem> Dictionary { get; } = new global::System.Collections.Generic.Dictionary<global::InventorySystem.Items.MicroHID.MicroHIDItem, global::LabApi.Features.Wrappers.MicroHIDItem>();

		public new static global::System.Collections.Generic.IReadOnlyCollection<global::LabApi.Features.Wrappers.MicroHIDItem> List => Dictionary.Values;

		public new global::InventorySystem.Items.MicroHID.MicroHIDItem Base { get; }

		public global::InventorySystem.Items.MicroHID.Modules.EnergyManagerModule BaseEnergyManager => Base.EnergyManager;

		public global::InventorySystem.Items.MicroHID.Modules.InputSyncModule BaseInputSyncModule => Base.InputSync;

		public global::InventorySystem.Items.MicroHID.Modules.BrokenSyncModule BaseBrokenSyncModule => Base.BrokenSync;

		public global::InventorySystem.Items.MicroHID.Modules.CycleController BaseCycleController => Base.CycleController;

		public float Energy
		{
			get
			{
				return BaseEnergyManager.Energy;
			}
			set
			{
				BaseEnergyManager.ServerSetEnergy(base.Serial, value);
			}
		}

		public bool IsBroken
		{
			get
			{
				return BaseBrokenSyncModule.Broken;
			}
			set
			{
				BaseBrokenSyncModule.ServerSetBroken(base.Serial, value);
			}
		}

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

		public float WindUpProgress => BaseCycleController.ServerWindUpProgress;

		public float PhaseElapsed => BaseCycleController.CurrentPhaseElapsed;

		public bool IsPrimaryHeld => BaseInputSyncModule.Primary;

		public bool IsSecondaryHeld => BaseInputSyncModule.Secondary;

		[return: global::System.Diagnostics.CodeAnalysis.NotNullIfNotNull("baseMicroHIDItem")]
		public static global::LabApi.Features.Wrappers.MicroHIDItem? Get(global::InventorySystem.Items.MicroHID.MicroHIDItem? baseMicroHIDItem)
		{
			if (baseMicroHIDItem == null)
			{
				return null;
			}
			if (!Dictionary.TryGetValue(baseMicroHIDItem, out global::LabApi.Features.Wrappers.MicroHIDItem value))
			{
				return (global::LabApi.Features.Wrappers.MicroHIDItem)global::LabApi.Features.Wrappers.Item.CreateItemWrapper(baseMicroHIDItem);
			}
			return value;
		}

		internal MicroHIDItem(global::InventorySystem.Items.MicroHID.MicroHIDItem baseMicroHIDItem)
			: base(baseMicroHIDItem)
		{
			Base = baseMicroHIDItem;
			if (base.CanCache)
			{
				Dictionary.Add(baseMicroHIDItem, this);
			}
		}

		public bool TryGetSoundEmissionRange(out float range)
		{
			return Base.TryGetSoundEmissionRange(out range);
		}

		internal override void OnRemove()
		{
			base.OnRemove();
			Dictionary.Remove(Base);
		}
	}
}
