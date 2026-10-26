using System;
using System.Collections.Generic;
using InventorySystem;
using Mirror;
using ToggleableMenus;
using UnityEngine;
using UnityEngine.UI;

namespace VoiceChat
{
	public class VoiceChatPrivacySettings : ToggleableMenuBase
	{
		[Serializable]
		private class ToggleGroup
		{
			[field: SerializeField]
			public Toggle AcceptToggle { get; private set; }

			[field: SerializeField]
			public Toggle DenyToggle { get; private set; }

			[field: SerializeField]
			public VcPrivacyFlags Flags { get; private set; }

			public bool IsAccepted
			{
				get
				{
					return AcceptToggle.isOn;
				}
				set
				{
					AcceptToggle.SetIsOnWithoutNotify(value);
					DenyToggle.SetIsOnWithoutNotify(!value);
				}
			}
		}

		public struct VcPrivacyMessage : NetworkMessage
		{
			public byte Flags;
		}

		[SerializeField]
		private GameObject _simplifiedRoot;

		[SerializeField]
		private GameObject _advancedRoot;

		[SerializeField]
		private Canvas _hideHudCanvas;

		[SerializeField]
		private Image _recordDim;

		[SerializeField]
		private Image _dimmerBackground;

		[SerializeField]
		private GameObject _returnButton;

		[SerializeField]
		private ToggleGroup[] _groups;

		private readonly Dictionary<VcPrivacyFlags, ToggleGroup> _groupsByFlags = new Dictionary<VcPrivacyFlags, ToggleGroup>();

		private static readonly Dictionary<ReferenceHub, VcPrivacyFlags> FlagsOfPlayers = new Dictionary<ReferenceHub, VcPrivacyFlags>();

		private const string PrefsKey = "VcPrivacyFlags_1.1";

		private bool _forceOpen;

		private static VcPrivacyFlags _loadedFlags;

		private static bool _flagsLoaded;

		public static VoiceChatPrivacySettings Singleton { get; private set; }

		public override bool IsEnabled
		{
			get
			{
				return base.IsEnabled;
			}
			set
			{
				base.IsEnabled = value || _forceOpen;
			}
		}

		public override bool CanToggle => false;

		private static VcPrivacyFlags PrefsFlags
		{
			get
			{
				return (VcPrivacyFlags)PlayerPrefs.GetInt("VcPrivacyFlags_1.1", 0);
			}
			set
			{
				PlayerPrefs.SetInt("VcPrivacyFlags_1.1", (int)value);
			}
		}

		public static VcPrivacyFlags PrivacyFlags
		{
			get
			{
				if (_flagsLoaded)
				{
					return _loadedFlags;
				}
				_loadedFlags = PrefsFlags;
				_flagsLoaded = true;
				return _loadedFlags;
			}
			set
			{
				if (_loadedFlags != value)
				{
					_loadedFlags = value;
					PrefsFlags = value;
				}
			}
		}

		public static event Action<ReferenceHub> OnUserFlagsChanged;

		protected override void Awake()
		{
			base.Awake();
			ToggleGroup[] groups = _groups;
			foreach (ToggleGroup toggleGroup in groups)
			{
				_groupsByFlags.Add(toggleGroup.Flags, toggleGroup);
			}
			Singleton = this;
			UpdateToggles();
		}

		protected override void OnToggled()
		{
		}

		public void UpdateToggles()
		{
			ToggleGroup[] groups = _groups;
			foreach (ToggleGroup toggleGroup in groups)
			{
				toggleGroup.IsAccepted = (PrivacyFlags & toggleGroup.Flags) == toggleGroup.Flags;
			}
			_recordDim.enabled = (PrivacyFlags & VcPrivacyFlags.AllowRecording) == 0;
		}

		public void HandleToggle(Toggle checkbox)
		{
			ToggleGroup[] groups = _groups;
			foreach (ToggleGroup toggleGroup in groups)
			{
				if (toggleGroup.AcceptToggle == checkbox)
				{
					toggleGroup.IsAccepted = true;
					break;
				}
				if (toggleGroup.DenyToggle == checkbox)
				{
					toggleGroup.IsAccepted = false;
					break;
				}
			}
			if (_groupsByFlags[VcPrivacyFlags.AllowMicCapture].IsAccepted)
			{
				_recordDim.enabled = false;
			}
			else
			{
				_recordDim.enabled = true;
				_groupsByFlags[VcPrivacyFlags.AllowRecording].IsAccepted = false;
			}
			VcPrivacyFlags vcPrivacyFlags = PrivacyFlags & VcPrivacyFlags.SettingsSelected;
			groups = _groups;
			foreach (ToggleGroup toggleGroup2 in groups)
			{
				if (toggleGroup2.IsAccepted)
				{
					vcPrivacyFlags |= toggleGroup2.Flags;
				}
			}
			PrivacyFlags = vcPrivacyFlags;
			if (NetworkClient.ready && ReferenceHub.TryGetLocalHub(out var hub))
			{
				NetworkClient.Send(new VcPrivacyMessage
				{
					Flags = (byte)PrivacyFlags
				});
				OnUserFlagsChanged?.Invoke(hub);
			}
		}

		[RuntimeInitializeOnLoadMethod]
		private static void Init()
		{
			Inventory.OnServerStarted += () =>
			{
				NetworkServer.ReplaceHandler((NetworkConnectionToClient conn, VcPrivacyMessage msg) =>
				{
					if (ReferenceHub.TryGetHub(conn, out var hub))
					{
						FlagsOfPlayers[hub] = (VcPrivacyFlags)msg.Flags;
						OnUserFlagsChanged?.Invoke(hub);
					}
				});
			};
			ReferenceHub.OnPlayerAdded += (ReferenceHub hub) =>
			{
				if (hub.isLocalPlayer && !NetworkServer.active)
				{
					NetworkClient.Send(new VcPrivacyMessage
					{
						Flags = (byte)PrivacyFlags
					});
				}
			};
			ReferenceHub.OnPlayerRemoved += (ReferenceHub hub) =>
			{
				FlagsOfPlayers.Remove(hub);
			};
		}

		public static bool CheckUserFlags(ReferenceHub user, VcPrivacyFlags flags)
		{
			if (FlagsOfPlayers.TryGetValue(user, out var value))
			{
				return (value & flags) == flags;
			}
			return false;
		}
	}
}
