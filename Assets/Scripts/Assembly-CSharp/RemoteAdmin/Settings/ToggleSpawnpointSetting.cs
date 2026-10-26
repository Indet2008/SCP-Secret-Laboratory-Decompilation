using System;
using RemoteAdmin.Generic;

namespace RemoteAdmin.Settings
{
	[Serializable]
	public class ToggleSpawnpointSetting : ToggleableSetting
	{
		public override string Path => "RA_UseSpawnpoint";

		public override bool DefaultValue => true;
	}
}