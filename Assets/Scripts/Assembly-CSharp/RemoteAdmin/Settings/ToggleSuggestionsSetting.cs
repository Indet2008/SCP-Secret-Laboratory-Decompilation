using System;
using RemoteAdmin.Generic;

namespace RemoteAdmin.Settings
{
	[Serializable]
	public class ToggleSuggestionsSetting : ToggleableSetting
	{
		public override string Path => "RA_ToggleSuggestions";

		public override bool DefaultValue => true;
	}
}