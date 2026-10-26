using PlayerRoles;
using RemoteAdmin.Elements;
using RemoteAdmin.Menus;
using UnityEngine;
using UnityEngine.UI;

namespace RemoteAdmin
{
	public class RoleElement : ValueButton
	{
		[SerializeField]
		private RawImage _avatar;

		[SerializeField]
		private Image _background;

		[SerializeField]
		private Image _border;

		[SerializeField]
		private float _backgroundAlpha;

		private RoleTypeId _roleTypeId;

		private PlayerRoleBase _role;

		public RoleTypeId RoleTypeId => _roleTypeId;

		public void SetupInterface(PlayerRoleBase role, RoleTypeId roleType)
		{
			EnsureInitialized();
			_role = role;
			_roleTypeId = roleType;
			base.Value = ((int)roleType).ToString();
			if (!(role == null))
			{
				Color roleColor = role.RoleColor;
				if (_avatar != null)
				{
					_avatar.texture = ((role is IAvatarRole avatarRole) ? avatarRole.RoleAvatar : null);
				}
				if (_border != null)
				{
					_border.color = roleColor;
				}
				if (_background != null)
				{
					_background.color = GenerateBackground(roleColor);
				}
				if (base.Text != null)
				{
					base.Text.text = TranslationReader.Get("RA_RoleManagement", (int)roleType + 1, role.RoleName);
					base.Text.color = roleColor;
				}
				if (base.CommandMenu != null && base.CommandMenu.Options != null && !base.CommandMenu.Options.Contains(this))
				{
					base.CommandMenu.Options.Add(this);
				}
			}
		}

		public override void SetState(bool isSelected)
		{
			base.SetState(isSelected);
			if (!(base.CommandMenu is RoleManagementMenu roleManagementMenu) || _role == null)
			{
				return;
			}
			if (isSelected)
			{
				roleManagementMenu.UpdateGraphic(_role.RoleColor, (_avatar != null) ? _avatar.texture : null, (base.Text != null) ? base.Text.text : _role.RoleName);
				return;
			}
			bool flag = false;
			foreach (ValueButton option in roleManagementMenu.Options)
			{
				if (option is RoleElement && option.IsSelected)
				{
					flag = true;
					break;
				}
			}
			if (!flag)
			{
				roleManagementMenu.ResetGraphic();
			}
		}

		private Color GenerateBackground(Color originalColor)
		{
			return new Color(originalColor.r, originalColor.g, originalColor.b, _backgroundAlpha * 0.01f);
		}
	}
}