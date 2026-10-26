using System;
using System.Collections.Generic;
using Mirror;
using UnityEngine;
using UnityEngine.UI;
using UserSettings.GUIElements;

namespace UserSettings.ServerSpecific.Entries
{
	public class SSEntrySpawner : MonoBehaviour
	{
		private static SSEntrySpawner _singleton;

		private static int? _clientVersionCache;

		[SerializeField]
		private GameObject[] _entryTemplates;

		[SerializeField]
		private Transform _entriesParentTr;

		[SerializeField]
		private UserSettingsCategories _categoriesController;

		[SerializeField]
		private GameObject _categoryButton;

		[SerializeField]
		private GameObject _categoryRoot;

		[SerializeField]
		private GameObject _spacer;

		[SerializeField]
		private GameObject[] _newSettingsWarning;

		private ISSEntry[] _cachedComponents;

		private readonly List<GameObject> _spawnedEntries = new List<GameObject>();

		private readonly List<VerticalLayoutGroup> _layoutGroups = new List<VerticalLayoutGroup>();

		private static string PrefsKey => "SrvSp_" + ServerSpecificSettingsSync.CurServerPrefsKey + "_Version";

		private static int ClientVersion
		{
			get
			{
				int valueOrDefault = _clientVersionCache.GetValueOrDefault();
				if (!_clientVersionCache.HasValue)
				{
					valueOrDefault = PlayerPrefs.GetInt(PrefsKey, 0);
					_clientVersionCache = valueOrDefault;
				}
				return _clientVersionCache.Value;
			}
			set
			{
				if (_clientVersionCache != value)
				{
					_clientVersionCache = value;
					PlayerPrefs.SetInt(PrefsKey, value);
				}
			}
		}

		private void Awake()
		{
			_singleton = this;
			_clientVersionCache = null;
			SSTabDetector.OnStatusChanged += OnTabChanged;
		}

		private void Update()
		{
			if (!SSTabDetector.IsOpen)
			{
				return;
			}
			foreach (VerticalLayoutGroup layoutGroup in _layoutGroups)
			{
				layoutGroup.enabled = false;
				layoutGroup.enabled = true;
			}
		}

		private void OnDestroy()
		{
			SSTabDetector.OnStatusChanged -= OnTabChanged;
		}

		private void OnTabChanged()
		{
			if (SSTabDetector.IsOpen)
			{
				ToggleWarning(state: false);
				ClientVersion = ServerSpecificSettingsSync.Version;
			}
			ClientSendReport();
		}

		private void ToggleWarning(bool state)
		{
			GameObject[] newSettingsWarning = _newSettingsWarning;
			for (int i = 0; i < newSettingsWarning.Length; i++)
			{
				newSettingsWarning[i].SetActive(state);
			}
		}

		private void DeleteSpawnedEntries()
		{
			ToggleWarning(state: false);
			foreach (GameObject spawnedEntry in _spawnedEntries)
			{
				if (!(spawnedEntry == null))
				{
					UnityEngine.Object.Destroy(spawnedEntry);
				}
			}
			_spawnedEntries.Clear();
		}

		private void SpawnAllEntries(ServerSpecificSettingBase[] settings, bool showWarning)
		{
			_spacer.SetActive(!(settings[0] is SSGroupHeader));
			settings.ForEach(SpawnEntry);
			_categoryButton.SetActive(value: true);
			_layoutGroups.Clear();
			_categoryRoot.GetComponentsInChildren(_layoutGroups);
			ToggleWarning(showWarning);
		}

		private void SpawnEntry(ServerSpecificSettingBase setting)
		{
			GameObject gameObject = UnityEngine.Object.Instantiate(GetTemplateForSetting(setting), _entriesParentTr);
			gameObject.SetActive(value: true);
			gameObject.GetComponentInChildren<ISSEntry>().Init(setting);
			_spawnedEntries.Add(gameObject);
		}

		private GameObject GetTemplateForSetting(ServerSpecificSettingBase setting)
		{
			int num = _entryTemplates.Length;
			if (_cachedComponents == null)
			{
				_cachedComponents = new ISSEntry[num];
			}
			for (int i = 0; i < num; i++)
			{
				ISSEntry iSSEntry = _cachedComponents[i];
				if (iSSEntry == null)
				{
					iSSEntry = FindEntryInTemplate(_entryTemplates[i]);
					_cachedComponents[i] = iSSEntry;
				}
				if (iSSEntry.CheckCompatibility(setting))
				{
					return _entryTemplates[i];
				}
			}
			throw new InvalidOperationException("This setting does not have a compatible entry: " + setting);
		}

		private ISSEntry FindEntryInTemplate(GameObject template)
		{
			ISSEntry componentInChildren = template.GetComponentInChildren<ISSEntry>(includeInactive: true);
			if (componentInChildren as UnityEngine.Object == null)
			{
				throw new InvalidOperationException("This entry template is not valid: " + template.name);
			}
			return componentInChildren;
		}

		private static void ClientSendReport()
		{
			NetworkClient.Send(new SSSUserStatusReport(ClientVersion, SSTabDetector.IsOpen));
		}

		public static void Refresh()
		{
			if (!(_singleton == null))
			{
				_singleton.DeleteSpawnedEntries();
				ServerSpecificSettingBase[] definedSettings = ServerSpecificSettingsSync.DefinedSettings;
				if (definedSettings == null || definedSettings.Length == 0)
				{
					_singleton._categoriesController.ResetSelection();
					_singleton._categoryButton.SetActive(value: false);
					return;
				}
				int clientVersion = ClientVersion;
				int version = ServerSpecificSettingsSync.Version;
				_singleton.SpawnAllEntries(definedSettings, version != 0 && clientVersion != version);
				ClientSendReport();
			}
		}
	}
}
