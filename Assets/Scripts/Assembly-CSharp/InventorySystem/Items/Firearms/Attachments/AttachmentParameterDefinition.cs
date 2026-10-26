using System.Collections.Generic;

namespace InventorySystem.Items.Firearms.Attachments
{
	public readonly struct AttachmentParameterDefinition
	{
		public static readonly Dictionary<AttachmentParam, AttachmentParameterDefinition> Definitions = new Dictionary<AttachmentParam, AttachmentParameterDefinition>
		{
			[AttachmentParam.AdsZoomMultiplier] = new AttachmentParameterDefinition(ParameterMixingMode.Percent),
			[AttachmentParam.AdsMouseSensitivityMultiplier] = new AttachmentParameterDefinition(ParameterMixingMode.Percent),
			[AttachmentParam.DamageMultiplier] = new AttachmentParameterDefinition(ParameterMixingMode.Percent),
			[AttachmentParam.PenetrationMultiplier] = new AttachmentParameterDefinition(ParameterMixingMode.Percent),
			[AttachmentParam.FireRateMultiplier] = new AttachmentParameterDefinition(ParameterMixingMode.Percent),
			[AttachmentParam.OverallRecoilMultiplier] = new AttachmentParameterDefinition(ParameterMixingMode.Percent, 0.2f),
			[AttachmentParam.AdsRecoilMultiplier] = new AttachmentParameterDefinition(ParameterMixingMode.Percent, 0.2f),
			[AttachmentParam.BulletInaccuracyMultiplier] = new AttachmentParameterDefinition(ParameterMixingMode.Percent),
			[AttachmentParam.HipInaccuracyMultiplier] = new AttachmentParameterDefinition(ParameterMixingMode.Percent, 0.2f),
			[AttachmentParam.AdsInaccuracyMultiplier] = new AttachmentParameterDefinition(ParameterMixingMode.Percent, 0.1f),
			[AttachmentParam.DrawSpeedMultiplier] = new AttachmentParameterDefinition(ParameterMixingMode.Percent),
			[AttachmentParam.GunshotLoudnessMultiplier] = new AttachmentParameterDefinition(ParameterMixingMode.Percent),
			[AttachmentParam.MagazineCapacityModifier] = new AttachmentParameterDefinition(ParameterMixingMode.Additive),
			[AttachmentParam.DrawTimeModifier] = new AttachmentParameterDefinition(ParameterMixingMode.Additive),
			[AttachmentParam.ReloadTimeModifier] = new AttachmentParameterDefinition(ParameterMixingMode.Additive),
			[AttachmentParam.ShotClipIdOverride] = new AttachmentParameterDefinition(ParameterMixingMode.Override),
			[AttachmentParam.AdsSpeedMultiplier] = new AttachmentParameterDefinition(ParameterMixingMode.Percent),
			[AttachmentParam.SpreadMultiplier] = new AttachmentParameterDefinition(ParameterMixingMode.Percent),
			[AttachmentParam.SpreadPredictability] = new AttachmentParameterDefinition(ParameterMixingMode.Percent),
			[AttachmentParam.AmmoConsumptionMultiplier] = new AttachmentParameterDefinition(ParameterMixingMode.Percent),
			[AttachmentParam.ReloadSpeedMultiplier] = new AttachmentParameterDefinition(ParameterMixingMode.Percent),
			[AttachmentParam.PreventReload] = new AttachmentParameterDefinition(ParameterMixingMode.Additive),
			[AttachmentParam.RunningInaccuracyMultiplier] = new AttachmentParameterDefinition(ParameterMixingMode.Percent),
			[AttachmentParam.DoubleActionSpeedMultiplier] = new AttachmentParameterDefinition(ParameterMixingMode.Percent)
		};

		public readonly ParameterMixingMode MixingMode;

		public readonly float MinValue;

		public readonly float MaxValue;

		public float DefaultValue => (MixingMode == ParameterMixingMode.Percent) ? 1 : 0;

		public AttachmentParameterDefinition(ParameterMixingMode mode, float min = float.MinValue, float max = float.MaxValue)
		{
			MixingMode = mode;
			MinValue = min;
			MaxValue = max;
		}
	}
}
