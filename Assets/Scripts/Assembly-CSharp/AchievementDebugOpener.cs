using GameCore;
using UnityEngine;

public class AchievementDebugOpener : MonoBehaviour
{
	[SerializeField]
	private GameObject _buttonObj;

	private void Awake()
	{
		bool active = Version.BuildType == Version.VersionType.Development || Version.PublicBeta || Version.PrivateBeta;
		_buttonObj.SetActive(active);
	}
}
