namespace Discord
{
	public class DiscordManager : global::UnityEngine.MonoBehaviour
	{
		public const long ApplicationId = 420676877766623232L;

		public const string OptionalSteamId = "700330";

		private static bool _singletonSet;

		public static global::Discord.DiscordManager Singleton
		{
			[global::System.Runtime.CompilerServices.CompilerGenerated]
			get
			{
				return default;
			}
			[global::System.Runtime.CompilerServices.CompilerGenerated]
			private set
			{
			}
		}

		public global::Discord.Modules.RichPresenceModule RichPresence
		{
			[global::System.Runtime.CompilerServices.CompilerGenerated]
			get
			{
				return default;
			}
			[global::System.Runtime.CompilerServices.CompilerGenerated]
			private set
			{
			}
		}

		public global::Discord.Modules.RequestableJoinModule JoinModule
		{
			[global::System.Runtime.CompilerServices.CompilerGenerated]
			get
			{
				return default;
			}
			[global::System.Runtime.CompilerServices.CompilerGenerated]
			private set
			{
			}
		}

		public global::Discord.Modules.DebugModule DebugModule
		{
			[global::System.Runtime.CompilerServices.CompilerGenerated]
			get
			{
				return default;
			}
			[global::System.Runtime.CompilerServices.CompilerGenerated]
			private set
			{
			}
		}

		public CustomNetworkManager NetworkManager
		{
			[global::System.Runtime.CompilerServices.CompilerGenerated]
			get
			{
				return default;
			}
			[global::System.Runtime.CompilerServices.CompilerGenerated]
			set
			{
			}
		}

		private void OnEnable()
		{
		}

		private void OnDisable()
		{
		}

		private void Awake()
		{
		}

		private void OnDestroy()
		{
		}

		private void Update()
		{
		}

		private void SetEnabled(bool value)
		{
		}

		public DiscordManager()
		{
		}
	}
}
