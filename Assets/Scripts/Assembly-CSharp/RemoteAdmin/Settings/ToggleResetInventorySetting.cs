using System;
using RemoteAdmin.Generic;

namespace RemoteAdmin.Settings
{
	[Serializable]
	public class ToggleResetInventorySetting : ToggleableSetting
	{
		public override string Path => "RA_ResetInventory";

		public override bool DefaultValue => true;
	}
}