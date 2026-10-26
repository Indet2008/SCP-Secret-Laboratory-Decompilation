using System;
using InventorySystem.Items.Firearms.Attachments.Components;
using UnityEngine;

namespace InventorySystem.Items.Firearms.Attachments.Formatters
{
	public static class NonParameterFormatter
	{
		private const int FlagsIteration = 8;

		private static string WeightString => "\n" + TranslationReader.Get("InventoryGUI", 5) + ": ";

		private static string LengthString => "\n" + TranslationReader.Get("InventoryGUI", 6) + ": ";

		public static void Format(Firearm fa, int attachmentId, out string pros, out string cons)
		{
			int num = attachmentId;
			pros = string.Empty;
			cons = string.Empty;
			Attachment attachment = fa.Attachments[attachmentId];
			for (int i = 0; i < fa.Attachments.Length; i++)
			{
				if (fa.Attachments[i].Slot == fa.Attachments[attachmentId].Slot)
				{
					num = i;
					break;
				}
			}
			pros += FormatFlags((int)attachment.DescriptivePros, typeof(AttachmentDescriptiveAdvantages), "AttachmentDescriptiveAdvantages");
			cons += FormatFlags((int)attachment.DescriptiveCons, typeof(AttachmentDescriptiveDownsides), "AttachmentDescriptiveDownsides");
			if (num != attachmentId)
			{
				fa.GetDefaultLengthAndWeight(out var length, out var weight);
				float num2 = (attachment.Length - fa.Attachments[num].Length + length) / length;
				float num3 = (attachment.Weight - fa.Attachments[num].Weight + weight) / weight;
				string text = LengthString + FormatPercent(num2);
				string text2 = WeightString + FormatPercent(num3);
				if (num2 > 1f)
				{
					cons += text;
				}
				if (num2 < 1f)
				{
					pros += text;
				}
				if (num3 > 1f)
				{
					cons += text2;
				}
				if (num3 < 1f)
				{
					pros += text2;
				}
			}
		}

		private static string FormatPercent(float percent)
		{
			return ((percent < 1f) ? "-" : "+") + Mathf.RoundToInt(Mathf.Abs(percent - 1f) * 100f) + "%";
		}

		private static string FormatFlags(int value, Type enumType, string translationKey)
		{
			int num = 2;
			string text = string.Empty;
			for (int i = 0; i < 8; i++)
			{
				if (Enum.IsDefined(enumType, num) && (value & num) == num)
				{
					text = text + "\n" + TranslationReader.Get(translationKey, i, "NO_FLAGS_TRANSLATION");
				}
				num *= 2;
			}
			return text;
		}
	}
}
