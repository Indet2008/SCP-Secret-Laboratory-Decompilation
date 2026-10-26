using InventorySystem.Drawers;
using InventorySystem.GUI;
using InventorySystem.GUI.Descriptions;
using InventorySystem.Items.Autosync;
using InventorySystem.Items.MicroHID.Modules;
using UnityEngine;

namespace InventorySystem.Items.MicroHID
{
	public class MicroHIDItem : ModularAutosyncItem, ICustomDescriptionItem, IItemDescription, IItemNametag, IItemAlertDrawer, IItemDrawer, ISoundEmittingItem
	{
		private static readonly string[] ChargeMeterNonAlloc = new string[1];

		private readonly ItemHintAlertHelper _readyHint = new ItemHintAlertHelper(InventoryGuiTranslation.MicroHidReadyToDischarge, ActionName.Shoot, 0.3f, 2f);

		private readonly ItemHintAlertHelper _regularHint = new ItemHintAlertHelper(InventoryGuiTranslation.MicroHidPrimaryHint, ActionName.Shoot, InventoryGuiTranslation.MicroHidSecondaryHint, ActionName.Zoom);

		private readonly ItemHintAlertHelper _brokenHint = new ItemHintAlertHelper(InventoryGuiTranslation.MicroHidDamaged, null, InventoryGuiTranslation.MicroHidPrimaryHint, ActionName.Shoot);

		public override float Weight => 25.1f;

		public override bool AllowDropping => true;

		public override bool AllowHolster
		{
			get
			{
				if (base.AllowHolster)
				{
					return CycleController.Phase == MicroHidPhase.Standby;
				}
				return false;
			}
		}

		public EnergyManagerModule EnergyManager { get; private set; }

		public BacktrackerModule Backtracker { get; private set; }

		public InputSyncModule InputSync { get; private set; }

		public BrokenSyncModule BrokenSync { get; private set; }

		public CycleController CycleController { get; private set; }

		public override ItemDescriptionType DescriptionType => ItemDescriptionType.Custom;

		[field: SerializeField]
		public new CustomDescriptionGui CustomGuiPrefab { get; private set; }

		public new string[] CustomDescriptionContent
		{
			get
			{
				int num = Mathf.CeilToInt(EnergyManager.Energy * 100f);
				ChargeMeterNonAlloc[0] = FormatCharge(InventoryGuiTranslation.RemainingCharge, num + "%");
				return ChargeMeterNonAlloc;
			}
		}

		public string Description => ItemTypeId.GetDescription();

		public string Name => ItemTypeId.GetName();

		public new AlertContent Alert => ActiveAlertHelper.Alert;

		private ItemHintAlertHelper ActiveAlertHelper
		{
			get
			{
				if (CycleController.Phase == MicroHidPhase.WoundUpSustain)
				{
					return _readyHint;
				}
				_readyHint.Reset();
				if (!BrokenSync.Broken)
				{
					return _regularHint;
				}
				return _brokenHint;
			}
		}

		public override void EquipUpdate()
		{
			base.EquipUpdate();
			ActiveAlertHelper.Update(base.Owner);
		}

		public override void InitializeSubcomponents()
		{
			CycleController = CycleSyncModule.GetCycleController(base.ItemSerial);
			SubcomponentBase[] allSubcomponents = base.AllSubcomponents;
			foreach (SubcomponentBase subcomponentBase in allSubcomponents)
			{
				if (!(subcomponentBase is EnergyManagerModule energyManager))
				{
					if (!(subcomponentBase is BacktrackerModule backtracker))
					{
						if (!(subcomponentBase is InputSyncModule inputSync))
						{
							if (subcomponentBase is BrokenSyncModule brokenSync)
							{
								BrokenSync = brokenSync;
							}
						}
						else
						{
							InputSync = inputSync;
						}
					}
					else
					{
						Backtracker = backtracker;
					}
				}
				else
				{
					EnergyManager = energyManager;
				}
			}
			base.InitializeSubcomponents();
		}

		public bool TryGetSoundEmissionRange(out float range)
		{
			return AudioManagerModule.GetController(base.ItemSerial).TryGetSoundEmissionRange(out range);
		}

		public static string FormatCharge(InventoryGuiTranslation translation, string coloredText)
		{
			string format = Translations.Get(translation, "{0}");
			string arg = "</color>" + coloredText + "<color=white>";
			return "<color=white>" + string.Format(format, arg) + "</color>";
		}
	}
}
