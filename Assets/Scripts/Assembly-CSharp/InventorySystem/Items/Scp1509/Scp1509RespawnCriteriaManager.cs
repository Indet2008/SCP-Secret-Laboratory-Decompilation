using System.Collections.Generic;
using PlayerRoles;

namespace InventorySystem.Items.Scp1509
{
	public class Scp1509RespawnCriteriaManager
	{
		public List<Scp1509RespawnCriteriaBase> Scp1509RespawnCriteria = new List<Scp1509RespawnCriteriaBase>
		{
			new Scp1509RespawnCriteriaDClass(),
			new Scp1509RespawnCriteriaDScientist(),
			new Scp1509RespawnCriteriaNTF(),
			new Scp1509RespawnCriteriaCI(),
			new Scp1509RespawnCriteriaTutorial()
		};

		public RoleTypeId ServerGetRespawnRole(ReferenceHub killer, ReferenceHub victim)
		{
			foreach (Scp1509RespawnCriteriaBase scp1509RespawnCriterion in Scp1509RespawnCriteria)
			{
				if (scp1509RespawnCriterion.KillerRoles.Contains(killer.GetRoleId()))
				{
					return scp1509RespawnCriterion.GetRespawnRole(killer, victim);
				}
			}
			return RoleTypeId.None;
		}
	}
}
