namespace LabApi.Events.Handlers
{
	public static class ScpEvents
	{
		public static event global::LabApi.Events.LabEventHandler<global::LabApi.Events.Arguments.ScpEvents.ScpHumeShieldBrokenEventArgs>? HumeShieldBroken;

		public static void OnHumeShieldBroken(global::LabApi.Events.Arguments.ScpEvents.ScpHumeShieldBrokenEventArgs ev)
		{
			HumeShieldBroken.InvokeEvent(ev);
		}
	}
}
