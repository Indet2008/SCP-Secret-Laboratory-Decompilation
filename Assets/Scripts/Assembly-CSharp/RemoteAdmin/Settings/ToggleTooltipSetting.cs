using System;
using RemoteAdmin.Generic;
using Tooltips;
using UnityEngine;

namespace RemoteAdmin.Settings
{
	[Serializable]
	public class ToggleTooltipSetting : ToggleableSetting
	{
		public override bool DefaultValue => true;

		public override string Path => "RA_ToggleTooltip";

		public override bool Value
		{
			get
			{
				return base.Value;
			}
			set
			{
				base.Value = value;
				ChangeTooltip(value);
			}
		}

		[field: SerializeField]
		public TooltipManager TooltipManager { get; set; }

		private void ChangeTooltip(bool value)
		{
			if (TooltipManager != null)
			{
				TooltipManager.IsEnabled = value;
			}
		}
	}
}
