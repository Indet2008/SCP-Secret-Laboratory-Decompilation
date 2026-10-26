using System;
using RemoteAdmin.Generic;
using UnityEngine;

namespace RemoteAdmin.Settings
{
	[Serializable]
	public class GreenWindowSetting : ColorSliderSetting
	{
		public override string Path => "RA_WindowGreen";

		protected override float GetChannel(Color color)
		{
			return color.g;
		}

		protected override Color CreateColor(Color oldColor, float value)
		{
			oldColor.g = value;
			return oldColor;
		}
	}
}