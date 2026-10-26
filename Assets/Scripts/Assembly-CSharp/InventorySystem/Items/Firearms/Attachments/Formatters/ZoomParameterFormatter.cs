using InventorySystem.Items.Firearms.Attachments.Components;
using UnityEngine;

namespace InventorySystem.Items.Firearms.Attachments.Formatters
{
	public class ZoomParameterFormatter : IAttachmentsParameterFormatter
	{
		public float DefaultValue => 1f;

		public bool FormatParameter(AttachmentParam param, Firearm firearm, int attId, float val, out string formattedText, out bool isGood)
		{
			float num;
			if (attId < 0)
			{
				num = firearm.AttachmentsValue(AttachmentParam.AdsMouseSensitivityMultiplier) * firearm.AttachmentsValue(AttachmentParam.AdsZoomMultiplier);
			}
			else
			{
				Attachment attachment = firearm.Attachments[attId];
				num = GetMultiplier(attachment, AttachmentParam.AdsMouseSensitivityMultiplier) * GetMultiplier(attachment, AttachmentParam.AdsZoomMultiplier);
			}
			formattedText = Mathf.Round(num * 100f) / 100f + "x";
			isGood = true;
			return true;
		}

		private float GetMultiplier(Attachment attachment, AttachmentParam param)
		{
			if (!attachment.TryGetDisplayValue(param, out var val))
			{
				return 1f;
			}
			return val;
		}
	}
}
