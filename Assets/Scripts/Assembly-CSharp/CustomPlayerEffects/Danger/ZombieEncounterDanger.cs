using PlayerRoles;
using PlayerRoles.PlayableScps;

namespace CustomPlayerEffects.Danger
{
	public class ZombieEncounterDanger : EncounterDangerBase
	{
		public override bool IsActive
		{
			get
			{
				UpdateState();
				return base.IsActive;
			}
			protected set
			{
				base.IsActive = value;
			}
		}

		public override float DangerPerEncounter { get; } = 0.25f;

		public override float DangerPerAdditionalEncounter { get; } = 0.25f;

		private void UpdateState()
		{
			foreach (ReferenceHub allHub in ReferenceHub.AllHubs)
			{
				if (!(allHub == base.Owner) && allHub.roleManager.CurrentRole.RoleTypeId == RoleTypeId.Scp0492 && VisionInformation.IsInView(base.Owner, allHub))
				{
					if (WasEncounteredRecently(allHub, out var cachedEncounter))
					{
						cachedEncounter.TimeTracker.Restart();
					}
					else
					{
						RegisterEncounter(allHub);
					}
				}
			}
		}
	}
}
