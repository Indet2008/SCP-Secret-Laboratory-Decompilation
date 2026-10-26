using System.Diagnostics;
using CustomPlayerEffects;
using InventorySystem.Drawers;
using InventorySystem.Items.Pickups;
using Mirror;
using UnityEngine;

namespace InventorySystem.Items.Usables
{
	public abstract class Consumable : UsableItem, IItemProgressbarDrawer, IItemDrawer
	{
		[SerializeField]
		private float _activationTime;

		private float _realActivationTime;

		[SerializeField]
		private bool _showProgressBar;

		private readonly Stopwatch _useStopwatch = new Stopwatch();

		private bool _alreadyActivated;

		public bool ProgressbarEnabled
		{
			get
			{
				if (_showProgressBar)
				{
					return !AllowHolster;
				}
				return false;
			}
		}

		public float ProgressbarMin => 0f;

		public float ProgressbarMax => _realActivationTime;

		public float ProgressbarValue { get; private set; }

		public float ProgressbarWidth => 650f;

		public override bool AllowHolster
		{
			get
			{
				if (_useStopwatch.IsRunning)
				{
					return _useStopwatch.Elapsed.TotalSeconds >= (double)_realActivationTime;
				}
				return true;
			}
		}

		private bool ActivationReady
		{
			get
			{
				if (NetworkServer.active && !_alreadyActivated && _useStopwatch.IsRunning)
				{
					return _useStopwatch.Elapsed.TotalSeconds >= (double)_realActivationTime;
				}
				return false;
			}
		}

		public override void OnEquipped()
		{
			base.OnEquipped();
			_realActivationTime = _activationTime;
		}

		public override void OnUsingStarted()
		{
			base.OnUsingStarted();
			ProgressbarValue = 0f;
			_useStopwatch.Restart();
			_realActivationTime = _activationTime;
			if (ItemTypeId.TryGetSpeedMultiplier(base.Owner, out var multiplier) && multiplier != 0f)
			{
				_realActivationTime /= multiplier;
			}
		}

		public override void OnUsingCancelled()
		{
			base.OnUsingCancelled();
			_useStopwatch.Stop();
			_realActivationTime = _activationTime;
		}

		public override void ServerOnUsingCompleted()
		{
			base.OwnerInventory.NetworkCurItem = ItemIdentifier.None;
			base.OwnerInventory.CurInstance = null;
			if (!_alreadyActivated)
			{
				ActivateEffects();
			}
			ServerRemoveSelf();
		}

		public override void EquipUpdate()
		{
			base.EquipUpdate();
			if (IsLocalPlayer && ProgressbarEnabled)
			{
				ProgressbarValue += Time.deltaTime;
			}
			if (ActivationReady)
			{
				ActivateEffects();
			}
		}

		public override void OnHolstered()
		{
			base.OnHolstered();
			if (NetworkServer.active && _alreadyActivated)
			{
				ServerRemoveSelf();
			}
		}

		public override void OnRemoved(ItemPickupBase pickup)
		{
			base.OnRemoved(pickup);
			if (ActivationReady)
			{
				ActivateEffects();
			}
			if (_alreadyActivated && pickup != null)
			{
				pickup.DestroySelf();
			}
			if (NetworkServer.active)
			{
				UsableItemsController.GetHandler(base.Owner).CurrentUsable = CurrentlyUsedItem.None;
			}
		}

		private void ActivateEffects()
		{
			if (NetworkServer.active)
			{
				OnEffectsActivated();
				_alreadyActivated = true;
			}
		}

		protected abstract void OnEffectsActivated();
	}
}
