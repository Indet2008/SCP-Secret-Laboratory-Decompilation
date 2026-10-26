using System;
using InventorySystem.Drawers;
using InventorySystem.GUI.Descriptions;
using PlayerRoles.FirstPersonControl;
using PlayerRoles.PlayableScps.HumeShield;
using UnityEngine;

namespace InventorySystem.Items.Autosync
{
	public class AutosyncModifiersCombiner : IMovementSpeedModifier, IStaminaModifier, ISprintSpeedModifier, IZoomModifyingItem, ILightEmittingItem, IAmmoDropPreventer, IHumeShieldProvider, IItemAlertDrawer, IItemDrawer, ICustomDescriptionItem
	{
		private static readonly IMovementSpeedModifier[] MovementSpeedModifiersNonAlloc = new IMovementSpeedModifier[16];

		private static readonly IStaminaModifier[] StaminaModifiersNonAlloc = new IStaminaModifier[16];

		private static readonly ISprintSpeedModifier[] SprintSpeedModifierNonAlloc = new ISprintSpeedModifier[8];

		private static readonly IZoomModifyingItem[] ZoomModifiersNonAlloc = new IZoomModifyingItem[8];

		private static readonly ILightEmittingItem[] LightEmittersNonAlloc = new ILightEmittingItem[8];

		private static readonly IAmmoDropPreventer[] DropPreventersNonAlloc = new IAmmoDropPreventer[8];

		private static readonly IHumeShieldProvider[] HumeShieldProvidersNonAlloc = new IHumeShieldProvider[8];

		private static readonly IItemAlertDrawer[] AlertDrawersNonAlloc = new IItemAlertDrawer[8];

		private readonly IMovementSpeedModifier[] _movementSpeedModifiers;

		private readonly IStaminaModifier[] _staminaModifiers;

		private readonly ISprintSpeedModifier[] _sprintSpeedModifiers;

		private readonly IZoomModifyingItem[] _zoomModifiers;

		private readonly ILightEmittingItem[] _lightEmitters;

		private readonly IAmmoDropPreventer[] _dropPreventers;

		private readonly IHumeShieldProvider[] _humeShields;

		private readonly IItemAlertDrawer[] _alertDrawers;

		private readonly ICustomDescriptionItem _customDescription;

		private readonly ModularAutosyncItem _item;

		public bool StaminaModifierActive => _item.IsEquipped;

		public bool MovementModifierActive => _item.IsEquipped;

		public bool SprintModifierActive => _item.IsEquipped;

		public float MovementSpeedMultiplier => CombineMultiplier(_movementSpeedModifiers, (IMovementSpeedModifier x) => x.MovementSpeedMultiplier, (IMovementSpeedModifier x) => x.MovementModifierActive);

		public float MovementSpeedLimit => MinValue(_movementSpeedModifiers, float.MaxValue, (IMovementSpeedModifier x) => x.MovementSpeedLimit, (IMovementSpeedModifier x) => x.MovementModifierActive);

		public float StaminaUsageMultiplier => CombineMultiplier(_staminaModifiers, (IStaminaModifier x) => x.StaminaUsageMultiplier, (IStaminaModifier x) => x.StaminaModifierActive);

		public float StaminaRegenMultiplier => CombineMultiplier(_staminaModifiers, (IStaminaModifier x) => x.StaminaRegenMultiplier, (IStaminaModifier x) => x.StaminaModifierActive);

		public float SprintSpeedMultiplier => CombineMultiplier(_sprintSpeedModifiers, (ISprintSpeedModifier x) => x.SprintSpeedMultiplier, (ISprintSpeedModifier x) => x.SprintModifierActive);

		public bool SprintingDisabled => AnyTrue(_staminaModifiers, (IStaminaModifier x) => x.StaminaModifierActive && x.SprintingDisabled);

		public float ZoomAmount => CombineMultiplier(_zoomModifiers, (IZoomModifyingItem x) => x.ZoomAmount);

		public float SensitivityScale => CombineMultiplier(_zoomModifiers, (IZoomModifyingItem x) => x.SensitivityScale);

