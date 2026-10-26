using UnityEngine;

namespace InventorySystem.Items.Firearms.Attachments.Formatters
{
	public class StandardParameterFormatter : IAttachmentsParameterFormatter
	{
		private readonly bool _isMultiplier;

		private readonly bool _moreIsBetter;

		private readonly bool _formatAsPrecent;

		private readonly string _suffix;

		public float DefaultValue => _isMultiplier ? 1 : 0;

		public StandardParameterFormatter(bool moreIsBetter, bool isMultiplier = true, bool formatAsPercent = true, string suffix = null)
		{
			_isMultiplier = isMultiplier;
			_moreIsBetter = moreIsBetter;
			_formatAsPrecent = formatAsPercent;
			_suffix = suffix;
		}

		public bool FormatParameter(AttachmentParam param, Firearm firearm, int attId, float statsValue, out string formattedText, out bool isGood)
		{
			formattedText = null;
			isGood = false;
			float num = DefaultValue;
			for (int i = 0; i < firearm.Attachments.Length; i++)
			{
				if (attId >= 0 && firearm.Attachments[attId].Slot == firearm.Attachments[i].Slot)
				{
					if (firearm.Attachments[i].TryGetDisplayValue(param, out var val))
					{
						num = val;
					}
					break;
				}
			}
			if (num == statsValue)
			{
				return false;
			}
			isGood = (_moreIsBetter ? (statsValue > num) : (statsValue < num));
			string text = ((statsValue > num) ? "+" : "-");
			if (_formatAsPrecent)
			{
				float f = ((num == 0f) ? (statsValue - num) : (1f - statsValue / num));
				formattedText = text + Mathf.Round(Mathf.Abs(f) * 1000f) / 10f + "%";
			}
			else
			{
				formattedText = text + Mathf.Round(Mathf.Abs(statsValue - num) * 10f) / 10f;
			}
			if (!string.IsNullOrEmpty(_suffix))
			{
				formattedText += _suffix;
			}
			return true;
		}
	}
}
