using UnityEngine;

public class WarningAwawke : MonoBehaviour
{
	// Client-only serialized fields restored from the v14 client layout (server build stripped them).
	public global::UnityEngine.UI.Toggle toggle;


	private void Awake()
	{
		if (PlayerPrefsSl.Get("warningToggle", "false") == "true")
		{
			base.gameObject.SetActive(value: false);
		}
	}

	public void Close()
	{
		if (toggle.isOn)
		{
			PlayerPrefsSl.Set("warningToggle", "true");
		}
		base.gameObject.SetActive(value: false);
	}
}
