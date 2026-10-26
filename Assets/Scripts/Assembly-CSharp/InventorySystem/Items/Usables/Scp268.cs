using System.Diagnostics;
using CustomPlayerEffects;
using InventorySystem.Drawers;
using Mirror;
using PlayerRoles.FirstPersonControl.Thirdperson.Subcontrollers.Wearables;

namespace InventorySystem.Items.Usables
{
	public class Scp268 : UsableItem, IWearableItem
	{
		private const float InvisibilityTime = 15f;

		private const float CooldownTime = 120f;

		private readonly Stopwatch _stopwatch = new Stopwatch();

		private bool _isWorn;

		public override AlertContent Alert
		{
			get
			{
				if (!IsWorn)
				{
					return base.Alert;
				}
				return default;
			}
		}

		public bool IsWorn
		{
			get
			{
				if (!IsLocalPlayer || NetworkServer.active)
				{
					return _isWorn;
				}
				return base.Owner.playerEffectsController.GetEffect<Invisible>().Intensity != 0;
			}
			set
			{
				_isWorn = value;
				if (NetworkServer.active)
				{
					if (value)
					{
						base.Owner.EnableWearables(WearableElements.Scp268Hat);
					}
					else
					{
						base.Owner.DisableWearables(WearableElements.Scp268Hat);
					}
				}
			}
		}

		public WearableSlot Slot => WearableSlot.Hat;

		public override bool AllowHolster
		{
			get
			{
				if (IsUsing)
				{
					return IsWorn;
				}
				return true;
			}
		}

		private Invisible Effect => base.Owner.playerEffectsController.GetEffect<Invisible>();

		public override void ServerOnUsingCompleted()
		{
			IsUsing = false;
			IsWorn = true;
			SetState(state: true);
			ServerSetPersonalCooldown(120f);
		}

		public override void OnHolstered()
		{
			base.OnHolstered();
			if (NetworkServer.active)
			{
				SetState(state: false);
			}
			if (IsLocalPlayer)
			{
				IsUsing = false;
			}
		}

		public override void EquipUpdate()
		{
			base.EquipUpdate();
			if (IsLocalPlayer && IsWorn && IsUsing)
			{
				IsUsing = false;
			}
			if (NetworkServer.active && _stopwatch.IsRunning && (_stopwatch.Elapsed.TotalSeconds >= 15.0 || Effect.Intensity == 0))
			{
				SetState(state: false);
			}
		}

		private void SetState(bool state)
		{
			if (state)
			{
				Effect.Intensity = 1;
				_stopwatch.Restart();
			}
			else if (IsWorn)
			{
				Effect.Intensity = 0;
				_stopwatch.Stop();
				IsWorn = false;
				if (base.OwnerInventory.CurItem.TypeId == ItemTypeId)
				{
					base.OwnerInventory.ServerSelectItem(0);
				}
			}
		}
	}
}
