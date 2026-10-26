using System;
using Mirror;
using UnityEngine;

namespace InventorySystem.Items.Firearms.Attachments
{
	public class WorkstationAttachmentSelector : AttachmentSelectorBase
	{
		[SerializeField]
		private WorkstationController _controllerRef;

		[SerializeField]
		private float _rescaleSpeed = 10f;

		[SerializeField]
		private GameObject _panelMain;

		[SerializeField]
		private GameObject _panelNoWeapon;

		[SerializeField]
		private GameObject _panelUnknownWeapon;

		protected override bool UseLookatMode { get; set; }

		protected override void SelectAttachmentId(byte attachmentId)
		{
			int num = attachmentId;
			for (int i = 0; i < base.SelectedFirearm.Attachments.Length; i++)
			{
				if (base.SelectedFirearm.Attachments[i].Slot == SelectedSlot && base.SelectedFirearm.Attachments[i].IsEnabled)
				{
					num = i;
					base.SelectedFirearm.Attachments[i].IsEnabled = false;
					break;
				}
			}
			base.SelectedFirearm.Attachments[attachmentId].IsEnabled = true;
			uint currentAttachmentsCode = base.SelectedFirearm.GetCurrentAttachmentsCode();
			AttachmentPreferences.SetPreset(base.SelectedFirearm.ItemTypeId, 0);
			base.SelectedFirearm.SavePreferenceCode();
			base.SelectedFirearm.Attachments[attachmentId].IsEnabled = false;
			base.SelectedFirearm.Attachments[num].IsEnabled = true;
			SentChangeRequest(currentAttachmentsCode);
		}

		protected override void LoadPreset(uint loadedCode)
		{
			AttachmentPreferences.SavePreferenceCode(base.SelectedFirearm.ItemTypeId, loadedCode);
			SentChangeRequest(loadedCode);
		}

		public override void RegisterAction(RectTransform rt, Action<Vector2> action)
		{
			rt.gameObject.AddComponent<WorkstationActionTrigger>().TargetAction = action;
		}

		private void SentChangeRequest(uint code)
		{
			NetworkClient.Send(new AttachmentsChangeRequest
			{
				AttachmentsCode = code,
				WeaponSerial = base.SelectedFirearm.OwnerInventory.CurItem.SerialNumber
			});
		}

		private void Start()
		{
			UseLookatMode = PlayerPrefsSl.Get("FastWorkstationMode", defaultValue: false);
		}

		private void Update()
		{
			if (!ReferenceHub.TryGetLocalHub(out var hub))
			{
				return;
			}
			Firearm firearm = hub.inventory.CurInstance as Firearm;
			if (firearm == null || !_controllerRef.IsInRange(firearm.Owner))
			{
				ShowInactivePanel(_panelNoWeapon);
			}
			else if (firearm.Attachments.Length > 1)
			{
				ShowPanel(_panelMain);
				LerpRects(Time.deltaTime * _rescaleSpeed);
				MonoBehaviour[] slotsPool = SlotsPool;
				for (int i = 0; i < slotsPool.Length; i++)
				{
					((WorkstationSelectorCollider)slotsPool[i]).UpdateColors(SelectedSlot);
				}
				slotsPool = SelectableAttachmentsPool;
				for (int i = 0; i < slotsPool.Length; i++)
				{
					((WorkstationSelectorCollider)slotsPool[i]).UpdateColors(SelectedSlot);
				}
				RefreshState(firearm, null);
			}
			else
			{
				ShowInactivePanel(_panelUnknownWeapon);
			}
		}

		private void ShowInactivePanel(GameObject go)
		{
			ShowPanel(go);
			base.SelectedFirearm = null;
			ToggleSummaryScreen(summary: false);
		}

		private void ShowPanel(GameObject go)
		{
			_panelMain.SetActive(_panelMain == go);
			_panelNoWeapon.SetActive(_panelNoWeapon == go);
			_panelUnknownWeapon.SetActive(_panelUnknownWeapon == go);
		}
	}
}
