namespace LabApi.Features.Wrappers
{
	public static class Announcer
	{
		public static bool IsSpeaking => global::Cassie.CassieAnnouncementDispatcher.CurrentAnnouncement != null;

		public static global::Cassie.CassieLineDatabase? LineDatabase
		{
			get
			{
				if (global::Cassie.CassieTtsAnnouncer.TryGetDatabase(out var db))
				{
					return db;
				}
				return null;
			}
		}

		public static global::Cassie.CassieLine[] AllLines
		{
			get
			{
				if (!LineDatabase)
				{
					return global::System.Array.Empty<global::Cassie.CassieLine>();
				}
				return LineDatabase.AllLines;
			}
		}

		public static string[] CollectionNames => global::System.Linq.Enumerable.ToArray(global::System.Linq.Enumerable.Distinct(global::System.Linq.Enumerable.Select(AllLines, (global::Cassie.CassieLine line) => line.ApiName)));

		public static bool IsValid(string word)
		{
			return global::System.Linq.Enumerable.Any(CollectionNames, (string line) => line.Equals(word, global::System.StringComparison.InvariantCultureIgnoreCase));
		}

		[global::System.Obsolete("Use CalculateDuration(string message, CassiePlaybackModifiers playbackModifiers) instead.", true)]
		public static float CalculateDuration(string message, bool rawNumber = false, float speed = 1f)
		{
			global::Cassie.CassiePlaybackModifiers playbackModifiers = new global::Cassie.CassiePlaybackModifiers
			{
				Pitch = speed
			};
			return (float)CalculateDuration(message, playbackModifiers);
		}

		public static double CalculateDuration(string message, global::Cassie.CassiePlaybackModifiers playbackModifiers)
		{
			CalculateDuration(message, playbackModifiers, out var time);
			return time;
		}

		[global::System.Obsolete("Use Message(string message, string customSubtitles = \"\", bool playBackground = true, float priority = 0f, float glitchScale = 1f) instead.", true)]
		public static void Message(string message, bool isHeld = false, bool isNoisy = true, bool isSubtitles = true, string customSubtitles = "")
		{
			Message(message, customSubtitles);
		}

		public static void Message(string message, string customSubtitles = "", bool playBackground = true, float priority = 0f, float glitchScale = 1f)
		{
			Message(new global::Cassie.CassieTtsPayload(message, customSubtitles, playBackground), priority, glitchScale);
		}

		public static void Message(global::Cassie.CassieTtsPayload payload, float priority = 0f, float glitchScale = 1f)
		{
			global::Cassie.CassieAnnouncementDispatcher.AddToQueue(new global::Cassie.CassieAnnouncement(payload, priority, glitchScale));
		}

		public static void GlitchyMessage(string message, float glitchChance, float jamChance)
		{
			message = global::Cassie.CassieGlitchifier.Glitchify(message, glitchChance, jamChance);
			Message(message, string.Empty, playBackground: true, 0f, 0f);
		}

		public static void ScpTermination(global::LabApi.Features.Wrappers.Player player, global::PlayerStatsSystem.DamageHandlerBase info)
		{
			global::Cassie.CassieScpTerminationAnnouncement.AnnounceScpTermination(player.ReferenceHub, info);
		}

		public static void Clear()
		{
			global::Cassie.CassieAnnouncementDispatcher.ClearAll();
		}

		public static string ConvertTeam(global::PlayerRoles.Team team, string unitName)
		{
			string result = "CONTAINMENTUNIT UNKNOWN";
			switch (team)
			{
			case global::PlayerRoles.Team.FoundationForces:
			{
				if (!global::Respawning.NamingRules.NamingRulesManager.TryGetNamingRule(team, out var rule))
				{
					return result;
				}
				string text = rule.TranslateToCassie(unitName);
				return "CONTAINMENTUNIT " + text;
			}
			case global::PlayerRoles.Team.ChaosInsurgency:
				return "CHAOSINSURGENCY";
			case global::PlayerRoles.Team.Scientists:
				return "SCIENCE PERSONNEL";
			case global::PlayerRoles.Team.ClassD:
				return "CLASSD PERSONNEL";
			default:
				return result;
			}
		}

		public static string ConvertNumber(int num)
		{
			if (LineDatabase == null)
			{
				return string.Empty;
			}
			global::Cassie.NumberInterpreter numberInterpreter = (global::Cassie.NumberInterpreter)global::System.Linq.Enumerable.FirstOrDefault(global::Cassie.CassieTtsAnnouncer.Interpreters, (global::Cassie.Interpreters.CassieInterpreter x) => x is global::Cassie.NumberInterpreter);
			if (numberInterpreter == null)
			{
				return string.Empty;
			}
			string text = num.ToString();
			global::Cassie.CassiePlaybackModifiers modifiers = default;
			global::System.Text.StringBuilder stringBuilder = global::NorthwoodLib.Pools.StringBuilderPool.Shared.Rent();
			numberInterpreter.GetResults(LineDatabase, ref modifiers, text, stringBuilder, out var _);
			return global::NorthwoodLib.Pools.StringBuilderPool.Shared.ToStringReturn(stringBuilder);
		}

		public static void ConvertScp(global::PlayerRoles.RoleTypeId role, out string withoutSpace, out string withSpace)
		{
			global::Cassie.CassieScpTerminationAnnouncement.ConvertSCP(role, out withoutSpace, out withSpace);
		}

		public static void ConvertScp(string roleName, out string withoutSpace, out string withSpace)
		{
			global::Cassie.CassieScpTerminationAnnouncement.ConvertSCP(roleName, out withoutSpace, out withSpace);
		}

		public static void CalculateDuration(string remaining, global::Cassie.CassiePlaybackModifiers modifiers, out double time)
		{
			CalculateDuration(global::System.MemoryExtensions.AsSpan(remaining), modifiers, out time);
		}

		public static void CalculateDuration(global::System.ReadOnlySpan<char> remaining, global::Cassie.CassiePlaybackModifiers modifiers, out double time)
		{
			time = 0.0;
			if (LineDatabase == null)
			{
				return;
			}
			int num = global::System.MemoryExtensions.IndexOf(remaining, ' ');
			global::System.Text.StringBuilder stringBuilder = global::NorthwoodLib.Pools.StringBuilderPool.Shared.Rent();
			global::System.ReadOnlySpan<char> word = ((num < 0) ? remaining : remaining.Slice(0, num));
			global::Cassie.Interpreters.CassieInterpreter[] interpreters = global::Cassie.CassieTtsAnnouncer.Interpreters;
			for (int i = 0; i < interpreters.Length; i++)
			{
				global::System.Collections.Generic.List<global::Cassie.Interpreters.CassieInterpreter.Result> results = interpreters[i].GetResults(LineDatabase, ref modifiers, word, stringBuilder, out var halt);
				time += global::System.Linq.Enumerable.Sum(results, (global::Cassie.Interpreters.CassieInterpreter.Result result) => result.Modifiers.GetTimeUntilNextWord(result.Line));
				if (halt)
				{
					break;
				}
			}
			global::NorthwoodLib.Pools.StringBuilderPool.Shared.Return(stringBuilder);
			if (num >= 0)
			{
				remaining = remaining.Slice(num + 1);
				CalculateDuration(remaining, modifiers, out var time2);
				time += time2;
			}
		}
	}
}
