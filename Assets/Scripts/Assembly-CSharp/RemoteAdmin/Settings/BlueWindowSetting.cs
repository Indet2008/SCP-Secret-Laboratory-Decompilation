using System;
using RemoteAdmin.Generic;
using UnityEngine;

namespace RemoteAdmin.Settings
{
	[Serializable]
	public class BlueWindowSetting : ColorSliderSetting
	{
		public override string Path => "RA_WindowBlue";

		protected override float GetChannel(Color color)
		{
			return color.b;
		}

		protected override Color CreateColor(Color oldColor, float value)
		{
			oldColor.b = value;
			return oldColor;
		}
	}
}