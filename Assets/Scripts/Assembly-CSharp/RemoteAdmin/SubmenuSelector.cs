using System;
using System.Text;
using RemoteAdmin.Communication;
using TMPro;
using UnityEngine;
using UnityEngine.UI;

namespace RemoteAdmin
{
	public class SubmenuSelector : MonoBehaviour
	{
		[Serializable]
		public class SubMenu
		{
			public string Title;

			public TMP_Text ButtonText;

			public GameObject Panel;

			public TMP_Text RaResponseBox;

			public SubmenuSelector Selector { get; set; }

			public void Reset()
			{
				if (RaResponseBox != null)
				{
					RaResponseBox.text = string.Empty;
				}
				if (ButtonText != null && Selector != null)
				{
					ButtonText.color = Selector.c_deselected;
				}
				if (Panel != null)
				{
					Panel.SetActive(value: false);
				}
			}

			public void Select()
			{
				if (Panel != null)
				{
					Panel.SetActive(value: true);
				}
				if (ButtonText != null && Selector != null)
				{
					ButtonText.color = Selector.c_selected;
				}
			}

			public void SetResponse(bool isSuccess, string content)
			{
				SetResponse(isSuccess ? Color.green : Color.red, content);
			}

			public void SetResponse(Color color, string content)
			{
				if (RaResponseBox != null)
				{
					RaResponseBox.color = color;
					RaResponseBox.text = content;
				}
			}
		}

		public Color c_selected;

		public Color c_deselected;

		public SubMenu[] menus;

		public TMP_Text WindowTitle;

		[Header("Toggled On Colors:")]
		public ColorBlock ToggleOn;

		[Header("Toggled Off Colors:")]
		public ColorBlock ToggleOff;

		private SubMenu _currentMenu;

		private int _currentMenuIndex;

		private int _lastMenuIndex;

		public static SubmenuSelector Singleton { get; private set; }

		public SubMenu SelectedMenu => _currentMenu;

		private void Awake()
		{
			Singleton = this;
			if (menus == null)
			{
				return;
			}
			SubMenu[] array = menus;
			foreach (SubMenu subMenu in array)
			{
				if (subMenu != null)
				{
					subMenu.Selector = this;
				}
			}
		}

		private void Start()
		{
			if (menus == null || menus.Length == 0)
			{
				return;
			}
			SubMenu[] array = menus;
			foreach (SubMenu subMenu in array)
			{
				subMenu?.Reset();
			}
			SelectMenu(menus[0]);
		}

		private void Update()
		{
			if (_currentMenu == null || _currentMenu.RaResponseBox == null || !_currentMenu.RaResponseBox.gameObject.activeInHierarchy)
			{
				return;
			}
			int num = TMP_TextUtilities.FindIntersectingLink(_currentMenu.RaResponseBox, Input.mousePosition, null);
			if (num < 0 || num >= _currentMenu.RaResponseBox.textInfo.linkInfo.Length)
			{
				return;
			}
			string linkID = _currentMenu.RaResponseBox.textInfo.linkInfo[num].GetLinkID();
			string text = linkID switch
			{
				"CP_USERID" => RaClipboard.UserIds,
				"CP_IP" => RaClipboard.PlayerIps,
				"CP_ID" => RaClipboard.PlayerIds,
				_ => null,
			};
			if (text != null)
			{
				RemoteAdminUIController.Singleton?.SetToolTip("Click to copy to clipboard.");
				if (Input.GetMouseButtonDown(0))
				{
					GUIUtility.systemCopyBuffer = text;
				}
			}
		}

		public static string GetSelectedPlayerIds()
		{
			StringBuilder stringBuilder = new StringBuilder();
			foreach (PlayerRecord instance in PlayerRecord.Instances)
			{
				if (instance != null && instance.IsSelected)
				{
					stringBuilder.Append(instance.PlayerId).Append('.');
				}
			}
			return stringBuilder.ToString();
		}

		public void PlayerInfoQuery(string operation)
		{
			string selectedPlayerIds = GetSelectedPlayerIds();
			switch (operation)
			{
			case "short-info":
			case "shortinfo":
				if (selectedPlayerIds.Length != 0)
				{
					RaClipboard.Reset();
					RaPlayer.Request(isShort: true, selectedPlayerIds);
				}
				break;
			case "info":
				if (selectedPlayerIds.Length != 0)
				{
					RaClipboard.Reset();
					RaPlayer.Request(isShort: false, selectedPlayerIds);
				}
				break;
			case "auth":
				if (selectedPlayerIds.Length != 0)
				{
					RemoteAdminClient.SendQuery("$3 " + selectedPlayerIds, logQuery: false);
				}
				break;
			case "externallookup":
				if (selectedPlayerIds.Length != 0 && ReferenceHub.TryGetLocalHub(out var hub))
				{
					hub.queryProcessor.ExpectingURL = DateTime.Now.AddSeconds(10.0);
					RemoteAdminClient.SendQuery("EXTERNALLOOKUP " + selectedPlayerIds.TrimEnd('.'));
				}
				break;
			}
		}

