using Discord.Modules;
using UnityEngine;
using UserSettings;
using UserSettings.OtherSettings;

namespace Discord
{
	public class DiscordManager : MonoBehaviour
	{
		public const long ApplicationId = 420676877766623232L;

		public const string OptionalSteamId = "700330";

		private static bool _singletonSet;

		public static DiscordManager Singleton { get; private set; }

		[field: SerializeField]
		public RichPresenceModule RichPresence { get; private set; }

		[field: SerializeField]
		public RequestableJoinModule JoinModule { get; private set; }

		[field: SerializeField]
		public DebugModule DebugModule { get; private set; }

		[field: SerializeField]
		public CustomNetworkManager NetworkManager { get; set; }

		private void OnEnable()
		{
			CallbackController.Initialize(420676877766623232L.ToString(), autoRegister: true, "700330");
		}

		private void OnDisable()
		{
			CallbackController.Shutdown();
		}

		private void Awake()
		{
			if (!_singletonSet)
			{
				_singletonSet = true;
				Singleton = this;
			}
			bool flag = UserSetting<bool>.Get(MiscPrivacySetting.RichPresence);
			RichPresence.IsEnabled = flag;
			DebugModule.IsEnabled = flag;
			JoinModule.IsEnabled = flag;
			UserSetting<bool>.AddListener(MiscPrivacySetting.RichPresence, SetEnabled);
		}

		private void OnDestroy()
		{
			UserSetting<bool>.RemoveListener(MiscPrivacySetting.RichPresence, SetEnabled);
		}

		private void Update()
		{
			CallbackController.RunCallbacks();
		}

		private void SetEnabled(bool value)
		{
			RichPresence.IsEnabled = value;
			DebugModule.IsEnabled = value;
			JoinModule.IsEnabled = value;
		}
	}
}
