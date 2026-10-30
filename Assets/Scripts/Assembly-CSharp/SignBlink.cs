using UnityEngine;

public class SignBlink : MonoBehaviour
{
	public bool verticalText;

	private string startText;

	public void Play(int duration)
	{
		if (startText == "")
		{
			startText = GetComponent<TMPro.TextMeshProUGUI>().text;
		}
		else
		{
			GetComponent<TMPro.TextMeshProUGUI>().text = startText;
		}
	}
}