		public bool IsEmittingLight => AnyTrue(_lightEmitters, (ILightEmittingItem x) => x.IsEmittingLight);

		public bool ForceBarVisible => AnyTrue(_humeShields, (IHumeShieldProvider x) => x.ForceBarVisible);

		public float HsMax => CombineAdditive(_humeShields, (IHumeShieldProvider x) => x.HsMax);

		public float HsRegeneration => CombineAdditive(_humeShields, (IHumeShieldProvider x) => x.HsRegeneration);

		public CustomDescriptionGui CustomGuiPrefab => _customDescription.CustomGuiPrefab;

		public string[] CustomDescriptionContent => _customDescription.CustomDescriptionContent;

		public Color? HsWarningColor
		{
			get
			{
				IHumeShieldProvider[] humeShields = _humeShields;
				for (int i = 0; i < humeShields.Length; i++)
				{
					Color? hsWarningColor = humeShields[i].HsWarningColor;
					if (hsWarningColor.HasValue)
					{
						return hsWarningColor;
					}
				}
				return null;
			}
		}

		public AlertContent Alert
		{
			get
			{
				IItemAlertDrawer[] alertDrawers = _alertDrawers;
				foreach (IItemAlertDrawer itemAlertDrawer in alertDrawers)
				{
					if (itemAlertDrawer.Alert.Active)
					{
						return itemAlertDrawer.Alert;
					}
				}
				return default;
			}
		}

		public bool ValidateAmmoDrop(ItemType id)
		{
			return !AnyTrue(_dropPreventers, (IAmmoDropPreventer x) => !x.ValidateAmmoDrop(id));
		}

		private static bool AnyTrue<T>(T[] arr, Func<T, bool> selector)
		{
			foreach (T arg in arr)
			{
				if (selector(arg))
				{
					return true;
				}
			}
			return false;
		}

		private static float MinValue<T>(T[] arr, float startMin, Func<T, float> selector, Func<T, bool> validator = null)
		{
			float num = startMin;
			foreach (T arg in arr)
			{
				if (validator == null || validator(arg))
				{
					num = Mathf.Min(num, selector(arg));
				}
			}
			return num;
		}

		private static float CombineMultiplier<T>(T[] arr, Func<T, float> selector, Func<T, bool> validator = null)
		{
			float num = 1f;
			foreach (T arg in arr)
			{
				if (validator == null || validator(arg))
				{
					num *= selector(arg);
				}
			}
			return num;
		}

		private static float CombineAdditive<T>(T[] arr, Func<T, float> selector, Func<T, bool> validator = null)
		{
			float num = 0f;
			foreach (T arg in arr)
			{
				if (validator == null || validator(arg))
				{
					num += selector(arg);
				}
			}
			return num;
		}

		private void FetchModifiers<T>(T[] nonAllocArray, ref T[] targetArray)
		{
			int num = 0;
			SubcomponentBase[] allSubcomponents = _item.AllSubcomponents;
			for (int i = 0; i < allSubcomponents.Length; i++)
			{
				if (allSubcomponents[i] is T val)
				{
					nonAllocArray[num++] = val;
				}
			}
			targetArray = new T[num];
			Array.Copy(nonAllocArray, targetArray, num);
		}

		public AutosyncModifiersCombiner(ModularAutosyncItem item)
		{
			_item = item;
			FetchModifiers(MovementSpeedModifiersNonAlloc, ref _movementSpeedModifiers);
			FetchModifiers(StaminaModifiersNonAlloc, ref _staminaModifiers);
			FetchModifiers(SprintSpeedModifierNonAlloc, ref _sprintSpeedModifiers);
			FetchModifiers(ZoomModifiersNonAlloc, ref _zoomModifiers);
			FetchModifiers(LightEmittersNonAlloc, ref _lightEmitters);
			FetchModifiers(DropPreventersNonAlloc, ref _dropPreventers);
			FetchModifiers(HumeShieldProvidersNonAlloc, ref _humeShields);
			FetchModifiers(AlertDrawersNonAlloc, ref _alertDrawers);
			item.TryGetSubcomponent<ICustomDescriptionItem>(out _customDescription);
		}
	}
}
