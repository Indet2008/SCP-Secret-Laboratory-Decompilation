using System;
using RemoteAdmin.Communication;
using RemoteAdmin.Generic;

namespace RemoteAdmin.Settings
{
	[Serializable]
	public class PlayerListSortingSetting : EnumSetting<RaPlayerList.PlayerSorting>
	{
		public override string Path => "RA_PlayerListSorting";

		public override RaPlayerList.PlayerSorting Value
		{
			get
			{
				return base.Value;
			}
			set
			{
				base.Value = value;
			}
		}

		protected override void OnLoad()
		{
			base.OnLoad();
		}
	}
}
