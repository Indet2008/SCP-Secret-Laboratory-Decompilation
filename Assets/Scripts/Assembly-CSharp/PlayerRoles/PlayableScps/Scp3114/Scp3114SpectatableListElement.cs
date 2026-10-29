using PlayerRoles.Spectating;

namespace PlayerRoles.PlayableScps.Scp3114
{
	// Restored from the client build (IL2CPP): shows SCP-3114's current disguise in the spectator list.
	public class Scp3114SpectatableListElement : StandardSpectatableListElement
	{
		[global::UnityEngine.SerializeField]
		private global::UnityEngine.UI.RawImage _disguiseIcon;

		[global::UnityEngine.SerializeField]
		private global::TMPro.TMP_Text _disguiseText;

		[global::UnityEngine.SerializeField]
		private global::TMPro.TMP_Text _overwatchNickname;

		protected override void Update()
		{
			base.Update();
			if (Target == null || !(Target.MainRole is Scp3114Role scpRole))
			{
				return;
			}
			bool overwatch = ReferenceHub.TryGetLocalHub(out var localHub) && localHub.roleManager.CurrentRole is OverwatchRole;
			if (_overwatchNickname != null)
			{
				_overwatchNickname.text = overwatch ? Target.TargetHub.nicknameSync.DisplayName : string.Empty;
			}
			if (TryGetDisguise(scpRole, out var disguise))
			{
				_disguiseText.text = "?? " + disguise.RoleName;
				_disguiseText.color = disguise.RoleColor;
				_disguiseIcon.enabled = disguise is IAvatarRole;
				if (disguise is IAvatarRole avatarRole)
				{
					_disguiseIcon.texture = avatarRole.RoleAvatar;
				}
			}
			else
			{
				_disguiseText.text = string.Empty;
				_disguiseIcon.enabled = false;
			}
		}

		private static bool TryGetDisguise(Scp3114Role role, out PlayerRoleBase disguise)
		{
			disguise = null;
			Scp3114Identity.StolenIdentity identity = role.CurIdentity;
			return identity.Status == Scp3114Identity.DisguiseStatus.Active && identity.StolenRole.TryGetRoleTemplate(out disguise);
		}
	}
}
