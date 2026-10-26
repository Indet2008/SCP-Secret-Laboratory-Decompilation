using PlayerRoles.Voice;
using UnityEngine;

namespace PlayerRoles
{
	public class NoneRole : PlayerRoleBase, IVoiceRole
	{
		[field: SerializeField]
		public VoiceModuleBase VoiceModule { get; private set; }

		public override RoleTypeId RoleTypeId => RoleTypeId.None;

		public override Color RoleColor => Color.white;

		public override Team Team => Team.Dead;
	}
}
