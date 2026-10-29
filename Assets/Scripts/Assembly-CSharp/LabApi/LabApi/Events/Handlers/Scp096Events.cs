namespace LabApi.Events.Handlers
{
	public static class Scp096Events
	{
		public static event global::LabApi.Events.LabEventHandler<global::LabApi.Events.Arguments.Scp096Events.Scp096AddingTargetEventArgs>? AddingTarget;

		public static event global::LabApi.Events.LabEventHandler<global::LabApi.Events.Arguments.Scp096Events.Scp096AddedTargetEventArgs>? AddedTarget;

		public static event global::LabApi.Events.LabEventHandler<global::LabApi.Events.Arguments.Scp096Events.Scp096ChangingStateEventArgs>? ChangingState;

		public static event global::LabApi.Events.LabEventHandler<global::LabApi.Events.Arguments.Scp096Events.Scp096ChangedStateEventArgs>? ChangedState;

		public static event global::LabApi.Events.LabEventHandler<global::LabApi.Events.Arguments.Scp096Events.Scp096ChargingEventArgs>? Charging;

		public static event global::LabApi.Events.LabEventHandler<global::LabApi.Events.Arguments.Scp096Events.Scp096ChargedEventArgs>? Charged;

		public static event global::LabApi.Events.LabEventHandler<global::LabApi.Events.Arguments.Scp096Events.Scp096EnragingEventArgs>? Enraging;

		public static event global::LabApi.Events.LabEventHandler<global::LabApi.Events.Arguments.Scp096Events.Scp096EnragedEventArgs>? Enraged;

		public static event global::LabApi.Events.LabEventHandler<global::LabApi.Events.Arguments.Scp096Events.Scp096PryingGateEventArgs>? PryingGate;

		public static event global::LabApi.Events.LabEventHandler<global::LabApi.Events.Arguments.Scp096Events.Scp096PriedGateEventArgs>? PriedGate;

		public static event global::LabApi.Events.LabEventHandler<global::LabApi.Events.Arguments.Scp096Events.Scp096StartCryingEventArgs>? StartCrying;

		public static event global::LabApi.Events.LabEventHandler<global::LabApi.Events.Arguments.Scp096Events.Scp096StartedCryingEventArgs>? StartedCrying;

		public static event global::LabApi.Events.LabEventHandler<global::LabApi.Events.Arguments.Scp096Events.Scp096TryingNotToCryEventArgs>? TryingNotToCry;

		public static event global::LabApi.Events.LabEventHandler<global::LabApi.Events.Arguments.Scp096Events.Scp096TriedNotToCryEventArgs>? TriedNotToCry;

		public static void OnAddingTarget(global::LabApi.Events.Arguments.Scp096Events.Scp096AddingTargetEventArgs ev)
		{
			AddingTarget.InvokeEvent(ev);
		}

		public static void OnAddedTarget(global::LabApi.Events.Arguments.Scp096Events.Scp096AddedTargetEventArgs ev)
		{
			AddedTarget.InvokeEvent(ev);
		}

		public static void OnChangingState(global::LabApi.Events.Arguments.Scp096Events.Scp096ChangingStateEventArgs ev)
		{
			ChangingState.InvokeEvent(ev);
		}

		public static void OnChangedState(global::LabApi.Events.Arguments.Scp096Events.Scp096ChangedStateEventArgs ev)
		{
			ChangedState.InvokeEvent(ev);
		}

		public static void OnCharging(global::LabApi.Events.Arguments.Scp096Events.Scp096ChargingEventArgs ev)
		{
			Charging.InvokeEvent(ev);
		}

		public static void OnCharged(global::LabApi.Events.Arguments.Scp096Events.Scp096ChargedEventArgs ev)
		{
			Charged.InvokeEvent(ev);
		}

		public static void OnEnraging(global::LabApi.Events.Arguments.Scp096Events.Scp096EnragingEventArgs ev)
		{
			Enraging.InvokeEvent(ev);
		}

		public static void OnEnraged(global::LabApi.Events.Arguments.Scp096Events.Scp096EnragedEventArgs ev)
		{
			Enraged.InvokeEvent(ev);
		}

		public static void OnPryingGate(global::LabApi.Events.Arguments.Scp096Events.Scp096PryingGateEventArgs ev)
		{
			PryingGate.InvokeEvent(ev);
		}

		public static void OnPriedGate(global::LabApi.Events.Arguments.Scp096Events.Scp096PriedGateEventArgs ev)
		{
			PriedGate.InvokeEvent(ev);
		}

		public static void OnStartCrying(global::LabApi.Events.Arguments.Scp096Events.Scp096StartCryingEventArgs ev)
		{
			StartCrying.InvokeEvent(ev);
		}

		public static void OnStartedCrying(global::LabApi.Events.Arguments.Scp096Events.Scp096StartedCryingEventArgs ev)
		{
			StartedCrying.InvokeEvent(ev);
		}

		public static void OnTryingNotToCry(global::LabApi.Events.Arguments.Scp096Events.Scp096TryingNotToCryEventArgs ev)
		{
			TryingNotToCry.InvokeEvent(ev);
		}

		public static void OnTriedNotToCry(global::LabApi.Events.Arguments.Scp096Events.Scp096TriedNotToCryEventArgs ev)
		{
			TriedNotToCry.InvokeEvent(ev);
		}
	}
}
