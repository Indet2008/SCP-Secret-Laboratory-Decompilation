using System;
using RemoteAdmin.Generic;

namespace RemoteAdmin.Settings
{
	[Serializable]
	public class ToggleItemOrderSetting : ToggleableSetting
	{
		public override string Path => "RA_ToggleItemOrder";

		public override bool DefaultValue => false;
	}
}