using PlayerRoles;

namespace InventorySystem.Items.Scp1509
{
	public class Scp1509RespawnCriteriaNTF : Scp1509RespawnCriteriaBase
	{
		public override RoleTypeId[] KillerRoles => new RoleTypeId[5]
		{
			RoleTypeId.NtfCaptain,
			RoleTypeId.NtfPrivate,
			RoleTypeId.NtfSergeant,
			RoleTypeId.NtfSpecialist,
			RoleTypeId.FacilityGuard
		};

		public override RoleTypeId GetRespawnRole(ReferenceHub killer, ReferenceHub victim)
		{
			if (Scp1509RespawnCriteriaBase.IsSkippableRole(victim))
			{
				return RoleTypeId.None;
			}
			return RoleTypeId.NtfPrivate;
		}
	}
}
