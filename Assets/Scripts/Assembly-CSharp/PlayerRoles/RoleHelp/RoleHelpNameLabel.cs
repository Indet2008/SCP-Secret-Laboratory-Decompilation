using TMPro;
using UnityEngine;

namespace PlayerRoles.RoleHelp
{
	public class RoleHelpNameLabel : MonoBehaviour
	{
		[SerializeField]
		private TMP_Text _text;

		private const string NicknameFile = "Class_Nicknames";

		private void Awake()
		{
			if (ReferenceHub.TryGetLocalHub(out var hub))
			{
				PlayerRoleBase currentRole = hub.roleManager.CurrentRole;
				_text.text = string.Format(_text.text, currentRole.RoleName, TranslationReader.Get("Class_Nicknames", (int)currentRole.RoleTypeId));
			}
		}
	}
}
