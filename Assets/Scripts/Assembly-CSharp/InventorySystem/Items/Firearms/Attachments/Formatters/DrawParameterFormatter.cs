using InventorySystem.Items.Firearms.Modules;
using UnityEngine;

namespace InventorySystem.Items.Firearms.Attachments.Formatters
{
	public class DrawParameterFormatter : IAttachmentsParameterFormatter
	{
		public float DefaultValue => 0f;

		public bool FormatParameter(AttachmentParam param, Firearm firearm, int attId, float val, out string formattedText, out bool isGood)
		{
			float num4;
			if (param == AttachmentParam.DrawSpeedMultiplier)
			{
				float num = (firearm.TryGetModule<IEquipperModule>(out var module) ? module.DisplayBaseEquipTime : 0f);
				float num2 = firearm.AttachmentsValue(AttachmentParam.DrawTimeModifier);
				float num3 = num + num2;
				num4 = num3 / val - num3;
			}
			else
			{
				float num5 = firearm.AttachmentsValue(AttachmentParam.DrawSpeedMultiplier);
				num4 = ((val > 0f) ? (val / num5) : (val * num5));
			}
			isGood = num4 < 0f;
			formattedText = (isGood ? "-" : "+") + Mathf.Abs(Mathf.Round(num4 * 100f) / 100f) + "s";
			return true;
		}
	}
}
