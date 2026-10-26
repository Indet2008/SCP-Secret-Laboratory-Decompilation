using PlayerRoles.FirstPersonControl;
using UnityEngine;

namespace InventorySystem.Items.MicroHID.Modules
{
	public class PrimaryFireModeModule : FiringModeControllerModule
	{
		private const float RaycastThickness = 0.2f;

		private const float DamagePerSec = 400f;

		public override MicroHidFiringMode AssignedMode => MicroHidFiringMode.PrimaryFire;

		public override float WindUpRate => 1f / 3f;

		public override float WindDownRate => 1f;

		public override float DrainRateWindUp => 0f;

		public override float DrainRateSustain => 0f;

		public override float DrainRateFiring => 0.04f;

		public override bool ValidateStart
		{
			get
			{
				if (base.InputSync.Primary)
				{
					return !base.Broken;
				}
				return false;
			}
		}

		public override bool ValidateEnterFire => base.InputSync.Primary;

		public override bool ValidateUpdate
		{
			get
			{
				if (base.InputSync.Primary)
				{
					return base.Energy > 0f;
				}
				return false;
			}
		}

		public override float FiringRange => 6f;

		public override float BacktrackerDot => 0.9f;

		private float FrameDamage => 400f * Time.deltaTime;

		public override void ServerUpdateSelected(MicroHidPhase status)
		{
			base.ServerUpdateSelected(status);
			if (status == MicroHidPhase.Firing)
			{
				ServerRequestBacktrack(ServerFire);
			}
		}

		private void ServerFire()
		{
			ReferenceHub owner = base.Item.Owner;
			HitregUtils.Raycast(owner.PlayerCameraReference, 0.2f, FiringRange, out var _);
			HitboxIdentity hitboxIdentity = null;
			float num = float.MaxValue;
			foreach (IDestructible detectedDestructible in HitregUtils.DetectedDestructibles)
			{
				if (!(detectedDestructible is HitboxIdentity hitboxIdentity2))
				{
					detectedDestructible.ServerDealDamage(this, FrameDamage);
				}
				else if (!(hitboxIdentity2.TargetHub == owner) && hitboxIdentity2.TargetHub.roleManager.CurrentRole is IFpcRole target)
				{
					float num2 = target.SqrDistanceTo(owner);
					if (!(num2 > num))
					{
						hitboxIdentity = hitboxIdentity2;
						num = num2;
					}
				}
			}
			if (hitboxIdentity != null)
			{
				hitboxIdentity.ServerDealDamage(this, FrameDamage);
			}
		}
	}
}
