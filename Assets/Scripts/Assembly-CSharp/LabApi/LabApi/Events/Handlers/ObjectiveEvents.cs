namespace LabApi.Events.Handlers
{
	public static class ObjectiveEvents
	{
		public static event global::LabApi.Events.LabEventHandler<global::LabApi.Events.Arguments.ObjectiveEvents.ObjectiveCompletingBaseEventArgs>? Completing;

		public static event global::LabApi.Events.LabEventHandler<global::LabApi.Events.Arguments.ObjectiveEvents.ObjectiveCompletedBaseEventArgs>? Completed;

		public static event global::LabApi.Events.LabEventHandler<global::LabApi.Events.Arguments.ObjectiveEvents.EnemyKillingObjectiveEventArgs>? KillingEnemyCompleting;

		public static event global::LabApi.Events.LabEventHandler<global::LabApi.Events.Arguments.ObjectiveEvents.EnemyKilledObjectiveEventArgs>? KilledEnemyCompleted;

		public static event global::LabApi.Events.LabEventHandler<global::LabApi.Events.Arguments.ObjectiveEvents.EscapingObjectiveEventArgs>? EscapingCompleting;

		public static event global::LabApi.Events.LabEventHandler<global::LabApi.Events.Arguments.ObjectiveEvents.EscapedObjectiveEventArgs>? EscapedCompleted;

		public static event global::LabApi.Events.LabEventHandler<global::LabApi.Events.Arguments.ObjectiveEvents.GeneratorActivatingObjectiveEventArgs>? ActivatingGeneratorCompleting;

		public static event global::LabApi.Events.LabEventHandler<global::LabApi.Events.Arguments.ObjectiveEvents.GeneratorActivatedObjectiveEventArgs>? ActivatedGeneratorCompleted;

		public static event global::LabApi.Events.LabEventHandler<global::LabApi.Events.Arguments.ObjectiveEvents.ScpDamagingObjectiveEventArgs>? DamagingScpCompleting;

		public static event global::LabApi.Events.LabEventHandler<global::LabApi.Events.Arguments.ObjectiveEvents.ScpDamagedObjectiveEventArgs>? DamagedScpCompleted;

		public static event global::LabApi.Events.LabEventHandler<global::LabApi.Events.Arguments.ObjectiveEvents.ScpItemPickingObjectiveEventArgs>? PickingScpItemCompleting;

		public static event global::LabApi.Events.LabEventHandler<global::LabApi.Events.Arguments.ObjectiveEvents.ScpItemPickedObjectiveEventArgs>? PickedScpItemCompleted;

		public static void OnCompleting(global::LabApi.Events.Arguments.ObjectiveEvents.ObjectiveCompletingBaseEventArgs ev)
		{
			Completing.InvokeEvent(ev);
		}

		public static void OnCompleted(global::LabApi.Events.Arguments.ObjectiveEvents.ObjectiveCompletedBaseEventArgs ev)
		{
			Completed.InvokeEvent(ev);
		}

		public static void OnKillingEnemyCompleting(global::LabApi.Events.Arguments.ObjectiveEvents.EnemyKillingObjectiveEventArgs ev)
		{
			KillingEnemyCompleting.InvokeEvent(ev);
		}

		public static void OnKilledEnemyCompleted(global::LabApi.Events.Arguments.ObjectiveEvents.EnemyKilledObjectiveEventArgs ev)
		{
			KilledEnemyCompleted.InvokeEvent(ev);
		}

		public static void OnEscapingCompleting(global::LabApi.Events.Arguments.ObjectiveEvents.EscapingObjectiveEventArgs ev)
		{
			EscapingCompleting.InvokeEvent(ev);
		}

		public static void OnEscapedCompleted(global::LabApi.Events.Arguments.ObjectiveEvents.EscapedObjectiveEventArgs ev)
		{
			EscapedCompleted.InvokeEvent(ev);
		}

		public static void OnActivatingGeneratorCompleting(global::LabApi.Events.Arguments.ObjectiveEvents.GeneratorActivatingObjectiveEventArgs ev)
		{
			ActivatingGeneratorCompleting.InvokeEvent(ev);
		}

		public static void OnActivatedGeneratorCompleted(global::LabApi.Events.Arguments.ObjectiveEvents.GeneratorActivatedObjectiveEventArgs ev)
		{
			ActivatedGeneratorCompleted.InvokeEvent(ev);
		}

		public static void OnDamagingScpCompleting(global::LabApi.Events.Arguments.ObjectiveEvents.ScpDamagingObjectiveEventArgs ev)
		{
			DamagingScpCompleting.InvokeEvent(ev);
		}

		public static void OnDamagedScpCompleted(global::LabApi.Events.Arguments.ObjectiveEvents.ScpDamagedObjectiveEventArgs ev)
		{
			DamagedScpCompleted.InvokeEvent(ev);
		}

		public static void OnPickingScpItemCompleting(global::LabApi.Events.Arguments.ObjectiveEvents.ScpItemPickingObjectiveEventArgs ev)
		{
			PickingScpItemCompleting.InvokeEvent(ev);
		}

		public static void OnPickedScpItemCompleted(global::LabApi.Events.Arguments.ObjectiveEvents.ScpItemPickedObjectiveEventArgs ev)
		{
			PickedScpItemCompleted.InvokeEvent(ev);
		}
	}
}
