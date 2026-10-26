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
		return false;
	}
}
