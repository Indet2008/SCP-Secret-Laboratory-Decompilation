using TMPro;
using UnityEngine;
using UnityEngine.EventSystems;

namespace PlayerRoles.Spectating
{
	public class OverwatchHelpButton : MonoBehaviour, IPointerEnterHandler, IEventSystemHandler, IPointerExitHandler
	{
		public GameObject HelpDialog;

		public TextMeshProUGUI HelpText;

		public TextLanguageReplacer HelpTextReplacer;

		public void OnPointerEnter(PointerEventData eventData)
		{
			HelpDialog.SetActive(value: true);
			HelpText.text = HelpTextReplacer.DisplayText;
		}

		public void OnPointerExit(PointerEventData eventData)
		{
			HelpDialog.SetActive(value: false);
		}
	}
}
