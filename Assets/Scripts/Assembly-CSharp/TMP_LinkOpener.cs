using TMPro;
using UnityEngine;
using UnityEngine.EventSystems;

// Client-only (body stripped from the server build); ported from the SL 12 CE client. Opens <link="url"> tags on click.
[RequireComponent(typeof(TMP_Text))]
public class TMP_LinkOpener : MonoBehaviour, IPointerClickHandler, IEventSystemHandler
{
	public void OnPointerClick(PointerEventData eventData)
	{
		TMP_Text text = GetComponent<TMP_Text>();
		int linkIndex = TMP_TextUtilities.FindIntersectingLink(text, eventData.position, eventData.pressEventCamera);
		if (linkIndex < 0)
		{
			return;
		}
		string url = text.textInfo.linkInfo[linkIndex].GetLinkID();
		if (!string.IsNullOrEmpty(url))
		{
			Application.OpenURL(url);
		}
	}
}
