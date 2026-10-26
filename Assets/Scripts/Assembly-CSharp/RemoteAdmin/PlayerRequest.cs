using System;
using System.Collections.Generic;
using PlayerRoles;
using TMPro;
using UnityEngine;

namespace RemoteAdmin
{
	public class PlayerRequest : MonoBehaviour
	{
		public Transform parent;

		public GameObject template;

		public TMP_InputField playerSearch;

		private readonly List<GameObject> _spawnedObjects = new List<GameObject>();

		private string _lastData;

		public static PlayerRequest Singleton { get; private set; }

		public bool IsInputFieldSelected { get; set; }

		private void Awake()
		{
			Singleton = this;
			if (playerSearch != null)
			{
				playerSearch.onValueChanged.AddListener(OnSearchChanged);
			}
		}

		private void OnDestroy()
		{
			if (Singleton == this)
			{
				Singleton = null;
			}
		}

		private void Update()
		{
			RemoteAdminUIController singleton = RemoteAdminUIController.Singleton;
			if (!(singleton == null) && singleton.IsEnabled && !IsInputFieldSelected && singleton.CanToggle && (Input.GetKey(KeyCode.LeftControl) || Input.GetKey(KeyCode.RightControl)) && Input.GetKeyDown(KeyCode.A))
			{
				foreach (PlayerRecord instance in PlayerRecord.Instances)
				{
					if (instance != null)
					{
						instance.SetState(selected: true, allowMultipleSelection: true, changeLastSelected: false);
					}
				}
			}
		}

		private void OnSearchChanged(string value)
		{
			if (_lastData != null)
			{
				ResponsePlayerList(_lastData);
			}
		}

		public void ResponsePlayerList(string data)
		{
			_lastData = data;
			HashSet<string> hashSet = new HashSet<string>();
			foreach (PlayerRecord instance in PlayerRecord.Instances)
			{
				if (instance != null && instance.IsSelected)
				{
					hashSet.Add(instance.PlayerId);
				}
			}
			PlayerRecord.Instances.Clear();
			foreach (GameObject spawnedObject in _spawnedObjects)
			{
				if (spawnedObject != null)
				{
					UnityEngine.Object.Destroy(spawnedObject);
				}
			}
			_spawnedObjects.Clear();
			if (template == null || parent == null || string.IsNullOrEmpty(data))
			{
				return;
			}
			string text = ((playerSearch != null) ? playerSearch.text : null);
			string[] array = data.Split('\n');
			foreach (string text2 in array)
			{
				if (string.IsNullOrWhiteSpace(text2) || (!string.IsNullOrEmpty(text) && text2.IndexOf(text, StringComparison.OrdinalIgnoreCase) < 0))
				{
					continue;
				}
				int num = text2.IndexOf('(');
				int num2 = text2.IndexOf(')', Math.Max(num, 0));
				if (num < 0 || num2 <= num)
				{
					continue;
				}
				string text3 = text2.Substring(num + 1, num2 - num - 1);
				GameObject gameObject = UnityEngine.Object.Instantiate(template, parent);
				gameObject.transform.localScale = Vector3.one;
				gameObject.SetActive(value: true);
				_spawnedObjects.Add(gameObject);
				PlayerRecord componentInChildren = gameObject.GetComponentInChildren<PlayerRecord>(includeInactive: true);
				if (!(componentInChildren == null))
				{
					componentInChildren.PlayerId = text3;
					componentInChildren.SetText(text2.Replace("{RA_ClassColor}", GetClassColor(text3)));
					componentInChildren.Register();
					if (hashSet.Contains(text3))
					{
						componentInChildren.SetState(selected: true, allowMultipleSelection: true, changeLastSelected: false);
					}
				}
			}
			if (hashSet.Count == 0)
			{
				PlayerRecord.LastSelectedId = null;
			}
		}

		private static string GetClassColor(string playerId)
		{
			ReferenceHub hub = null;
			if (int.TryParse(playerId, out var result))
			{
				foreach (ReferenceHub allHub in ReferenceHub.AllHubs)
				{
					if (allHub.PlayerId == result)
					{
						hub = allHub;
						break;
					}
				}
			}
			if (hub == null)
			{
				return "#FFFFFF";
			}
			PlayerRoleBase currentRole = hub.roleManager.CurrentRole;
			if (currentRole == null || currentRole.RoleTypeId == RoleTypeId.Spectator)
			{
				return "#737373";
			}
			return "#" + ColorUtility.ToHtmlStringRGB(currentRole.RoleColor);
		}
	}
}
