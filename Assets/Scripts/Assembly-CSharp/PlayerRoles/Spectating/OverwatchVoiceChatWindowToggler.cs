using TMPro;
using ToggleableMenus;
using UnityEngine;

namespace PlayerRoles.Spectating
{
	public class OverwatchVoiceChatWindowToggler : SimpleToggleableMenu
	{
		[SerializeField]
		private TextMeshProUGUI _toggleHint;

		[SerializeField]
		private TextMeshProUGUI _menuTitle;

		public override bool CanToggle
		{
			get
			{
				if (!base.gameObject.activeInHierarchy)
				{
					return false;
				}
				if (!ReferenceHub.TryGetLocalHub(out var hub))
				{
					return false;
				}
				return hub.GetRoleId() == RoleTypeId.Overwatch;
			}
		}

		protected override void Awake()
		{
			base.Awake();
			_toggleHint.text = string.Format(TranslationReader.Get("Overwatch_HUD", 0, "Press {0} to open the voice channel selector."), new ReadableKeyCode(NewInput.GetKey(MenuActionKey)));
			_menuTitle.text = TranslationReader.Get("Overwatch_HUD", 1, "Voice Channel Selector");
		}
	}
}
