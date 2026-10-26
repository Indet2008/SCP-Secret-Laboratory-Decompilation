using PlayerRoles.PlayableScps.Scp096;

namespace CustomPlayerEffects.Danger
{
	public class RageTargetDanger : DangerStackBase
	{
		public override float DangerValue { get; set; } = 2f;

		public override void Initialize(ReferenceHub target)
		{
			base.Initialize(target);
			foreach (ReferenceHub allHub in ReferenceHub.AllHubs)
			{
				if (allHub.roleManager.CurrentRole is Scp096Role scp096Role && scp096Role.SubroutineModule.TryGetSubroutine<Scp096TargetsTracker>(out var subroutine) && subroutine.Targets.Contains(base.Owner))
				{
					IsActive = true;
				}
			}
			Scp096TargetsTracker.OnTargetAdded += OnTargetAdded;
			Scp096TargetsTracker.OnTargetRemoved += OnTargetRemoved;
		}

		public override void Dispose()
		{
			base.Dispose();
			Scp096TargetsTracker.OnTargetAdded -= OnTargetAdded;
			Scp096TargetsTracker.OnTargetRemoved -= OnTargetRemoved;
		}

		private void OnTargetAdded(ReferenceHub owner, ReferenceHub target)
		{
			UpdateState(targetAdded: true, target);
		}

		private void OnTargetRemoved(ReferenceHub owner, ReferenceHub target)
		{
			UpdateState(targetAdded: false, target);
		}

		private void UpdateState(bool targetAdded, ReferenceHub targetedHub)
		{
			if (!(targetedHub == null) && !(targetedHub != base.Owner))
			{
				IsActive = targetAdded;
			}
		}
	}
}
