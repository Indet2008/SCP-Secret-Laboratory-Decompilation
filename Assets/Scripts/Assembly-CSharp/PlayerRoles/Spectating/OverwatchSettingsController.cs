using System;
using System.Collections.Generic;
using System.Linq;
using DrawableLine;
using Mirror;
using UnityEngine;
using VoiceChat;

namespace PlayerRoles.Spectating
{
	public class OverwatchSettingsController : MonoBehaviour
	{
		public struct OverwatchSettingsInfoMessage : NetworkMessage
		{
			public bool SpatialAudio;

			public uint EnabledChannels;

			public bool EnablePlayerInfo;

			public bool EnableHitregLog;

			public OverwatchSettingsInfoMessage(bool spatialAudio, uint enabledChannels, bool enablePlayerInfo, bool enableHitregLog)
			{
				SpatialAudio = spatialAudio;
				EnabledChannels = enabledChannels;
				EnablePlayerInfo = enablePlayerInfo;
				EnableHitregLog = enableHitregLog;
			}
		}

		private const string PlayerInfoString = "OverwatchPlayerInfoEnabled";

		private const string HitRegString = "OverwatchHitregLog";

		public static readonly CachedValue<VoiceChatChannel[]> AllChannels = new CachedValue<VoiceChatChannel[]>(() => Enum.GetValues(typeof(VoiceChatChannel)) as VoiceChatChannel[]);

		private static readonly HashSet<VoiceChatChannel> ActiveMutes = new HashSet<VoiceChatChannel>();

		[SerializeField]
		private OverwatchVoiceChatButton[] _buttons;

		[SerializeField]
		private OverwatchVoiceChatButton _spatialButton;

		[SerializeField]
		private OverwatchSettingToggleButton _playerInfoButton;

		[SerializeField]
		private OverwatchSettingToggleButton _hitRegButton;

		[SerializeField]
		private OverwatchSettingToggleButton _debugLinesButton;

		private bool _spatialAudioEnabled;

		public static bool PlayerInfoEnabled
		{
			get
			{
				return PlayerPrefsSl.Get("OverwatchPlayerInfoEnabled", defaultValue: true);
			}
			set
			{
				PlayerPrefsSl.Set("OverwatchPlayerInfoEnabled", value);
			}
		}

		public static bool HitregInfoLogEnabled
		{
			get
			{
				return PlayerPrefsSl.Get("OverwatchHitregLog", defaultValue: false);
			}
			set
			{
				PlayerPrefsSl.Set("OverwatchHitregLog", value);
			}
		}

		public static bool DebugLinesEnabled
		{
			get
			{
				return DrawableLines.IsDebugModeEnabled;
			}
			set
			{
				DrawableLines.IsDebugModeEnabled = value;
			}
		}

		public void OnToggled()
		{
			ActiveMutes.Clear();
			OverwatchVoiceChatButton[] buttons = _buttons;
			foreach (OverwatchVoiceChatButton overwatchVoiceChatButton in buttons)
			{
				if (!overwatchVoiceChatButton.IsToggled)
				{
					ActiveMutes.Add(overwatchVoiceChatButton.VoiceChatChannel);
				}
			}
			_spatialAudioEnabled = _spatialButton.IsToggled;
			PlayerInfoEnabled = _playerInfoButton.IsToggled;
			HitregInfoLogEnabled = _hitRegButton.IsToggled;
			DebugLinesEnabled = _debugLinesButton.IsToggled;
			ClientSendMessage(SerializeChannels(), _spatialAudioEnabled, PlayerInfoEnabled, HitregInfoLogEnabled);
			OverwatchUIController.Instance.SetPlayerInfoVisibility(PlayerInfoEnabled);
			OverwatchUIController.Instance.SetHitregInfoVisibility(HitregInfoLogEnabled);
		}

		private void Start()
		{
			ActiveMutes.Clear();
			ActiveMutes.Add(VoiceChatChannel.ScpChat);
			_spatialAudioEnabled = true;
		}

		private void OnEnable()
		{
			OverwatchVoiceChatButton[] buttons = _buttons;
			foreach (OverwatchVoiceChatButton overwatchVoiceChatButton in buttons)
			{
				overwatchVoiceChatButton.IsToggled = !ActiveMutes.Contains(overwatchVoiceChatButton.VoiceChatChannel);
			}
			_spatialButton.IsToggled = _spatialAudioEnabled;
			_playerInfoButton.IsToggled = PlayerInfoEnabled;
			_hitRegButton.IsToggled = HitregInfoLogEnabled;
			_debugLinesButton.IsToggled = DebugLinesEnabled;
			ClientSendMessage(SerializeChannels(), _spatialAudioEnabled, PlayerInfoEnabled, HitregInfoLogEnabled);
		}

		private static uint SerializeChannels()
		{
			uint num = 0u;
			foreach (VoiceChatChannel activeMute in ActiveMutes)
			{
				uint num2 = 1u;
				for (int i = 0; i < (int)activeMute; i++)
				{
					num2 *= 2;
				}
				num += num2;
			}
			return num;
		}

		private static void DeserializeChannels(uint channels)
		{
			ActiveMutes.Clear();
			VoiceChatChannel[] value = AllChannels.Value;
			foreach (VoiceChatChannel voiceChatChannel in value)
			{
				uint num = 1u;
				for (int j = 0; j < (int)voiceChatChannel; j++)
				{
					num *= 2;
				}
				if ((channels & num) != 0)
				{
					ActiveMutes.Add(voiceChatChannel);
				}
			}
		}

		private static void ClientSendMessage(uint channels, bool spatialAudio, bool playerInfo, bool hitregEnabled)
		{
			NetworkClient.Send(new OverwatchSettingsInfoMessage(spatialAudio, channels, playerInfo, hitregEnabled));
		}

		[RuntimeInitializeOnLoadMethod]
		private static void Init()
		{
			CustomNetworkManager.OnClientReady += () =>
			{
				NetworkServer.ReplaceHandler<OverwatchSettingsInfoMessage>(ProcessMessage);
			};
		}

		private static void ProcessMessage(NetworkConnection conn, OverwatchSettingsInfoMessage msg)
		{
			if (!(conn.identity == null) && ReferenceHub.TryGetHubNetID(conn.identity.netId, out var hub) && hub.roleManager.CurrentRole is OverwatchRole { VoiceModule: OverwatchVoiceModule voiceModule } overwatchRole)
			{
				DeserializeChannels(msg.EnabledChannels);
				voiceModule.DisabledChannels = ActiveMutes.ToArray();
				voiceModule.UseSpatialAudio = msg.SpatialAudio;
				overwatchRole.ServerPlayerInfoEnabled = msg.EnablePlayerInfo;
				overwatchRole.ServerHitRegEnabled = msg.EnableHitregLog;
			}
		}
	}
}
