using UnityEngine;
using UnityEngine.UI;

namespace PlayerRoles.Spectating.SpectatableListEffects
{
	public abstract class SpectatorSliderIconEffect : SpectatorIconEffect
	{
		private const float SliderBackgroundAlpha = 0.2745f;

		public Image SliderIcon;

		public float SliderValue
		{
			get
			{
				return SliderIcon.fillAmount;
			}
			set
			{
				SliderIcon.fillAmount = Mathf.Clamp01(value);
			}
		}

		public override void Start()
		{
			base.Start();
			SliderValue = 1f;
		}

		public override void UpdateColor()
		{
			PlayerRoleBase mainRole = base.SpectatableListElement.Target.MainRole;
			IconBackground.color = new Color(mainRole.RoleColor.r, mainRole.RoleColor.g, mainRole.RoleColor.b, 0.2745f);
			SliderIcon.color = new Color(mainRole.RoleColor.r, mainRole.RoleColor.g, mainRole.RoleColor.b, 0.7843f);
		}
	}
}
