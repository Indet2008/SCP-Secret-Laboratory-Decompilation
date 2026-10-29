namespace LabApi.Features.Wrappers
{
	public class ShotgunFirearm : global::LabApi.Features.Wrappers.FirearmItem
	{
		public override bool OpenBolt => false;

		public override bool Cocked
		{
			get
			{
				if (base.ActionModule is global::InventorySystem.Items.Firearms.Modules.PumpActionModule pumpActionModule)
				{
					return pumpActionModule.SyncCocked == pumpActionModule.Barrels;
				}
				return false;
			}
			set
			{
				if (!(base.ActionModule is global::InventorySystem.Items.Firearms.Modules.PumpActionModule pumpActionModule))
				{
					global::LabApi.Features.Console.Logger.Error("Unable to set Cocked as it is invalid.");
				}
				else
				{
					pumpActionModule.SyncCocked = pumpActionModule.Barrels;
				}
			}
		}

		public int CockedChambers
		{
			get
			{
				if (base.ActionModule is global::InventorySystem.Items.Firearms.Modules.PumpActionModule pumpActionModule)
				{
					return pumpActionModule.SyncCocked;
				}
				return 0;
			}
			set
			{
				if (!(base.ActionModule is global::InventorySystem.Items.Firearms.Modules.PumpActionModule pumpActionModule))
				{
					global::LabApi.Features.Console.Logger.Error("Unable to set CockedChambers as it is invalid.");
				}
				else
				{
					pumpActionModule.SyncCocked = value;
				}
			}
		}

		public override int ChamberMax
		{
			get
			{
				if (base.ActionModule is global::InventorySystem.Items.Firearms.Modules.PumpActionModule pumpActionModule)
				{
					return pumpActionModule.Barrels;
				}
				return 0;
			}
			set
			{
				if (!(base.ActionModule is global::InventorySystem.Items.Firearms.Modules.PumpActionModule pumpActionModule))
				{
					global::LabApi.Features.Console.Logger.Error("Unable to set ChamberMax as it is invalid.");
				}
				else
				{
					pumpActionModule.Barrels = value;
				}
			}
		}

		public override int ChamberedAmmo
		{
			get
			{
				if (base.ActionModule is global::InventorySystem.Items.Firearms.Modules.PumpActionModule pumpActionModule)
				{
					return pumpActionModule.AmmoStored;
				}
				return 0;
			}
			set
			{
				if (!(base.ActionModule is global::InventorySystem.Items.Firearms.Modules.PumpActionModule pumpActionModule))
				{
					global::LabApi.Features.Console.Logger.Error("Unable to set ChamberedAmmo as it is null.");
				}
				else
				{
					pumpActionModule.AmmoStored = value;
				}
			}
		}

		internal ShotgunFirearm(global::InventorySystem.Items.Firearms.Firearm firearm)
			: base(firearm)
		{
		}

		public void Pump(int shotsFired = 0)
		{
			if (!(base.ActionModule is global::InventorySystem.Items.Firearms.Modules.PumpActionModule pumpActionModule))
			{
				global::LabApi.Features.Console.Logger.Error("Unable to pump PumpActionModule as it is null.");
			}
			else
			{
				pumpActionModule.SchedulePumping(shotsFired);
			}
		}
	}
}
