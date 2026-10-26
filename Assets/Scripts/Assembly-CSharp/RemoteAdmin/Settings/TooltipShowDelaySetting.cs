using System;
using RemoteAdmin.Generic;

namespace RemoteAdmin.Settings
{
	[Serializable]
	public class TooltipShowDelaySetting : TooltipSetting
	{
		public override string Path => "RA_TooltipShowDelay";

		public override float DefaultValue => 0.5f;

		protected override void ChangeTooltip(float value)
		{
			if (base.TooltipManager != null)
			{
				base.TooltipManager.ShowDelay = value;
			}
		}
	}
}
