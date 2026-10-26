using CustomPlayerEffects;
using InventorySystem.Disarming;
using InventorySystem.Items;
using PlayerRoles.FirstPersonControl;
using UnityEngine;

namespace Interactables.Verification
{
	public class StandardDistanceVerification : IVerificationRule
	{
		private const float InteractLagCompensation = 1.4f;

		public const float DefaultMaxDistance = 2.42f;

		public static StandardDistanceVerification Default = new StandardDistanceVerification();

		private readonly float _maxDistance;

		private readonly bool _allowHandcuffed;

		private readonly bool _cancel268;

		public StandardDistanceVerification(float maxDistance = 2.42f, bool allowHandcuffedInteraction = false, bool cancelScp268 = true)
		{
			_maxDistance = maxDistance;
			_allowHandcuffed = allowHandcuffedInteraction;
			_cancel268 = cancelScp268;
		}

		public bool ClientCanInteract(InteractableCollider collider, RaycastHit hit)
		{
			return hit.distance < _maxDistance;
		}

		public bool ServerCanInteract(ReferenceHub hub, InteractableCollider collider)
		{
			if (!_allowHandcuffed && !InteractionCoordinator.CanDisarmedInteract && hub.inventory.IsDisarmed())
			{
				return false;
			}
			if (hub.interCoordinator.AnyBlocker(BlockedInteraction.GeneralInteractions))
			{
				return false;
			}
			if (!(hub.roleManager.CurrentRole is IFpcRole fpcRole))
			{
				return false;
			}
			Transform transform = collider.transform;
			if (Vector3.Distance(fpcRole.FpcModule.Position, transform.position + transform.TransformDirection(collider.VerificationOffset)) > _maxDistance * 1.4f)
			{
				return false;
			}
			if (_cancel268)
			{
				hub.playerEffectsController.DisableEffect<Invisible>();
			}
			return true;
		}
	}
}
