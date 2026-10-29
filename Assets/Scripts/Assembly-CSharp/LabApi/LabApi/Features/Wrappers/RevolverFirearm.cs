namespace LabApi.Features.Wrappers
{
	public class RevolverFirearm : global::LabApi.Features.Wrappers.FirearmItem
	{
		private global::InventorySystem.Items.Firearms.Modules.RevolverRouletteModule _rouletteModule;

		public override bool OpenBolt => false;

		public global::System.Collections.Generic.IEnumerable<global::InventorySystem.Items.Firearms.Modules.CylinderAmmoModule.Chamber> Chambers
		{
			get
			{
				if (base.AmmoContainerModule is global::InventorySystem.Items.Firearms.Modules.CylinderAmmoModule)
				{
					return global::InventorySystem.Items.Firearms.Modules.CylinderAmmoModule.GetChambersArrayForSerial(base.Serial, base.MaxAmmo);
				}
				return global::System.Array.Empty<global::InventorySystem.Items.Firearms.Modules.CylinderAmmoModule.Chamber>();
			}
		}

		public override bool Cocked
		{
			get
			{
				if (base.ActionModule is global::InventorySystem.Items.Firearms.Modules.DoubleActionModule doubleActionModule)
				{
					return doubleActionModule.Cocked;
				}
				return false;
			}
			set
			{
				if (!(base.ActionModule is global::InventorySystem.Items.Firearms.Modules.DoubleActionModule doubleActionModule))
				{
					global::LabApi.Features.Console.Logger.Error("Unable to set Cocked as the DoubleActionModule is null.");
				}
				else
				{
					doubleActionModule.Cocked = value;
				}
			}
		}

		public override int StoredAmmo
		{
			get
			{
				if (base.AmmoContainerModule is global::InventorySystem.Items.Firearms.Modules.CylinderAmmoModule cylinderAmmoModule)
				{
					return cylinderAmmoModule.AmmoStored;
				}
				return 0;
			}
			set
			{
				if (!(base.AmmoContainerModule is global::InventorySystem.Items.Firearms.Modules.CylinderAmmoModule cylinderAmmoModule))
				{
					global::LabApi.Features.Console.Logger.Error("Unable to set StoredAmmo as the CylinderAmmoModule is null.");
					return;
				}
				foreach (global::InventorySystem.Items.Firearms.Modules.CylinderAmmoModule.Chamber chamber in Chambers)
				{
					chamber.ServerSyncState = global::InventorySystem.Items.Firearms.Modules.CylinderAmmoModule.ChamberState.Empty;
				}
				cylinderAmmoModule.ServerModifyAmmo(value);
			}
		}

		public override int ChamberedAmmo
		{
			get
			{
				return (global::InventorySystem.Items.Firearms.Modules.CylinderAmmoModule.GetChambersArrayForSerial(base.Serial, base.MaxAmmo)[0].ServerSyncState == global::InventorySystem.Items.Firearms.Modules.CylinderAmmoModule.ChamberState.Live) ? 1 : 0;
			}
			set
			{
				if (!(base.ActionModule is global::InventorySystem.Items.Firearms.Modules.DoubleActionModule))
				{
					global::LabApi.Features.Console.Logger.Error("Unable to set ChamberedAmmo as the DoubleActionModule is null.");
				}
				else
				{
					SetChamberStatus(0, (value != 0) ? global::InventorySystem.Items.Firearms.Modules.CylinderAmmoModule.ChamberState.Live : global::InventorySystem.Items.Firearms.Modules.CylinderAmmoModule.ChamberState.Empty);
				}
			}
		}

		internal RevolverFirearm(global::InventorySystem.Items.Firearms.Firearm firearm)
			: base(firearm)
		{
		}

		public void SetChamberStatus(int index, global::InventorySystem.Items.Firearms.Modules.CylinderAmmoModule.ChamberState state)
		{
			if (!(base.AmmoContainerModule is global::InventorySystem.Items.Firearms.Modules.CylinderAmmoModule cylinderAmmoModule))
			{
				global::LabApi.Features.Console.Logger.Error("Unable to set chamber status, this firearm doesn't have CylinderAmmoModule!");
				return;
			}
			global::InventorySystem.Items.Firearms.Modules.CylinderAmmoModule.GetChambersArrayForSerial(base.Serial, base.MaxAmmo)[index].ServerSyncState = state;
			cylinderAmmoModule.ServerResync();
		}

		public void Rotate(int amount)
		{
			if (!(base.AmmoContainerModule is global::InventorySystem.Items.Firearms.Modules.CylinderAmmoModule cylinderAmmoModule))
			{
				global::LabApi.Features.Console.Logger.Error("Unable to rotate this cylinder, this firearm doesn't have CylinderAmmoModule!");
			}
			else
			{
				cylinderAmmoModule.RotateCylinder(amount);
			}
		}

		public bool TrySpin()
		{
			if ((object)_rouletteModule == null)
			{
				global::LabApi.Features.Console.Logger.Error("Unable to spin this cylinder, this firearm doesn't have RevolverRouletteModule!");
				return false;
			}
			return _rouletteModule.ServerTrySpin();
		}

		protected override void CacheModules()
		{
			base.CacheModules();
			global::InventorySystem.Items.Firearms.Modules.ModuleBase[] modules = base.Modules;
			for (int i = 0; i < modules.Length; i++)
			{
				if (modules[i] is global::InventorySystem.Items.Firearms.Modules.RevolverRouletteModule rouletteModule)
				{
					_rouletteModule = rouletteModule;
					break;
				}
			}
		}
	}
}
