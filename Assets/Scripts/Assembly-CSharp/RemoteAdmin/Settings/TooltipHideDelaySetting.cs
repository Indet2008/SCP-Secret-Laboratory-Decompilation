using System;
using RemoteAdmin.Generic;

namespace RemoteAdmin.Settings
{
	[Serializable]
	public class TooltipHideDelaySetting : TooltipSetting
	{
		public override string Path => "RA_TooltipHideDelay";

		public override float DefaultValue => 0.1f;

		protected override void ChangeTooltip(float value)
		{
			if (base.TooltipManager != null)
			{
				base.TooltipManager.HideDelay = value;
			}
		}
	}
}
