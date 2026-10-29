namespace LabApi.Events.Handlers
{
	public static class Scp127Events
	{
		public static event global::LabApi.Events.LabEventHandler<global::LabApi.Events.Arguments.Scp127Events.Scp127GainingExperienceEventArgs>? GainingExperience;

		public static event global::LabApi.Events.LabEventHandler<global::LabApi.Events.Arguments.Scp127Events.Scp127GainExperienceEventArgs>? GainExperience;

		public static event global::LabApi.Events.LabEventHandler<global::LabApi.Events.Arguments.Scp127Events.Scp127LevellingUpEventArgs>? LevellingUp;

		public static event global::LabApi.Events.LabEventHandler<global::LabApi.Events.Arguments.Scp127Events.Scp127LevelUpEventArgs>? LevelUp;

		public static event global::LabApi.Events.LabEventHandler<global::LabApi.Events.Arguments.Scp127Events.Scp127TalkingEventArgs>? Talking;

		public static event global::LabApi.Events.LabEventHandler<global::LabApi.Events.Arguments.Scp127Events.Scp127TalkedEventArgs>? Talked;

		public static void OnGainingExperience(global::LabApi.Events.Arguments.Scp127Events.Scp127GainingExperienceEventArgs ev)
		{
			GainingExperience.InvokeEvent(ev);
		}

		public static void OnGainExperience(global::LabApi.Events.Arguments.Scp127Events.Scp127GainExperienceEventArgs ev)
		{
			GainExperience.InvokeEvent(ev);
		}

		public static void OnLevellingUp(global::LabApi.Events.Arguments.Scp127Events.Scp127LevellingUpEventArgs ev)
		{
			LevellingUp.InvokeEvent(ev);
		}

		public static void OnLevelUp(global::LabApi.Events.Arguments.Scp127Events.Scp127LevelUpEventArgs ev)
		{
			LevelUp.InvokeEvent(ev);
		}

		public static void OnTalking(global::LabApi.Events.Arguments.Scp127Events.Scp127TalkingEventArgs ev)
		{
			Talking.InvokeEvent(ev);
		}

		public static void OnTalked(global::LabApi.Events.Arguments.Scp127Events.Scp127TalkedEventArgs ev)
		{
			Talked.InvokeEvent(ev);
		}
	}
}
