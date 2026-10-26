using InventorySystem.Items.Pickups;
using Mirror;

namespace InventorySystem.Items.Scp1509
{
	public class Scp1509Pickup : CollisionDetectionPickup
	{
		public bool ResurrectDirty;

		public double NextReviveTime;

		private bool _prevRevive;

		private bool _setup;

		private void Update()
		{
			if (NetworkServer.active && _setup)
			{
				bool flag = NextReviveTime < NetworkTime.time && Scp1509RespawnEligibility.IsAnyEligibleSpectators();
				if (_prevRevive != flag)
				{
					_prevRevive = flag;
					Scp1509Item.ResurrectStatuses[Info.Serial] = flag;
					ResurrectDirty = true;
				}
			}
		}

		public void Setup(double nextReviveTime)
		{
			NextReviveTime = nextReviveTime;
			ResurrectDirty = false;
			_setup = true;
		}

		public override bool Weaved()
		{
			return true;
		}
	}
}
