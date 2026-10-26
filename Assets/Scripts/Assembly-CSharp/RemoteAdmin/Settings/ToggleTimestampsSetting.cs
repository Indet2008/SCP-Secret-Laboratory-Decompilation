using System;
using RemoteAdmin.Generic;

namespace RemoteAdmin.Settings
{
	[Serializable]
	public class ToggleTimestampsSetting : ToggleableSetting
	{
		public override string Path => "RA_ToggleTimestamps";

		public override bool DefaultValue => true;
	}
}