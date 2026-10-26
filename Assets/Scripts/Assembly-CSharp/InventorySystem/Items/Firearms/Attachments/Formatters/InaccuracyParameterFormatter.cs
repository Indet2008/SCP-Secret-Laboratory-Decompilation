using UnityEngine;

namespace InventorySystem.Items.Firearms.Attachments.Formatters
{
	public class InaccuracyParameterFormatter : IAttachmentsParameterFormatter
	{
		public float DefaultValue => 1f;

		public bool FormatParameter(AttachmentParam param, Firearm firearm, int attId, float val, out string formattedText, out bool isGood)
		{
			isGood = val < 1f;
			formattedText = (isGood ? "+" : "-") + Mathf.Abs(Mathf.Round((1f - 1f / val) * 100f)) + "%";
			return true;
		}
	}
}
