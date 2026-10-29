namespace LabApi.Features.Wrappers
{
	[global::System.Obsolete("Use Announcer instead of Cassie.", true)]
	public static class Cassie
	{
		[global::System.Obsolete("Use Announcer.IsSpeaking instead.", true)]
		public static bool IsSpeaking => global::LabApi.Features.Wrappers.Announcer.IsSpeaking;

		[global::System.Obsolete("Use Announcer.LineDatabase instead.", true)]
		public static global::Cassie.CassieLineDatabase? LineDatabase => global::LabApi.Features.Wrappers.Announcer.LineDatabase;

		[global::System.Obsolete("Use Announcer.AllLines instead.", true)]
		public static global::Cassie.CassieLine[] AllLines => global::LabApi.Features.Wrappers.Announcer.AllLines;

		[global::System.Obsolete("Use Announcer.CollectionNames instead.", true)]
		public static string[] CollectionNames => global::LabApi.Features.Wrappers.Announcer.CollectionNames;

		[global::System.Obsolete("Use Announcer.IsValid(string) instead.", true)]
		public static bool IsValid(string word)
		{
			return global::LabApi.Features.Wrappers.Announcer.IsValid(word);
		}

		[global::System.Obsolete("Use Announcer.CalculateDuration(string message, CassiePlaybackModifiers playbackModifiers) instead.", true)]
		public static float CalculateDuration(string message, bool rawNumber = false, float speed = 1f)
		{
			return global::LabApi.Features.Wrappers.Announcer.CalculateDuration(message, rawNumber, speed);
		}

		[global::System.Obsolete("Use Announcer.CalculateDuration(string, CassiePlaybackModifiers) instead.", true)]
		public static double CalculateDuration(string message, global::Cassie.CassiePlaybackModifiers playbackModifiers)
		{
			return global::LabApi.Features.Wrappers.Announcer.CalculateDuration(message, playbackModifiers);
		}

		[global::System.Obsolete("Use Announcer.Message(string message, string customSubtitles = \"\", bool playBackground = true, float priority = 0f, float glitchScale = 1f) instead.", true)]
		public static void Message(string message, bool isHeld = false, bool isNoisy = true, bool isSubtitles = true, string customSubtitles = "")
		{
			global::LabApi.Features.Wrappers.Announcer.Message(message, customSubtitles);
		}

		[global::System.Obsolete("Use Announcer.Message(string, string, bool, float, float) instead.", true)]
		public static void Message(string message, string customSubtitles = "", bool playBackground = true, float priority = 0f, float glitchScale = 1f)
		{
			global::LabApi.Features.Wrappers.Announcer.Message(message, customSubtitles, playBackground, priority, glitchScale);
		}

		[global::System.Obsolete("Use Announcer.Message(CassieTtsPayload, float, float) instead.", true)]
		public static void Message(global::Cassie.CassieTtsPayload payload, float priority = 0f, float glitchScale = 1f)
		{
			global::LabApi.Features.Wrappers.Announcer.Message(payload, priority, glitchScale);
		}

		[global::System.Obsolete("Use Announcer.GlitchyMessage(string, float, float) instead.", true)]
		public static void GlitchyMessage(string message, float glitchChance, float jamChance)
		{
			global::LabApi.Features.Wrappers.Announcer.GlitchyMessage(message, glitchChance, jamChance);
		}

		[global::System.Obsolete("Use Announcer.ScpTermination(Player, DamageHandlerBase) instead.", true)]
		public static void ScpTermination(global::LabApi.Features.Wrappers.Player player, global::PlayerStatsSystem.DamageHandlerBase info)
		{
			global::LabApi.Features.Wrappers.Announcer.ScpTermination(player, info);
		}

		[global::System.Obsolete("Use Announcer.Clear() instead.", true)]
		public static void Clear()
		{
			global::LabApi.Features.Wrappers.Announcer.Clear();
		}

		[global::System.Obsolete("Use Announcer.ConvertTeam(Team, string) instead.", true)]
		public static string ConvertTeam(global::PlayerRoles.Team team, string unitName)
		{
			return global::LabApi.Features.Wrappers.Announcer.ConvertTeam(team, unitName);
		}

		[global::System.Obsolete("Use Announcer.ConvertNumber(int) instead.", true)]
		public static string ConvertNumber(int num)
		{
			return global::LabApi.Features.Wrappers.Announcer.ConvertNumber(num);
		}

		[global::System.Obsolete("Use Announcer.ConvertScp(RoleTypeId, out string, out string) instead.", true)]
		public static void ConvertScp(global::PlayerRoles.RoleTypeId role, out string withoutSpace, out string withSpace)
		{
			global::LabApi.Features.Wrappers.Announcer.ConvertScp(role, out withoutSpace, out withSpace);
		}

		[global::System.Obsolete("Use Announcer.ConvertScp(string, out string, out string) instead.", true)]
		public static void ConvertScp(string roleName, out string withoutSpace, out string withSpace)
		{
			global::LabApi.Features.Wrappers.Announcer.ConvertScp(roleName, out withoutSpace, out withSpace);
		}

		[global::System.Obsolete("Use Announcer.CalculateDuration(ReadOnlySpan{char}, CassiePlaybackModifiers, out double) instead.", true)]
		public static void CalculateDuration(global::System.ReadOnlySpan<char> remaining, global::Cassie.CassiePlaybackModifiers modifiers, out double time)
		{
			global::LabApi.Features.Wrappers.Announcer.CalculateDuration(remaining, modifiers, out time);
		}
	}
}
