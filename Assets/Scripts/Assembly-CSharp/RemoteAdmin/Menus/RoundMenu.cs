using RemoteAdmin.Communication;
using TMPro;
using UnityEngine;
using UnityEngine.UI;

namespace RemoteAdmin.Menus
{
	public class RoundMenu : RaCommandMenu
	{
		private enum Panel
		{
			ServerEvents = 0,
			TicketSystem = 1
		}

		private const string DisabledCode = "🔒";

		private const string EnabledCode = "🔓";

		[SerializeField]
		private Color _enabledStatus;

		[SerializeField]
		private Color _disabledStatus;

		[SerializeField]
		private RespawnWaveInfo[] _infos;

		[SerializeField]
		private Scrollbar _scrollBar;

		[SerializeField]
		private TMP_Text _roundLock;

		[SerializeField]
		private TMP_Text _lobbyLock;

		[SerializeField]
		private TMP_Text _warheadLock;

		[SerializeField]
		private TMP_Text _friendlyFire;

		[SerializeField]
		private TMP_Text _spawnProtect;

		private RaServerStatus _serverChannel;

		private RaTeamStatus _teamChannel;

		private Panel _selectedPanel;

		private float _updateTimer;

		private bool _loggedFirstStatus;

		public void SetPanel(int panel)
		{
			_selectedPanel = (Panel)panel;
			RequestData();
		}

		public void RequestData()
		{
			RemoteAdminClient.SendQuery("$7 0", logQuery: false);
			RemoteAdminClient.SendQuery("$8 0", logQuery: false);
		}

		public override void SendCommand(string command, string format = "")
		{
			base.SendCommand(command, format);
			_updateTimer = Time.unscaledTime + 0.3f;
		}

		protected override void OnStart()
		{
			_serverChannel = CommunicationProcessor.RequestClientChannel<RaServerStatus>();
			_teamChannel = CommunicationProcessor.RequestClientChannel<RaTeamStatus>();
			if (_serverChannel != null)
			{
				_serverChannel.OnDataReceived += RefreshServerWindow;
			}
			if (_teamChannel != null)
			{
				_teamChannel.OnDataReceived += RefreshTeamWindow;
			}
			if (_serverChannel == null)
			{
				Debug.LogWarning("[RoundMenu] RaServerStatus client channel missing; lock icons will not update.");
			}
			RequestData();
		}

		protected override void OnUpdate()
		{
			if (!(Time.unscaledTime < _updateTimer))
			{
				_updateTimer = Time.unscaledTime + 1f;
				RequestData();
			}
		}

		private void OnDestroy()
		{
			if (_serverChannel != null)
			{
				_serverChannel.OnDataReceived -= RefreshServerWindow;
			}
			if (_teamChannel != null)
			{
				_teamChannel.OnDataReceived -= RefreshTeamWindow;
			}
		}

		private static string StripHeader(string data)
		{
			data = data ?? string.Empty;
			if (data.StartsWith("$"))
			{
				int num = data.IndexOf(' ');
				data = ((num < 0) ? string.Empty : data.Substring(num + 1));
			}
			return data;
		}

		private void RefreshTeamWindow(string obj)
		{
			if (_infos == null)
			{
				return;
			}
			string[] array = StripHeader(obj).Split(';');
			for (int i = 0; i < _infos.Length && i < array.Length; i++)
			{
				string[] array2 = array[i].Split(',');
				if (array2.Length >= 5 && !(_infos[i] == null))
				{
					int.TryParse(array2[0], out var result);
					float.TryParse(array2[1], out var result2);
					float.TryParse(array2[2], out var result3);
					float.TryParse(array2[3], out var result4);
					_infos[i].SetData(result, Mathf.RoundToInt(result2), Mathf.RoundToInt(result3), result4, array2[4].Trim() == "1");
				}
			}
		}

		private void RefreshServerWindow(string obj)
		{
			if (!_loggedFirstStatus)
			{
				_loggedFirstStatus = true;
				Debug.Log("[RoundMenu] First server status received: " + obj);
			}
			string[] array = StripHeader(obj).Split(',');
			if (array.Length >= 5)
			{
				UpdateIcon(_roundLock, array[0] == "1");
				UpdateIcon(_lobbyLock, array[1] == "1");
				UpdateIcon(_warheadLock, array[2] == "1");
				UpdateIcon(_friendlyFire, array[3] == "1", changeIcon: false, inversedColors: true);
				UpdateIcon(_spawnProtect, array[4] == "1", changeIcon: false, inversedColors: true);
			}
		}

		private void UpdateIcon(TMP_Text textComponent, bool isEnabled, bool changeIcon = true, bool inversedColors = false)
		{
			if (!(textComponent == null))
			{
				// Active (locked / enabled) state shows the green icon.
				if (changeIcon)
				{
					textComponent.text = (isEnabled ? EnabledCode : DisabledCode);
				}
				textComponent.color = (isEnabled ? _enabledStatus : _disabledStatus);
			}
		}
	}
}
