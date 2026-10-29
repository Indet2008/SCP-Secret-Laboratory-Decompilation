using TMPro;
using UnityEngine;

namespace PlayerRoles.Spectating
{
	public class CompactSpectatableListElement : SpectatableListElementBase
	{
		[SerializeField]
		private TextMeshProUGUI _nicknameText;

		protected override void Update()
		{
			base.Update();
			_nicknameText.text = base.Target.TargetHub.nicknameSync.DisplayName ?? string.Empty;
			_nicknameText.color = base.Target.MainRole.RoleColor;
		}
	}
}
