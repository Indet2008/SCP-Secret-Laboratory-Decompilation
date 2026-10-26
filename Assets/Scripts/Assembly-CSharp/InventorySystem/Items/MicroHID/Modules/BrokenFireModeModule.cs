using System;
using PlayerRoles.FirstPersonControl;
using UnityEngine;

namespace InventorySystem.Items.MicroHID.Modules
{
	public class BrokenFireModeModule : FiringModeControllerModule
	{
		private const float FiringConeAngleDeg = 30f;

		private const float FiringAlwaysIncludeDistSqr = 1f;

		private const float DamagePerSecond = 400f;

		private static readonly float FiringConeDot = Mathf.Cos(MathF.PI / 6f);

		public override MicroHidFiringMode AssignedMode => MicroHidFiringMode.BrokenFire;

		public override float WindUpRate => 1f / 3f;

		public override float WindDownRate => 1f;

		public override float DrainRateWindUp => 0f;

		public override float DrainRateSustain => 0f;

		public override float DrainRateFiring => 0.05f;

		public override bool ValidateStart
		{
			get
			{
				if (base.InputSync.Primary)
				{
					return base.Broken;
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

		public override float FiringRange => 4f;

		public override float BacktrackerDot => 0.8f;

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
			if (!(base.Item.Owner.roleManager.CurrentRole is IFpcRole fpcRole))
			{
				return;
			}
			HitregUtils.OverlapSphere(fpcRole.FpcModule.Position, FiringRange, out var _, CheckAngle);
			foreach (IDestructible detectedDestructible in HitregUtils.DetectedDestructibles)
			{
				detectedDestructible.ServerDealDamage(this, 400f * Time.deltaTime);
			}
		}

		private bool CheckAngle(IDestructible dest)
		{
			Transform playerCameraReference = base.Item.Owner.PlayerCameraReference;
			Vector3 vector = dest.CenterOfMass - playerCameraReference.position;
			float sqrMagnitude = vector.sqrMagnitude;
			if (sqrMagnitude < 1f)
			{
				return true;
			}
			Vector3 forward = playerCameraReference.forward;
			return Vector3.Dot(vector / Mathf.Sqrt(sqrMagnitude), forward) >= FiringConeDot;
		}
	}
}
