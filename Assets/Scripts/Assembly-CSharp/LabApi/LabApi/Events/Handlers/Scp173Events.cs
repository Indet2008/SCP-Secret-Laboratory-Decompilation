namespace LabApi.Events.Handlers
{
	public static class Scp173Events
	{
		public static event global::LabApi.Events.LabEventHandler<global::LabApi.Events.Arguments.Scp173Events.Scp173BreakneckSpeedChangingEventArgs>? BreakneckSpeedChanging;

		public static event global::LabApi.Events.LabEventHandler<global::LabApi.Events.Arguments.Scp173Events.Scp173BreakneckSpeedChangedEventArgs>? BreakneckSpeedChanged;

		public static event global::LabApi.Events.LabEventHandler<global::LabApi.Events.Arguments.Scp173Events.Scp173AddingObserverEventArgs>? AddingObserver;

		public static event global::LabApi.Events.LabEventHandler<global::LabApi.Events.Arguments.Scp173Events.Scp173AddedObserverEventArgs>? AddedObserver;

		public static event global::LabApi.Events.LabEventHandler<global::LabApi.Events.Arguments.Scp173Events.Scp173RemovingObserverEventArgs>? RemovingObserver;

		public static event global::LabApi.Events.LabEventHandler<global::LabApi.Events.Arguments.Scp173Events.Scp173RemovedObserverEventArgs>? RemovedObserver;

		public static event global::LabApi.Events.LabEventHandler<global::LabApi.Events.Arguments.Scp173Events.Scp173CreatingTantrumEventArgs>? CreatingTantrum;

		public static event global::LabApi.Events.LabEventHandler<global::LabApi.Events.Arguments.Scp173Events.Scp173CreatedTantrumEventArgs>? CreatedTantrum;

		public static event global::LabApi.Events.LabEventHandler<global::LabApi.Events.Arguments.Scp173Events.Scp173PlayingSoundEventArgs>? PlayingSound;

		public static event global::LabApi.Events.LabEventHandler<global::LabApi.Events.Arguments.Scp173Events.Scp173PlayedSoundEventArgs>? PlayedSound;

		public static event global::LabApi.Events.LabEventHandler<global::LabApi.Events.Arguments.Scp173Events.Scp173TeleportingEventArgs>? Teleporting;

		public static event global::LabApi.Events.LabEventHandler<global::LabApi.Events.Arguments.Scp173Events.Scp173TeleportedEventArgs>? Teleported;

		public static event global::LabApi.Events.LabEventHandler<global::LabApi.Events.Arguments.Scp173Events.Scp173SnappingEventArgs>? Snapping;

		public static event global::LabApi.Events.LabEventHandler<global::LabApi.Events.Arguments.Scp173Events.Scp173SnappedEventArgs>? Snapped;

		public static void OnBreakneckSpeedChanging(global::LabApi.Events.Arguments.Scp173Events.Scp173BreakneckSpeedChangingEventArgs ev)
		{
			BreakneckSpeedChanging.InvokeEvent(ev);
		}

		public static void OnBreakneckSpeedChanged(global::LabApi.Events.Arguments.Scp173Events.Scp173BreakneckSpeedChangedEventArgs ev)
		{
			BreakneckSpeedChanged.InvokeEvent(ev);
		}

		public static void OnAddingObserver(global::LabApi.Events.Arguments.Scp173Events.Scp173AddingObserverEventArgs ev)
		{
			AddingObserver.InvokeEvent(ev);
		}

		public static void OnAddedObserver(global::LabApi.Events.Arguments.Scp173Events.Scp173AddedObserverEventArgs ev)
		{
			AddedObserver.InvokeEvent(ev);
		}

		public static void OnRemovingObserver(global::LabApi.Events.Arguments.Scp173Events.Scp173RemovingObserverEventArgs ev)
		{
			RemovingObserver.InvokeEvent(ev);
		}

		public static void OnRemovedObserver(global::LabApi.Events.Arguments.Scp173Events.Scp173RemovedObserverEventArgs ev)
		{
			RemovedObserver.InvokeEvent(ev);
		}

		public static void OnCreatingTantrum(global::LabApi.Events.Arguments.Scp173Events.Scp173CreatingTantrumEventArgs ev)
		{
			CreatingTantrum.InvokeEvent(ev);
		}

		public static void OnCreatedTantrum(global::LabApi.Events.Arguments.Scp173Events.Scp173CreatedTantrumEventArgs ev)
		{
			CreatedTantrum.InvokeEvent(ev);
		}

		public static void OnPlayingSound(global::LabApi.Events.Arguments.Scp173Events.Scp173PlayingSoundEventArgs ev)
		{
			PlayingSound.InvokeEvent(ev);
		}

		public static void OnPlayedSound(global::LabApi.Events.Arguments.Scp173Events.Scp173PlayedSoundEventArgs ev)
		{
			PlayedSound.InvokeEvent(ev);
		}

		public static void OnTeleporting(global::LabApi.Events.Arguments.Scp173Events.Scp173TeleportingEventArgs ev)
		{
			Teleporting.InvokeEvent(ev);
		}

		public static void OnTeleported(global::LabApi.Events.Arguments.Scp173Events.Scp173TeleportedEventArgs ev)
		{
			Teleported.InvokeEvent(ev);
		}

		public static void OnSnapping(global::LabApi.Events.Arguments.Scp173Events.Scp173SnappingEventArgs ev)
		{
			Snapping.InvokeEvent(ev);
		}

		public static void OnSnapped(global::LabApi.Events.Arguments.Scp173Events.Scp173SnappedEventArgs ev)
		{
			Snapped.InvokeEvent(ev);
		}
	}
}
