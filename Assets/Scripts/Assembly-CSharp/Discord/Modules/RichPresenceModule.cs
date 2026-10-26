namespace Discord.Modules
{
	public class RichPresenceModule : global::Discord.Modules.DiscordModuleBase
	{
		public static readonly global::System.Collections.Generic.Dictionary<global::Discord.DiscordGameStatus, global::Discord.Elements.DiscordGameStateElement> GameState;

		public static readonly global::System.Collections.Generic.Dictionary<global::PlayerRoles.RoleTypeId, global::Discord.Elements.DiscordRoleElement> PlayableRoles;

		public static readonly global::System.Collections.Generic.Dictionary<global::PlayerRoles.Team, global::Discord.Elements.DiscordTeamElement> PlayableTeams;

		private static bool _dictionariesPopulated;

		[global::UnityEngine.SerializeField]
		private global::Discord.Elements.DiscordElementBase[] _elements;

		private global::Discord.Elements.DiscordElementBase _elementBase;

		private long _timeSinceJoin;

		public override bool IsEnabled
		{
			get
			{
				return default;
			}
			set
			{
			}
		}

		private string ServerAddress
		{
			get
			{
				return default;
			}
		}

		public void RefreshPresence()
		{
		}

		public void SetStatus(global::Discord.DiscordGameStatus status, bool updatePresence = true)
		{
		}

		public void SetStatus(global::PlayerRoles.RoleTypeId roleTypeId, bool refreshPresence = true)
		{
		}

		public void SetStatus(global::PlayerRoles.Team team, bool updatePresence = true)
		{
		}

		public void ResetTimer(bool updatePresence = true)
		{
		}

		protected override void OnDestroy()
		{
		}

		private void Start()
		{
		}

		private void Awake()
		{
		}

		private void ClearPresence()
		{
		}

		private long GenerateUnixTime()
		{
			return default;
		}

		private void OnPlayerAdded(ReferenceHub _)
		{
		}

		private void OnRoleChanged(ReferenceHub userHub, global::PlayerRoles.PlayerRoleBase prevRole, global::PlayerRoles.PlayerRoleBase newRole)
		{
		}

		private void OnLevelFinishedLoading(global::UnityEngine.SceneManagement.Scene scene, global::UnityEngine.SceneManagement.LoadSceneMode _)
		{
		}

		private void PopulateDictionaries()
		{
		}

		public RichPresenceModule()
		{
		}
	}
}
