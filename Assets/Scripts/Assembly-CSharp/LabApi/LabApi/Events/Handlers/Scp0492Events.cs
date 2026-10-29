namespace LabApi.Events.Handlers
{
	public static class Scp0492Events
	{
		public static event global::LabApi.Events.LabEventHandler<global::LabApi.Events.Arguments.Scp0492Events.Scp0492StartingConsumingCorpseEventArgs>? StartingConsumingCorpse;

		public static event global::LabApi.Events.LabEventHandler<global::LabApi.Events.Arguments.Scp0492Events.Scp0492StartedConsumingCorpseEventArgs>? StartedConsumingCorpse;

		public static event global::LabApi.Events.LabEventHandler<global::LabApi.Events.Arguments.Scp0492Events.Scp0492ConsumingCorpseEventArgs>? ConsumingCorpse;

		public static event global::LabApi.Events.LabEventHandler<global::LabApi.Events.Arguments.Scp0492Events.Scp0492ConsumedCorpseEventArgs>? ConsumedCorpse;

		public static void OnStartingConsumingCorpse(global::LabApi.Events.Arguments.Scp0492Events.Scp0492StartingConsumingCorpseEventArgs ev)
		{
			StartingConsumingCorpse.InvokeEvent(ev);
		}

		public static void OnStartedConsumingCorpse(global::LabApi.Events.Arguments.Scp0492Events.Scp0492StartedConsumingCorpseEventArgs ev)
		{
			StartedConsumingCorpse.InvokeEvent(ev);
		}

		public static void OnConsumingCorpse(global::LabApi.Events.Arguments.Scp0492Events.Scp0492ConsumingCorpseEventArgs ev)
		{
			ConsumingCorpse.InvokeEvent(ev);
		}

		public static void OnConsumedCorpse(global::LabApi.Events.Arguments.Scp0492Events.Scp0492ConsumedCorpseEventArgs ev)
		{
			ConsumedCorpse.InvokeEvent(ev);
		}
	}
}
