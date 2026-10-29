namespace LabApi.Events.Handlers
{
	public static class Scp3114Events
	{
		public static event global::LabApi.Events.LabEventHandler<global::LabApi.Events.Arguments.Scp3114Events.Scp3114DisguisingEventArgs>? Disguising;

		public static event global::LabApi.Events.LabEventHandler<global::LabApi.Events.Arguments.Scp3114Events.Scp3114DisguisedEventArgs>? Disguised;

		public static event global::LabApi.Events.LabEventHandler<global::LabApi.Events.Arguments.Scp3114Events.Scp3114RevealingEventArgs>? Revealing;

		public static event global::LabApi.Events.LabEventHandler<global::LabApi.Events.Arguments.Scp3114Events.Scp3114RevealedEventArgs>? Revealed;

		public static event global::LabApi.Events.LabEventHandler<global::LabApi.Events.Arguments.Scp3114Events.Scp3114StrangleStartingEventArgs>? StrangleStarting;

		public static event global::LabApi.Events.LabEventHandler<global::LabApi.Events.Arguments.Scp3114Events.Scp3114StrangleStartedEventArgs>? StrangleStarted;

		public static event global::LabApi.Events.LabEventHandler<global::LabApi.Events.Arguments.Scp3114Events.Scp3114StrangleAbortingEventArgs>? StrangleAborting;

		public static event global::LabApi.Events.LabEventHandler<global::LabApi.Events.Arguments.Scp3114Events.Scp3114StartedDanceEventArgs>? Dance;

		public static event global::LabApi.Events.LabEventHandler<global::LabApi.Events.Arguments.Scp3114Events.Scp3114StartingDanceEventArgs>? StartDancing;

		public static event global::LabApi.Events.LabEventHandler<global::LabApi.Events.Arguments.Scp3114Events.Scp3114StrangleAbortedEventArgs>? StrangleAborted;

		public static void OnDisguising(global::LabApi.Events.Arguments.Scp3114Events.Scp3114DisguisingEventArgs ev)
		{
			Disguising.InvokeEvent(ev);
		}

		public static void OnDisguised(global::LabApi.Events.Arguments.Scp3114Events.Scp3114DisguisedEventArgs ev)
		{
			Disguised.InvokeEvent(ev);
		}

		public static void OnRevealing(global::LabApi.Events.Arguments.Scp3114Events.Scp3114RevealingEventArgs ev)
		{
			Revealing.InvokeEvent(ev);
		}

		public static void OnRevealed(global::LabApi.Events.Arguments.Scp3114Events.Scp3114RevealedEventArgs ev)
		{
			Revealed.InvokeEvent(ev);
		}

		public static void OnStrangleStarting(global::LabApi.Events.Arguments.Scp3114Events.Scp3114StrangleStartingEventArgs ev)
		{
			StrangleStarting.InvokeEvent(ev);
		}

		public static void OnStrangleStarted(global::LabApi.Events.Arguments.Scp3114Events.Scp3114StrangleStartedEventArgs ev)
		{
			StrangleStarted.InvokeEvent(ev);
		}

		public static void OnStrangleAborting(global::LabApi.Events.Arguments.Scp3114Events.Scp3114StrangleAbortingEventArgs ev)
		{
			StrangleAborting.InvokeEvent(ev);
		}

		public static void OnDance(global::LabApi.Events.Arguments.Scp3114Events.Scp3114StartedDanceEventArgs ev)
		{
			Dance.InvokeEvent(ev);
		}

		public static void OnStartDancing(global::LabApi.Events.Arguments.Scp3114Events.Scp3114StartingDanceEventArgs ev)
		{
			StartDancing.InvokeEvent(ev);
		}

		public static void OnStrangleAborted(global::LabApi.Events.Arguments.Scp3114Events.Scp3114StrangleAbortedEventArgs ev)
		{
			StrangleAborted.InvokeEvent(ev);
		}
	}
}
