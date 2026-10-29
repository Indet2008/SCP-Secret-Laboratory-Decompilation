using UnityEngine;
using UserSettings;
using UserSettings.GUIElements;

namespace Utils
{
	// Restored from the client build (IL2CPP): the GameObject is active only while a bool user setting equals ValueToEnable.
	public class SettingsBasedObjectEnabler : MonoBehaviour
	{
		[field: SerializeField]
		public LinkableEnum TargetEnum { get; private set; }

		public bool ValueToEnable;

		private void Awake()
		{
			UserSetting<bool>.AddListener(TargetEnum.TypeHash, TargetEnum.Value, OnSettingChanged);
			OnSettingChanged(UserSetting<bool>.Get(TargetEnum.TypeHash, TargetEnum.Value));
		}

		private void OnDestroy()
		{
			UserSetting<bool>.RemoveListener(OnSettingChanged);
		}

		private void OnSettingChanged(bool val)
		{
			base.gameObject.SetActive(val == ValueToEnable);
		}
	}
}
