using GameCore;
using TMPro;
using UnityEngine;
using UnityEngine.UI;

public class LauncherAssetScanProgressBar : MonoBehaviour
{
	[SerializeField]
	private Image _throbber;

	[SerializeField]
	private SimpleMenu _menu;

	[SerializeField]
	private TMP_Text _text;

	[SerializeField]
	private TMP_Text _version;

	public static float Progress;

	public static string Text;

	private void Awake()
	{
		_version.text = GetVersionName();
	}

	private void Update()
	{
		_throbber.fillAmount = Progress;
		_text.text = $"{Text}\n{Mathf.RoundToInt(Progress * 100f)}%";
	}

	private string GetVersionName()
	{
		string text;
		switch (Version.BuildType)
		{
		case Version.VersionType.Development:
			return "INTERNAL BUILD " + Version.VersionString;
		case Version.VersionType.PrivateBeta:
		case Version.VersionType.PrivateBetaStreamingForbidden:
			text = "CLOSED BETA";
			break;
		case Version.VersionType.PublicRC:
		case Version.VersionType.PrivateRC:
		case Version.VersionType.PrivateRCStreamingForbidden:
			text = "RELEASE CANDIDATE";
			break;
		case Version.VersionType.PublicBeta:
			text = "PUBLIC BETA";
			break;
		default:
			text = Version.BuildType.ToString().ToUpperInvariant();
			break;
		}
		byte major = Version.Major;
		string text2 = major.ToString();
		major = Version.Minor;
		string text3 = text2 + "." + major;
		if (Version.Revision > 0)
		{
			string text4 = text3;
			major = Version.Revision;
			text3 = text4 + "." + major;
		}
		return text + " " + text3;
	}
}
