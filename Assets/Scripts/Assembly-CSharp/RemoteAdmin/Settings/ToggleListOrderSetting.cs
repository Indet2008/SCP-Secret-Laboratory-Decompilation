using System;
using RemoteAdmin.Generic;

namespace RemoteAdmin.Settings
{
	[Serializable]
	public class ToggleListOrderSetting : ToggleableSetting
	{
		public override string Path => "RA_ToggleListOrder";

		public override bool DefaultValue => false;
	}
}