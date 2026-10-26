using Footprinting;
using Interactables;
using Interactables.Interobjects;
using Interactables.Interobjects.DoorUtils;
using MapGeneration;
using PlayerRoles;
using PlayerRoles.FirstPersonControl;
using PlayerStatsSystem;
using UnityEngine;

namespace InventorySystem.Items.MicroHID.Modules
{
	public class ChargeFireModeModule : FiringModeControllerModule
	{
		private static readonly DoorLockReason BypassableLocks = DoorLockReason.Regular079 | DoorLockReason.Lockdown079 | DoorLockReason.NoPower | DoorLockReason.Lockdown2176;

		public const float MaxSustainBeforeExplosionSeconds = 8f;

		private const float RaycastThickness = 0.65f;

		private const float DamagePerSec = 1000f;

		private const float StartFiringEnergyUse = 0.1f;

		private const float ExplosionEnergyPenalty = 0.25f;

		private const float ExplosionPlayerDamage = 125f;

		private const float ExplosionDoorDamage = 350f;

		private const float ExplosionRadius = 10f;

		private const float ExplosionBlackoutSeconds = 1f;

		private MicroHidPhase _prevStatus;

		private float _woundUpElapsed;

		private bool _alreadyExploded;

		public override MicroHidFiringMode AssignedMode => MicroHidFiringMode.ChargeFire;

		public override float WindUpRate => 1f / 7f;

		public override float WindDownRate => 1f / 7f;

		public override float DrainRateWindUp => 0.01f;

		public override float DrainRateSustain => 0.015f;

		public override float DrainRateFiring => 0.1f;

		public override bool ValidateStart
		{
			get
			{
				if (base.InputSync.Secondary)
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
				if ((base.InputSync.Primary || base.InputSync.Secondary) && base.Energy > 0f)
				{
					return !base.Broken;
				}
				return false;
			}
		}

		public override float FiringRange => 10f;

		public override float BacktrackerDot => 0.9f;

		public override void ServerUpdateSelected(MicroHidPhase status)
		{
			base.ServerUpdateSelected(status);
			if (status != _prevStatus)
			{
				ServerOnModeChanged(status);
				_prevStatus = status;
			}
			switch (status)
			{
			case MicroHidPhase.WoundUpSustain:
				ServerUpdateWoundUp();
				break;
			case MicroHidPhase.Firing:
				ServerRequestBacktrack(ServerFire);
				break;
			}
		}

		private void ServerOnModeChanged(MicroHidPhase status)
		{
			switch (status)
			{
			case MicroHidPhase.Firing:
				base.Energy -= 0.1f;
				break;
			case MicroHidPhase.WoundUpSustain:
				_woundUpElapsed = 0f;
				break;
			}
		}

		private void ServerUpdateWoundUp()
		{
			_woundUpElapsed += Time.deltaTime;
			if (!(_woundUpElapsed < 8f))
			{
				ServerExplode();
			}
		}

		private void ServerExplode()
		{
			if (_alreadyExploded)
			{
				return;
			}
			_alreadyExploded = true;
			base.MicroHid.BrokenSync.ServerSetBroken();
			ReferenceHub owner = base.Item.Owner;
			if (!(owner.roleManager.CurrentRole is IFpcRole fpcRole))
			{
				return;
			}
			base.Energy -= 0.25f;
			Vector3 position = fpcRole.FpcModule.Position;
			HitregUtils.OverlapSphere(position, 10f, out var detections);
			for (int i = 0; i < detections; i++)
			{
				if (HitregUtils.DetectionsNonAlloc[i].TryGetComponent<InteractableCollider>(out var component) && component.Target is IDamageableDoor damageableDoor && CheckIntercolLineOfSight(position, component))
				{
					damageableDoor.ServerDamage(350f, DoorDamageType.Grenade, new Footprint(owner));
				}
			}
			if (!position.TryGetRoom(out var room))
			{
				return;
			}
			foreach (RoomLightController instance in RoomLightController.Instances)
			{
				if (!(instance.Room != room) && instance.LightsEnabled)
				{
					instance.ServerFlickerLights(1f);
				}
			}
			owner.playerStats.DealDamage(new MicroHidDamageHandler(125f, base.MicroHid));
		}

		private void ServerFire()
		{
			Transform playerCameraReference = base.Item.Owner.PlayerCameraReference;
			HitregUtils.Raycast(playerCameraReference, 0.65f, FiringRange, out var detections);
			foreach (IDestructible detectedDestructible in HitregUtils.DetectedDestructibles)
			{
				detectedDestructible.ServerDealDamage(this, 1000f * Time.deltaTime);
			}
			for (int i = 0; i < detections; i++)
			{
				if (HitregUtils.DetectionsNonAlloc[i].TryGetComponent<InteractableCollider>(out var component) && CheckIntercolLineOfSight(playerCameraReference.position, component))
				{
					HandlePotentialDoor(component);
				}
			}
		}

		private void HandlePotentialDoor(InteractableCollider interactable)
		{
			if (interactable.Target is BreakableDoor { TargetState: false } breakableDoor && breakableDoor.AllowInteracting(base.Item.Owner, interactable.ColliderId) && (breakableDoor.ActiveLocks & (ushort)(~(int)BypassableLocks)) == 0)
			{
				breakableDoor.NetworkTargetState = true;
			}
		}

		private bool CheckIntercolLineOfSight(Vector3 originPoint, InteractableCollider collider)
		{
			Transform transform = collider.transform;
			Vector3 end = transform.position + transform.TransformDirection(collider.VerificationOffset);
			if (Physics.Linecast(originPoint, end, out var hitInfo, PlayerRolesUtils.AttackMask))
			{
				return hitInfo.collider.transform == transform;
			}
			return true;
		}
	}
}
