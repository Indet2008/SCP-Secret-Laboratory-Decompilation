using System.Diagnostics;
using InventorySystem.Disarming;
using InventorySystem.Items;
using PlayerRoles;
using ToggleableMenus;
using UnityEngine;
using UserSettings;
using UserSettings.ControlsSettings;

namespace InventorySystem.GUI
{
	public class InventoryGuiController : ToggleableMenuBase, IHoldableMenu
	{
		public static InventoryGuiController Singleton;

		public static readonly CachedUserSetting<bool> ToggleInventory = new CachedUserSetting<bool>(MiscControlsSetting.InventoryToggle);

		private static readonly Stopwatch CooldownStopwatch = new Stopwatch();

		private static readonly byte InventoryFadeSpeed = 10;

		[SerializeField]
		private CanvasGroup _toggleablePart;

		[SerializeField]
		private RadialInventory _displaySettings;

		private bool _prevVisible;

		public static bool InventoryVisible
		{
			get
			{
				if (Singleton != null)
				{
					return Singleton.IsEnabled;
				}
				return false;
			}
			set
			{
				if (!(Singleton == null))
				{
					Singleton.IsEnabled = value;
				}
			}
		}

		public static bool ItemsSafeForInteraction
		{
			get
			{
				if (Singleton._toggleablePart.alpha > 0f || Cursor.visible)
				{
					if (!CooldownStopwatch.IsRunning)
					{
						CooldownStopwatch.Restart();
					}
					return false;
				}
				if (CooldownStopwatch.IsRunning)
				{
					if (CooldownStopwatch.Elapsed.TotalSeconds < 0.10000000149011612)
					{
						return false;
					}
					CooldownStopwatch.Stop();
				}
				return true;
			}
		}

		public override bool CanToggle
		{
			get
			{
				if (!IsEnabled)
				{
					return CanInventoryBeDisplayed();
				}
				return true;
			}
		}

		public static IInventoryGuiDisplayType DisplayController => Singleton._displaySettings;

		private static Inventory UserInventory => ReferenceHub.LocalHub.inventory;

		public bool IsHoldable => !ToggleInventory.Value;

		[RuntimeInitializeOnLoadMethod]
		private static void Init()
		{
			UserSetting<bool>.SetDefaultValue(MiscControlsSetting.InventoryToggle, defaultValue: true);
		}

		private void ItemsModified(ReferenceHub hub)
		{
			if (hub.isLocalPlayer)
			{
				DisplayController.ItemsModified(hub.inventory);
			}
		}

		private void AmmoModified(ReferenceHub hub)
		{
			if (hub.isLocalPlayer)
			{
				DisplayController.AmmoModified(hub);
			}
		}

		private void RoleChanged(ReferenceHub hub, PlayerRoleBase oldRole, PlayerRoleBase newRole)
		{
			if (hub.isLocalPlayer)
			{
				DisplayController.ItemsModified(hub.inventory);
				DisplayController.AmmoModified(hub);
			}
		}

		protected override void Awake()
		{
			base.Awake();
			Singleton = this;
			IsEnabled = false;
			Inventory.OnItemsModified += ItemsModified;
			Inventory.OnAmmoModified += AmmoModified;
			PlayerRoleManager.OnRoleChanged += RoleChanged;
		}

		protected override void OnDestroy()
		{
			base.OnDestroy();
			Inventory.OnItemsModified -= ItemsModified;
			Inventory.OnAmmoModified -= AmmoModified;
			PlayerRoleManager.OnRoleChanged -= RoleChanged;
		}

		private void Update()
		{
			RefreshAnimations(forceNoAnimations: false);
			if (InventoryVisible)
			{
				if (!CanInventoryBeDisplayed())
				{
					IsEnabled = false;
				}
				ushort itemSerial;
				switch (DisplayController.DisplayAndSelectItems(UserInventory, out itemSerial))
				{
				case InventoryGuiAction.Select:
					UserInventory.ClientSelectItem(itemSerial);
					break;
				case InventoryGuiAction.Drop:
					UserInventory.ClientDropItem(itemSerial, tryThrow: false);
					break;
				}
			}
			if (_prevVisible != InventoryVisible)
			{
				DisplayController.InventoryToggled(InventoryVisible);
				_prevVisible = InventoryVisible;
			}
		}

		private void RefreshAnimations(bool forceNoAnimations)
		{
			if (InventoryVisible)
			{
				if (!_toggleablePart.gameObject.activeSelf)
				{
					_toggleablePart.gameObject.SetActive(value: true);
				}
				if (_toggleablePart.alpha < 1f)
				{
					_toggleablePart.alpha = (forceNoAnimations ? 1f : Mathf.Clamp01(_toggleablePart.alpha + Time.deltaTime * (float)(int)InventoryFadeSpeed));
				}
			}
			else
			{
				if (!_toggleablePart.gameObject.activeSelf)
				{
					return;
				}
				if (forceNoAnimations)
				{
					_toggleablePart.alpha = 0f;
					_toggleablePart.gameObject.SetActive(value: false);
					return;
				}
				_toggleablePart.alpha = Mathf.Clamp01(_toggleablePart.alpha - Time.deltaTime * (float)(int)InventoryFadeSpeed);
				if (_toggleablePart.alpha <= 0f)
				{
					_toggleablePart.gameObject.SetActive(value: false);
				}
			}
		}

		public static bool CanInventoryBeDisplayed()
		{
			if (!ReferenceHub.TryGetLocalHub(out var hub) || !(hub.roleManager.CurrentRole is IInventoryRole))
			{
				return false;
			}
			if (hub.inventory.IsDisarmed())
			{
				return false;
			}
			if (UserInventory.CurInstance != null && !UserInventory.CurInstance.AllowHolster)
			{
				return false;
			}
			return !hub.interCoordinator.AnyBlocker((IInteractionBlocker x) => x.BlockedInteractions.HasFlagFast(BlockedInteraction.OpenInventory));
		}

		protected override void OnToggled()
		{
			RefreshAnimations(!CanInventoryBeDisplayed());
		}
	}
}
