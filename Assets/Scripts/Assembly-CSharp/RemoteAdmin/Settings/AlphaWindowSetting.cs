using System;
using RemoteAdmin.Generic;
using UnityEngine;

namespace RemoteAdmin.Settings
{
	[Serializable]
	public class AlphaWindowSetting : ColorSliderSetting
	{
		public override string Path => "RA_WindowAlpha";

		protected override float GetChannel(Color color)
		{
			return color.a;
		}

		protected override Color CreateColor(Color oldColor, float value)
		{
			oldColor.a = value;
			return oldColor;
		}
	}
}