		public void AdminToolsConfirm(string tool)
		{
			QueryProcessor queryProcessor = ReferenceHub.LocalHub.queryProcessor;
			if (tool == "GoTo")
			{
				PlayerRecord playerRecord = System.Linq.Enumerable.FirstOrDefault(PlayerRecord.Instances, (PlayerRecord x) => x != null && x.IsSelected);
				if (playerRecord != null)
				{
					queryProcessor.SendQuery("goto " + playerRecord.PlayerId);
				}
				return;
			}
			string text = GetSelectedPlayerIds();
			if (text.Length == 0)
			{
				return;
			}
			switch (tool)
			{
			case "BypassDisable":
				queryProcessor.SendQuery("bypass " + text + " 0");
				break;
			case "BypassEnable":
				queryProcessor.SendQuery("bypass " + text + " 1");
				break;
			case "Disarm":
				queryProcessor.SendQuery("disarm " + text);
				break;
			case "Release":
				queryProcessor.SendQuery("release " + text);
				break;
			case "OverwatchDisable":
				queryProcessor.SendQuery("overwatch " + text + " 0");
				break;
			case "OverwatchEnable":
				queryProcessor.SendQuery("overwatch " + text + " 1");
				break;
			case "GodDisable":
				queryProcessor.SendQuery("god " + text + " 0");
				break;
			case "GodEnable":
				queryProcessor.SendQuery("god " + text + " 1");
				break;
			case "NoclipDisable":
				queryProcessor.SendQuery("noclip " + text + " disable");
				break;
			case "NoclipEnable":
				queryProcessor.SendQuery("noclip " + text + " enable");
				break;
			case "Mute":
				queryProcessor.SendQuery("mute " + text);
				break;
			case "Unmute":
				queryProcessor.SendQuery("unmute " + text);
				break;
			case "Imute":
				queryProcessor.SendQuery("imute " + text);
				break;
			case "Iunmute":
				queryProcessor.SendQuery("iunmute " + text);
				break;
			case "Bring":
				queryProcessor.SendQuery("bring " + text);
				break;
			case "Heal":
				queryProcessor.SendQuery("heal " + text);
				break;
			case "Lockdown":
				queryProcessor.SendQuery("lockdown");
				break;
			}
		}

		public void RunCommand(string command)
		{
			if (string.IsNullOrEmpty(command))
			{
				return;
			}
			if (command.Contains("[players]"))
			{
				command = command.Replace("[players]", GetSelectedPlayerIds().TrimEnd('.'));
			}
			RemoteAdminClient.SendQuery(command);
		}

		internal static void ClearAll()
		{
			if (Singleton != null && Singleton.menus != null)
			{
				SubMenu[] array = Singleton.menus;
				foreach (SubMenu subMenu in array)
				{
					subMenu?.Reset();
				}
			}
			PlayerInfoQR.Clear();
		}

		public void ToggleMenu(GameObject panel)
		{
			SubMenu subMenu = FindMenu(panel);
			if (subMenu != null)
			{
				if (Array.IndexOf(menus, subMenu) != _currentMenuIndex)
				{
					SelectMenu(subMenu);
				}
				else
				{
					SelectMenu(_lastMenuIndex);
				}
			}
		}

		public void SelectMenu(int index)
		{
			if (menus != null && index >= 0 && index < menus.Length)
			{
				SelectMenu(menus[index]);
			}
		}

		public void SelectMenu(GameObject panel)
		{
			SubMenu subMenu = FindMenu(panel);
			if (subMenu != null)
			{
				SelectMenu(subMenu);
			}
		}

		public void SelectMenu(SubMenu subMenu)
		{
			if (subMenu != null)
			{
				PlayerInfoQR.Clear();
				_currentMenu?.Reset();
				subMenu.Selector = this;
				if (WindowTitle != null)
				{
					WindowTitle.text = subMenu.Title;
				}
				_lastMenuIndex = _currentMenuIndex;
				_currentMenuIndex = Array.IndexOf(menus, subMenu);
				_currentMenu = subMenu;
				subMenu.Select();
			}
		}

		private SubMenu FindMenu(GameObject panel)
		{
			if (menus == null || panel == null)
			{
				return null;
			}
			SubMenu[] array = menus;
			foreach (SubMenu subMenu in array)
			{
				if (subMenu != null && subMenu.Panel == panel)
				{
					return subMenu;
				}
			}
			return null;
		}
	}
}
