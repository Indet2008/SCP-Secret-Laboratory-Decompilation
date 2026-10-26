using UnityEngine;
using UnityEngine.UI;

namespace PlayerRoles.Spectating.SpectatableListEffects
{
	public abstract class SpectatorIconEffect : MonoBehaviour
	{
		protected const float BackgroundAlpha = 0.7843f;

		public Image IconBackground;

		public bool IsVisible { get; set; }

		public SpectatableListElementBase SpectatableListElement { get; set; }

		public virtual void Start()
		{
			UpdateIconVisibility(isVisible: false);
		}

		public virtual void Update()
		{
			if (IsVisible)
			{
				UpdateVisible();
				UpdateColor();
			}
		}

		public virtual void UpdateVisible()
		{
		}

		public virtual void UpdateColor()
		{
			PlayerRoleBase mainRole = SpectatableListElement.Target.MainRole;
			IconBackground.color = new Color(mainRole.RoleColor.r, mainRole.RoleColor.g, mainRole.RoleColor.b, 0.7843f);
		}

		public virtual void UpdateIconVisibility(bool isVisible)
		{
			if (IsVisible != isVisible)
			{
				IsVisible = isVisible;
				base.gameObject.SetActive(isVisible);
			}
		}

		public virtual void OnTargetChanged(SpectatableModuleBase previous, SpectatableModuleBase current)
		{
			UpdateIconVisibility(isVisible: false);
		}
	}
}
