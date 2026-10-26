namespace CustomPlayerEffects.Danger
{
	public class ExpiringDanger : DangerStackBase
	{
		public override float DangerValue { get; set; }

		public ExpiringDanger(float dangerValue, ReferenceHub owner)
		{
			DangerValue = dangerValue;
			base.Owner = owner;
			Initialize(base.Owner);
		}

		public override void Initialize(ReferenceHub target)
		{
			TimeTracker.Start();
		}
	}
}
