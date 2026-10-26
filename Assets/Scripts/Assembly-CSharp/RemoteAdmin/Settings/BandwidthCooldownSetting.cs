using System;
using RemoteAdmin.Generic;

namespace RemoteAdmin.Settings
{
	[Serializable]
	public class BandwidthCooldownSetting : CustomSliderSetting
	{
		public override string Path => "RA_BandwidthCooldown";

		public override float DefaultValue => 1f;
	}
}
