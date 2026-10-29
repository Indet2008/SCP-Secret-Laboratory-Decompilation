namespace LabApi.Events.Handlers
{
	public static class WarheadEvents
	{
		public static event global::LabApi.Events.LabEventHandler<global::LabApi.Events.Arguments.WarheadEvents.WarheadStartingEventArgs>? Starting;

		public static event global::LabApi.Events.LabEventHandler<global::LabApi.Events.Arguments.WarheadEvents.WarheadStartedEventArgs>? Started;

		public static event global::LabApi.Events.LabEventHandler<global::LabApi.Events.Arguments.WarheadEvents.WarheadStoppingEventArgs>? Stopping;

		public static event global::LabApi.Events.LabEventHandler<global::LabApi.Events.Arguments.WarheadEvents.WarheadStoppedEventArgs>? Stopped;

		public static event global::LabApi.Events.LabEventHandler<global::LabApi.Events.Arguments.WarheadEvents.WarheadDetonatingEventArgs>? Detonating;

		public static event global::LabApi.Events.LabEventHandler<global::LabApi.Events.Arguments.WarheadEvents.WarheadDetonatedEventArgs>? Detonated;

		public static void OnStarting(global::LabApi.Events.Arguments.WarheadEvents.WarheadStartingEventArgs ev)
		{
			Starting.InvokeEvent(ev);
		}

		public static void OnStarted(global::LabApi.Events.Arguments.WarheadEvents.WarheadStartedEventArgs ev)
		{
			Started.InvokeEvent(ev);
		}

		public static void OnStopping(global::LabApi.Events.Arguments.WarheadEvents.WarheadStoppingEventArgs ev)
		{
			Stopping.InvokeEvent(ev);
		}

		public static void OnStopped(global::LabApi.Events.Arguments.WarheadEvents.WarheadStoppedEventArgs ev)
		{
			Stopped.InvokeEvent(ev);
		}

		public static void OnDetonating(global::LabApi.Events.Arguments.WarheadEvents.WarheadDetonatingEventArgs ev)
		{
			Detonating.InvokeEvent(ev);
		}

		public static void OnDetonated(global::LabApi.Events.Arguments.WarheadEvents.WarheadDetonatedEventArgs ev)
		{
			Detonated.InvokeEvent(ev);
		}
	}
}
