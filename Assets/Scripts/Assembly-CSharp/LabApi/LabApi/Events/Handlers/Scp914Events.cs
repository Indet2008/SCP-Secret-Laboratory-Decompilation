namespace LabApi.Events.Handlers
{
	public static class Scp914Events
	{
		public static event global::LabApi.Events.LabEventHandler<global::LabApi.Events.Arguments.Scp914Events.Scp914ActivatingEventArgs>? Activating;

		public static event global::LabApi.Events.LabEventHandler<global::LabApi.Events.Arguments.Scp914Events.Scp914ActivatedEventArgs>? Activated;

		public static event global::LabApi.Events.LabEventHandler<global::LabApi.Events.Arguments.Scp914Events.Scp914KnobChangingEventArgs>? KnobChanging;

		public static event global::LabApi.Events.LabEventHandler<global::LabApi.Events.Arguments.Scp914Events.Scp914KnobChangedEventArgs>? KnobChanged;

		public static event global::LabApi.Events.LabEventHandler<global::LabApi.Events.Arguments.Scp914Events.Scp914ProcessingPickupEventArgs>? ProcessingPickup;

		public static event global::LabApi.Events.LabEventHandler<global::LabApi.Events.Arguments.Scp914Events.Scp914ProcessedPickupEventArgs>? ProcessedPickup;

		public static event global::LabApi.Events.LabEventHandler<global::LabApi.Events.Arguments.Scp914Events.Scp914ProcessingPlayerEventArgs>? ProcessingPlayer;

		public static event global::LabApi.Events.LabEventHandler<global::LabApi.Events.Arguments.Scp914Events.Scp914ProcessedPlayerEventArgs>? ProcessedPlayer;

		public static event global::LabApi.Events.LabEventHandler<global::LabApi.Events.Arguments.Scp914Events.Scp914ProcessingInventoryItemEventArgs>? ProcessingInventoryItem;

		public static event global::LabApi.Events.LabEventHandler<global::LabApi.Events.Arguments.Scp914Events.Scp914ProcessedInventoryItemEventArgs>? ProcessedInventoryItem;

		public static void OnActivating(global::LabApi.Events.Arguments.Scp914Events.Scp914ActivatingEventArgs ev)
		{
			Activating.InvokeEvent(ev);
		}

		public static void OnActivated(global::LabApi.Events.Arguments.Scp914Events.Scp914ActivatedEventArgs ev)
		{
			Activated.InvokeEvent(ev);
		}

		public static void OnKnobChanging(global::LabApi.Events.Arguments.Scp914Events.Scp914KnobChangingEventArgs ev)
		{
			KnobChanging.InvokeEvent(ev);
		}

		public static void OnKnobChanged(global::LabApi.Events.Arguments.Scp914Events.Scp914KnobChangedEventArgs ev)
		{
			KnobChanged.InvokeEvent(ev);
		}

		public static void OnProcessingPickup(global::LabApi.Events.Arguments.Scp914Events.Scp914ProcessingPickupEventArgs ev)
		{
			ProcessingPickup.InvokeEvent(ev);
		}

		public static void OnProcessedPickup(global::LabApi.Events.Arguments.Scp914Events.Scp914ProcessedPickupEventArgs ev)
		{
			ProcessedPickup.InvokeEvent(ev);
		}

		public static void OnProcessingPlayer(global::LabApi.Events.Arguments.Scp914Events.Scp914ProcessingPlayerEventArgs ev)
		{
			ProcessingPlayer.InvokeEvent(ev);
		}

		public static void OnProcessedPlayer(global::LabApi.Events.Arguments.Scp914Events.Scp914ProcessedPlayerEventArgs ev)
		{
			ProcessedPlayer.InvokeEvent(ev);
		}

		public static void OnProcessingInventoryItem(global::LabApi.Events.Arguments.Scp914Events.Scp914ProcessingInventoryItemEventArgs ev)
		{
			ProcessingInventoryItem.InvokeEvent(ev);
		}

		public static void OnProcessedInventoryItem(global::LabApi.Events.Arguments.Scp914Events.Scp914ProcessedInventoryItemEventArgs ev)
		{
			ProcessedInventoryItem.InvokeEvent(ev);
		}
	}
}
