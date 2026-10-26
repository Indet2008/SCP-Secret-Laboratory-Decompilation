using System;
using System.Collections.Generic;
using System.Text;
using RemoteAdmin.Communication;
using TMPro;
using UnityEngine;
using UnityEngine.UI;

namespace RemoteAdmin.Menus
{
	public class DummyMenu : RaCommandMenu
	{
		[Serializable]
		private struct CloneableButton
		{
			public GameObject Root;

			public Button Button;

			public TMP_Text Text;

			public CloneableButton(CloneableButton original)
			{
				Root = UnityEngine.Object.Instantiate(original.Root, original.Root.transform.parent);
				Button = Root.GetComponentInChildren<Button>(includeInactive: true);
				Text = Root.GetComponentInChildren<TMP_Text>(includeInactive: true);
			}
		}

		private const float RequestInterval = 1f;

		private static readonly Color SelectedColor = new Color(1f, 0.85f, 0.3f, 1f);

		[SerializeField]
		private List<CloneableButton> _groupButtons;

		[SerializeField]
		private List<CloneableButton> _actionButtons;

		[SerializeField]
		private GameObject[] _actionRoots;

		[SerializeField]
		private TMP_Text _exceptionText;

		[SerializeField]
		private string _noDummiesMessage;

		[SerializeField]
		private GameObject _exceptionRoot;

		private float _updateTimer;

		private string _selectedGroup;

		private RaDummyActions _raActions;

		private readonly List<string> _receiveGroups = new List<string>();

		private readonly List<string> _receiveActions = new List<string>();

		private readonly List<KeyValuePair<string, List<string>>> _tempGroups = new List<KeyValuePair<string, List<string>>>();

		private readonly Dictionary<string, List<string>> _mergedActions = new Dictionary<string, List<string>>();

		public void SelectGroup(Button button)
		{
			int num = IndexOf(_groupButtons, button);
			if (num >= 0 && num < _receiveGroups.Count)
			{
				_selectedGroup = _receiveGroups[num];
				RefreshInterface();
			}
		}

		public void SelectAction(Button button)
		{
			int num = IndexOf(_actionButtons, button);
			if (num < 0 || num >= _receiveActions.Count || string.IsNullOrEmpty(_selectedGroup))
			{
				return;
			}
			string selectedPlayers = GetSelectedPlayers(new StringBuilder());
			if (!string.IsNullOrEmpty(selectedPlayers))
			{
				RemoteAdminClient.SendQuery("dummy action " + selectedPlayers + " " + _selectedGroup.Replace(' ', '_') + " " + _receiveActions[num].Replace(' ', '_'));
				_updateTimer = 0f;
			}
		}

		protected override void OnUpdate()
		{
			if (!(Time.unscaledTime < _updateTimer))
			{
				_updateTimer = Time.unscaledTime + RequestInterval;
				ClientRequest();
			}
			RefreshInterface();
		}

		private void ClientRequest()
		{
			RemoteAdminClient.SendQuery("$9 0", logQuery: false);
		}

		private void RefreshInterface()
		{
			CollectSelectedDummyActions();
			if (_receiveGroups.Count == 0)
			{
				SetException(_noDummiesMessage);
				return;
			}
			SetException((_raActions != null) ? _raActions.LastError : null);
			if (_selectedGroup == null || !_mergedActions.ContainsKey(_selectedGroup))
			{
				_selectedGroup = _receiveGroups[0];
			}
			_receiveActions.Clear();
			_receiveActions.AddRange(_mergedActions[_selectedGroup]);
			UpdateButtons(_groupButtons, _receiveGroups, _selectedGroup);
			UpdateButtons(_actionButtons, _receiveActions, null);
		}

		private void CollectSelectedDummyActions()
		{
			_receiveGroups.Clear();
			_mergedActions.Clear();
			foreach (PlayerRecord instance in PlayerRecord.Instances)
			{
				if (instance == null || !instance.IsSelected || !int.TryParse(instance.PlayerId, out var result) || !ReferenceHub.TryGetHub(result, out var hub) || !RaDummyActions.TryGetReceivedActions(hub.netId, _tempGroups))
				{
					continue;
				}
				foreach (KeyValuePair<string, List<string>> tempGroup in _tempGroups)
				{
					if (!_mergedActions.TryGetValue(tempGroup.Key, out var value))
					{
						value = new List<string>();
						_mergedActions.Add(tempGroup.Key, value);
						_receiveGroups.Add(tempGroup.Key);
					}
					foreach (string item in tempGroup.Value)
					{
						if (!value.Contains(item))
						{
							value.Add(item);
						}
					}
				}
			}
		}

		private void SetException(string message)
		{
			bool flag = !string.IsNullOrEmpty(message);
			if (_exceptionRoot != null)
			{
				_exceptionRoot.SetActive(flag);
			}
			if (_exceptionText != null && flag)
			{
				_exceptionText.text = message.Replace("\\n", "\n");
			}
			bool flag2 = _receiveGroups.Count > 0;
			if (_actionRoots == null)
			{
				return;
			}
			GameObject[] actionRoots = _actionRoots;
			foreach (GameObject gameObject in actionRoots)
			{
				if (gameObject != null)
				{
					gameObject.SetActive(flag2);
				}
			}
		}

		private void UpdateButtons(List<CloneableButton> buttons, List<string> content, string selected)
		{
			if (buttons == null || buttons.Count == 0 || buttons[0].Root == null)
			{
				return;
			}
			while (buttons.Count < content.Count)
			{
				buttons.Add(new CloneableButton(buttons[0]));
			}
			for (int i = 0; i < buttons.Count; i++)
			{
				CloneableButton cloneableButton = buttons[i];
				bool flag = i < content.Count;
				if (cloneableButton.Root.activeSelf != flag)
				{
					cloneableButton.Root.SetActive(flag);
				}
				if (flag && cloneableButton.Text != null)
				{
					cloneableButton.Text.text = content[i];
					cloneableButton.Text.color = ((content[i] == selected) ? SelectedColor : Color.white);
				}
			}
		}

		private static int IndexOf(List<CloneableButton> buttons, Button button)
		{
			for (int i = 0; i < buttons.Count; i++)
			{
				if (buttons[i].Button == button)
				{
					return i;
				}
			}
			return -1;
		}

		private void Awake()
		{
			_raActions = CommunicationProcessor.RequestClientChannel<RaDummyActions>();
		}
	}
}
