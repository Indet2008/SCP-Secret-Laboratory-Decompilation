using System;
using UnityEngine;
using UnityEngine.UI;

namespace RemoteAdmin.Menus
{
	public class DataRequestMenu : RaCommandMenu
	{
		public enum RequestType
		{
			Info = 0,
			ShortInfo = 1,
			Auth = 2,
			ExternalLookup = 3
		}

		[SerializeField]
		private Button _externalLookup;

		public void Query(RequestType requestType)
		{
			string text = requestType switch
			{
				RequestType.ShortInfo => "shortinfo", 
				RequestType.Auth => "auth", 
				RequestType.ExternalLookup => "externallookup", 
				_ => "info", 
			};
			if (SubmenuSelector.Singleton != null)
			{
				SubmenuSelector.Singleton.PlayerInfoQuery(text);
			}
		}

		public void Query(string requestType)
		{
			if (Enum.TryParse<RequestType>(requestType, ignoreCase: true, out var result))
			{
				Query(result);
			}
		}

		protected override void OnStart()
		{
			ServerConfigSynchronizer singleton = ServerConfigSynchronizer.Singleton;
			if (_externalLookup != null && singleton != null && singleton.RemoteAdminExternalPlayerLookupMode != null && singleton.RemoteAdminExternalPlayerLookupMode.Contains("disabled"))
			{
				_externalLookup.interactable = false;
			}
		}
	}
}