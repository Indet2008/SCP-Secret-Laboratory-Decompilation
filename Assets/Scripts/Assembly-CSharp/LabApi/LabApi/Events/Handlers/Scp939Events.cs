namespace LabApi.Events.Handlers
{
	public static class Scp939Events
	{
		public static event global::LabApi.Events.LabEventHandler<global::LabApi.Events.Arguments.Scp939Events.Scp939AttackingEventArgs>? Attacking;

		public static event global::LabApi.Events.LabEventHandler<global::LabApi.Events.Arguments.Scp939Events.Scp939AttackedEventArgs>? Attacked;

		public static event global::LabApi.Events.LabEventHandler<global::LabApi.Events.Arguments.Scp939Events.Scp939CreatingAmnesticCloudEventArgs>? CreatingAmnesticCloud;

		public static event global::LabApi.Events.LabEventHandler<global::LabApi.Events.Arguments.Scp939Events.Scp939CreatedAmnesticCloudEventArgs>? CreatedAmnesticCloud;

		public static event global::LabApi.Events.LabEventHandler<global::LabApi.Events.Arguments.Scp939Events.Scp939LungingEventArgs>? Lunging;

		public static event global::LabApi.Events.LabEventHandler<global::LabApi.Events.Arguments.Scp939Events.Scp939LungedEventArgs>? Lunged;

		public static event global::LabApi.Events.LabEventHandler<global::LabApi.Events.Arguments.Scp939Events.Scp939FocusedEventArgs>? Focused;

		public static event global::LabApi.Events.LabEventHandler<global::LabApi.Events.Arguments.Scp939Events.Scp939MimickingEnvironmentEventArgs>? MimickingEnvironment;

		public static event global::LabApi.Events.LabEventHandler<global::LabApi.Events.Arguments.Scp939Events.Scp939MimickedEnvironmentEventArgs>? MimickedEnvironment;

		public static void OnAttacking(global::LabApi.Events.Arguments.Scp939Events.Scp939AttackingEventArgs ev)
		{
			Attacking.InvokeEvent(ev);
		}

		public static void OnAttacked(global::LabApi.Events.Arguments.Scp939Events.Scp939AttackedEventArgs ev)
		{
			Attacked.InvokeEvent(ev);
		}

		public static void OnCreatingAmnesticCloud(global::LabApi.Events.Arguments.Scp939Events.Scp939CreatingAmnesticCloudEventArgs ev)
		{
			CreatingAmnesticCloud.InvokeEvent(ev);
		}

		public static void OnCreatedAmnesticCloud(global::LabApi.Events.Arguments.Scp939Events.Scp939CreatedAmnesticCloudEventArgs ev)
		{
			CreatedAmnesticCloud.InvokeEvent(ev);
		}

		public static void OnLunging(global::LabApi.Events.Arguments.Scp939Events.Scp939LungingEventArgs ev)
		{
			Lunging.InvokeEvent(ev);
		}

		public static void OnLunged(global::LabApi.Events.Arguments.Scp939Events.Scp939LungedEventArgs ev)
		{
			Lunged.InvokeEvent(ev);
		}

		public static void OnFocused(global::LabApi.Events.Arguments.Scp939Events.Scp939FocusedEventArgs ev)
		{
			Focused.InvokeEvent(ev);
		}

		public static void OnMimickingEnvironment(global::LabApi.Events.Arguments.Scp939Events.Scp939MimickingEnvironmentEventArgs ev)
		{
			MimickingEnvironment.InvokeEvent(ev);
		}

		public static void OnMimickedEnvironment(global::LabApi.Events.Arguments.Scp939Events.Scp939MimickedEnvironmentEventArgs ev)
		{
			MimickedEnvironment.InvokeEvent(ev);
		}
	}
}
