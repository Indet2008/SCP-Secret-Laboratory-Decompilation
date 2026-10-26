namespace CustomPlayerEffects.Danger
{
	public class WarheadDanger : DangerStackBase
	{
		public override float DangerValue { get; set; } = 1f;

		public override void Initialize(ReferenceHub target)
		{
			base.Initialize(target);
			UpdateState(AlphaWarheadController.InProgress);
			AlphaWarheadController.OnProgressChanged += UpdateState;
			AlphaWarheadController.OnDetonated += OnDetonated;
		}

		public override void Dispose()
		{
			base.Dispose();
			AlphaWarheadController.OnProgressChanged -= UpdateState;
			AlphaWarheadController.OnDetonated -= OnDetonated;
		}

		private void UpdateState(bool warheadActive)
		{
			IsActive = warheadActive && !AlphaWarheadController.Detonated;
		}

		private void OnDetonated()
		{
			UpdateState(AlphaWarheadController.InProgress);
		}
	}
}
