using TMPro;
using UnityEngine;

namespace PlayerRoles.PlayableScps.Scp079.GUI
{
	public class Scp079NotificationEntry : Scp079GuiElementBase
	{
		[SerializeField]
		private TextMeshProUGUI _text;

		public IScp079Notification Content { get; internal set; }

		public TextMeshProUGUI Text => _text;
	}
}
