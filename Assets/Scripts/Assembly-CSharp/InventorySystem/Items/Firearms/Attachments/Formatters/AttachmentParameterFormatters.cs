using System.Collections.Generic;

namespace InventorySystem.Items.Firearms.Attachments.Formatters
{
	public static class AttachmentParameterFormatters
	{
		public static readonly Dictionary<AttachmentParam, IAttachmentsParameterFormatter> Formatters = new Dictionary<AttachmentParam, IAttachmentsParameterFormatter>
		{
			[AttachmentParam.AdsZoomMultiplier] = new ZoomParameterFormatter(),
			[AttachmentParam.DamageMultiplier] = new StandardParameterFormatter(moreIsBetter: true),
			[AttachmentParam.PenetrationMultiplier] = new StandardParameterFormatter(moreIsBetter: true),
			[AttachmentParam.FireRateMultiplier] = new StandardParameterFormatter(moreIsBetter: true),
			[AttachmentParam.OverallRecoilMultiplier] = new StandardParameterFormatter(moreIsBetter: false),
			[AttachmentParam.AdsRecoilMultiplier] = new StandardParameterFormatter(moreIsBetter: false),
			[AttachmentParam.BulletInaccuracyMultiplier] = new InaccuracyParameterFormatter(),
			[AttachmentParam.HipInaccuracyMultiplier] = new InaccuracyParameterFormatter(),
			[AttachmentParam.AdsInaccuracyMultiplier] = new InaccuracyParameterFormatter(),
			[AttachmentParam.GunshotLoudnessMultiplier] = new StandardParameterFormatter(moreIsBetter: false),
			[AttachmentParam.MagazineCapacityModifier] = new StandardParameterFormatter(moreIsBetter: true, isMultiplier: false, formatAsPercent: false),
			[AttachmentParam.DrawTimeModifier] = new DrawParameterFormatter(),
			[AttachmentParam.DrawSpeedMultiplier] = new DrawParameterFormatter(),
			[AttachmentParam.ReloadTimeModifier] = new StandardParameterFormatter(moreIsBetter: false, isMultiplier: false, formatAsPercent: false, "s"),
			[AttachmentParam.AdsSpeedMultiplier] = new StandardParameterFormatter(moreIsBetter: true),
			[AttachmentParam.SpreadMultiplier] = new StandardParameterFormatter(moreIsBetter: false),
			[AttachmentParam.SpreadPredictability] = new StandardParameterFormatter(moreIsBetter: true),
			[AttachmentParam.AmmoConsumptionMultiplier] = new StandardParameterFormatter(moreIsBetter: true),
			[AttachmentParam.ReloadSpeedMultiplier] = new StandardParameterFormatter(moreIsBetter: true),
			[AttachmentParam.RunningInaccuracyMultiplier] = new StandardParameterFormatter(moreIsBetter: false),
			[AttachmentParam.DoubleActionSpeedMultiplier] = new StandardParameterFormatter(moreIsBetter: true)
		};
	}
}
