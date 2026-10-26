using System;
using RemoteAdmin.Generic;

namespace RemoteAdmin.Settings
{
	[Serializable]
	public class ToggleMovementSetting : ToggleableSetting
	{
		public override string Path => "RA_ToggleMovement";

		public override bool DefaultValue => false;
	}
}