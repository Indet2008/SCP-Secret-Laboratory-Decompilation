namespace LabApi.Events.Handlers
{
	public static class Scp049Events
	{
		public static event global::LabApi.Events.LabEventHandler<global::LabApi.Events.Arguments.Scp049Events.Scp049StartingResurrectionEventArgs>? StartingResurrection;

		public static event global::LabApi.Events.LabEventHandler<global::LabApi.Events.Arguments.Scp049Events.Scp049ResurrectingBodyEventArgs>? ResurrectingBody;

		public static event global::LabApi.Events.LabEventHandler<global::LabApi.Events.Arguments.Scp049Events.Scp049ResurrectedBodyEventArgs>? ResurrectedBody;

		public static event global::LabApi.Events.LabEventHandler<global::LabApi.Events.Arguments.Scp049Events.Scp049UsingDoctorsCallEventArgs>? UsingDoctorsCall;

		public static event global::LabApi.Events.LabEventHandler<global::LabApi.Events.Arguments.Scp049Events.Scp049UsedDoctorsCallEventArgs>? UsedDoctorsCall;

		public static event global::LabApi.Events.LabEventHandler<global::LabApi.Events.Arguments.Scp049Events.Scp049UsingSenseEventArgs>? UsingSense;

		public static event global::LabApi.Events.LabEventHandler<global::LabApi.Events.Arguments.Scp049Events.Scp049UsedSenseEventArgs>? UsedSense;

		public static event global::LabApi.Events.LabEventHandler<global::LabApi.Events.Arguments.Scp049Events.Scp049AttackingEventArgs>? Attacking;

		public static event global::LabApi.Events.LabEventHandler<global::LabApi.Events.Arguments.Scp049Events.Scp049AttackedEventArgs>? Attacked;

		public static event global::LabApi.Events.LabEventHandler<global::LabApi.Events.Arguments.Scp049Events.Scp049SenseLostTargetEventArgs>? SenseLostTarget;

		public static event global::LabApi.Events.LabEventHandler<global::LabApi.Events.Arguments.Scp049Events.Scp049SenseKilledTargetEventArgs>? SenseKilledTarget;

		public static void OnStartingResurrection(global::LabApi.Events.Arguments.Scp049Events.Scp049StartingResurrectionEventArgs ev)
		{
			StartingResurrection.InvokeEvent(ev);
		}

		public static void OnResurrectingBody(global::LabApi.Events.Arguments.Scp049Events.Scp049ResurrectingBodyEventArgs ev)
		{
			ResurrectingBody.InvokeEvent(ev);
		}

		public static void OnResurrectedBody(global::LabApi.Events.Arguments.Scp049Events.Scp049ResurrectedBodyEventArgs ev)
		{
			ResurrectedBody.InvokeEvent(ev);
		}

		public static void OnUsingDoctorsCall(global::LabApi.Events.Arguments.Scp049Events.Scp049UsingDoctorsCallEventArgs ev)
		{
			UsingDoctorsCall.InvokeEvent(ev);
		}

		public static void OnUsedDoctorsCall(global::LabApi.Events.Arguments.Scp049Events.Scp049UsedDoctorsCallEventArgs ev)
		{
			UsedDoctorsCall.InvokeEvent(ev);
		}

		public static void OnUsingSense(global::LabApi.Events.Arguments.Scp049Events.Scp049UsingSenseEventArgs ev)
		{
			UsingSense.InvokeEvent(ev);
		}

		public static void OnUsedSense(global::LabApi.Events.Arguments.Scp049Events.Scp049UsedSenseEventArgs ev)
		{
			UsedSense.InvokeEvent(ev);
		}

		public static void OnAttacking(global::LabApi.Events.Arguments.Scp049Events.Scp049AttackingEventArgs ev)
		{
			Attacking.InvokeEvent(ev);
		}

		public static void OnAttacked(global::LabApi.Events.Arguments.Scp049Events.Scp049AttackedEventArgs ev)
		{
			Attacked.InvokeEvent(ev);
		}

		public static void OnSenseLostTarget(global::LabApi.Events.Arguments.Scp049Events.Scp049SenseLostTargetEventArgs ev)
		{
			SenseLostTarget.InvokeEvent(ev);
		}

		public static void OnSenseKilledTarget(global::LabApi.Events.Arguments.Scp049Events.Scp049SenseKilledTargetEventArgs ev)
		{
			SenseKilledTarget.InvokeEvent(ev);
		}
	}
}
