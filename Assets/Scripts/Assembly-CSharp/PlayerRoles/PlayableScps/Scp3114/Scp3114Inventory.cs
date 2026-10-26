using GameObjectPools;
using Interactables;
using InventorySystem;
using InventorySystem.Items;
using Mirror;
using PlayerRoles.Subroutines;

namespace PlayerRoles.PlayableScps.Scp3114
{
	public class Scp3114Inventory : SubroutineBase, IInteractionBlocker, IPoolSpawnable, IPoolResettable
	{
		private Scp3114Role _scpRole;

		private InteractionCoordinator _lastCoordinator;

		private const BlockedInteraction DisguiseBlockers = BlockedInteraction.ItemPrimaryAction;

		private const BlockedInteraction SkeletonBlockers = BlockedInteraction.OpenInventory | BlockedInteraction.GrabItems;

		public BlockedInteraction BlockedInteractions
		{
			get
			{
				if (!(base.Role as Scp3114Role).Disguised)
				{
					return BlockedInteraction.OpenInventory | BlockedInteraction.GrabItems;
				}
				return BlockedInteraction.ItemPrimaryAction;
			}
		}

		public bool CanBeCleared => false;

		protected override void Awake()
		{
			base.Awake();
			_scpRole = base.Role as Scp3114Role;
			_scpRole.CurIdentity.OnStatusChanged += OnStatusChanged;
		}

		private void OnStatusChanged()
		{
			if (NetworkServer.active && base.Role.TryGetOwner(out var hub))
			{
				hub.inventory.ServerDropEverything();
			}
		}

		public void SpawnObject()
		{
			base.Role.TryGetOwner(out var hub);
			_lastCoordinator = hub.interCoordinator;
			_lastCoordinator.AddBlocker(this);
		}

		public void ResetObject()
		{
			if (!(_lastCoordinator == null))
			{
				_lastCoordinator.RemoveBlocker(this);
				_lastCoordinator = null;
			}
		}
	}
}
