using System.Collections.Generic;
using MEC;
using UnityEngine;
using UnityEngine.UI;

public class CrashDetector : MonoBehaviour
{
	public static CrashDetector singleton;

	[SerializeField]
	private GameObject image;

	[SerializeField]
	private Button button;

	[SerializeField]
	private Text text;

	private void Awake()
	{
		if (image == null)
		{
			Object.Destroy(this);
			return;
		}
		singleton = this;
		base.gameObject.SetActive(Show());
	}

	public bool Show()
	{
		string graphicsDeviceName = SystemInfo.graphicsDeviceName;
		if (graphicsDeviceName.IndexOf("INTEL", System.StringComparison.OrdinalIgnoreCase) < 0 || PlayerPrefsSl.Get("intel_warned", defaultValue: false))
		{
			return false;
		}
		PlayerPrefsSl.Set("intel_warned", value: true);
		Timing.RunCoroutine(_IShow(), Segment.FixedUpdate);
		return true;
	}

	private IEnumerator<float> _IShow()
	{
		string okay = TranslationReader.Get("MenuWarning", 1, "OKAY");
		base.gameObject.SetActive(value: true);
		image.SetActive(value: true);
		button.interactable = false;
		for (int i = 15; i >= 1; i--)
		{
			text.text = string.Format("{0} ({1})", okay, i);
			yield return Timing.WaitForSeconds(1f);
		}
		text.text = okay;
		button.interactable = true;
	}
}
