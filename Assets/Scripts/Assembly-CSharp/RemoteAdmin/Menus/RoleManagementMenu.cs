using System.Linq;
using PlayerRoles;
using TMPro;
using UnityEngine;
using UnityEngine.UI;

namespace RemoteAdmin.Menus
{
	public class RoleManagementMenu : RaCommandMenu
	{
		private const string DefaultName = "None";

		private const string SecretName = "Hubert Moszka";

		private const int SecretMaxTriggers = 173;

		[SerializeField]
		private RoleElement _roleElementPrefab;

		[SerializeField]
		private Transform _rootLayout;

		[SerializeField]
		private RawImage _avatar;

		[SerializeField]
		private Image _background;

		[SerializeField]
		private Image _border;

		[SerializeField]
		private TMP_Text _name;

		[SerializeField]
		private float _backgroundAlpha;

		[SerializeField]
		private Texture _defaultIcon;

		[SerializeField]
		private Texture _secretIcon;

		[SerializeField]
		private Color _secretColor;

		private int _triggers;

		public void UpdateGraphic(Color roleColor, Texture roleIcon, string roleName)
		{
			if (_avatar != null)
			{
				_avatar.texture = roleIcon;
			}
			if (_border != null)
			{
				_border.color = roleColor;
			}
			if (_background != null)
			{
				_background.color = GenerateBackground(roleColor);
			}
			if (_name != null)
			{
				_name.color = roleColor;
				_name.text = roleName;
			}
		}

		public void ResetGraphic()
		{
			if (_triggers++ < SecretMaxTriggers)
			{
				UpdateGraphic(Color.white, _defaultIcon, DefaultName);
			}
			else
			{
				ShowSecret();
			}
		}

		public void ShowSecret()
		{
			UpdateGraphic(_secretColor, _secretIcon, SecretName);
		}

		protected override string BuildCommand(string command, string format)
		{
			string text = base.BuildCommand(command, format);
			RaSettings singleton = RaSettings.Singleton;
			if (string.IsNullOrWhiteSpace(text) || singleton == null)
			{
				return text;
			}
			RoleSpawnFlags roleSpawnFlags = RoleSpawnFlags.None;
			if (singleton.ToggleResetInventory.Value)
			{
				roleSpawnFlags |= RoleSpawnFlags.AssignInventory;
			}
			if (singleton.ToggleSpawnpoint.Value)
			{
				roleSpawnFlags |= RoleSpawnFlags.UseSpawnpoint;
			}
			return text.Trim() + " " + (byte)roleSpawnFlags;
		}

		public override void SendCommand(string command, string format = "")
		{
			if (base.Options != null && base.Options.Any((Elements.ValueButton x) => x is RoleElement && x.IsSelected && x.gameObject.activeInHierarchy))
			{
				base.SendCommand(command, format);
			}
		}

		protected override void OnStart()
		{
			if (_roleElementPrefab == null || _rootLayout == null)
			{
				return;
			}
			foreach (PlayerRoleBase item in from x in PlayerRoleLoader.AllRoles
				orderby x.Key.GetTeam(), x.Key
				select x.Value)
			{
				if (!(item == null) && item.RoleTypeId != RoleTypeId.None && item.RoleTypeId != RoleTypeId.Destroyed)
				{
					RoleElement roleElement = Object.Instantiate(_roleElementPrefab, _rootLayout);
					roleElement.CommandMenu = this;
					roleElement.gameObject.SetActive(value: true);
					roleElement.SetupInterface(item, item.RoleTypeId);
				}
			}
			ResetGraphic();
		}

		private Color GenerateBackground(Color originalColor)
		{
			return new Color(originalColor.r, originalColor.g, originalColor.b, _backgroundAlpha * 0.01f);
		}
	}
}