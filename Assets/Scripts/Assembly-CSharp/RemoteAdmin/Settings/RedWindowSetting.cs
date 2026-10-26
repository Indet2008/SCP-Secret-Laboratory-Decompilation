using System;
using RemoteAdmin.Generic;
using UnityEngine;

namespace RemoteAdmin.Settings
{
	[Serializable]
	public class RedWindowSetting : ColorSliderSetting
	{
		public override string Path => "RA_WindowRed";

		protected override float GetChannel(Color color)
		{
			return color.r;
		}

		protected override Color CreateColor(Color oldColor, float value)
		{
			oldColor.r = value;
			return oldColor;
		}
	}
}