using System;

namespace InventorySystem.Items.MicroHID.Modules
{
	public abstract class FiringModeControllerModule : MicroHidModuleBase
	{
		public abstract MicroHidFiringMode AssignedMode { get; }

		public abstract float WindUpRate { get; }

		public abstract float WindDownRate { get; }

		public abstract float DrainRateWindUp { get; }

		public abstract float DrainRateSustain { get; }

		public abstract float DrainRateFiring { get; }

		public abstract bool ValidateStart { get; }

		public abstract bool ValidateEnterFire { get; }

		public abstract bool ValidateUpdate { get; }

		public abstract float FiringRange { get; }

		public abstract float BacktrackerDot { get; }

		protected InputSyncModule InputSync => base.MicroHid.InputSync;

		protected bool Broken => base.MicroHid.BrokenSync.Broken;

		protected float Energy
		{
			get
			{
				return base.MicroHid.EnergyManager.Energy;
			}
			set
			{
				base.MicroHid.EnergyManager.ServerSetEnergy(base.ItemSerial, value);
			}
		}

		protected void ServerRequestBacktrack(Action callback)
		{
			base.MicroHid.Backtracker.BacktrackAll(callback);
		}

		public virtual void ServerUpdateSelected(MicroHidPhase status)
		{
		}
	}
}
