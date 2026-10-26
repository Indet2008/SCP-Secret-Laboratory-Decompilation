using System;
using UnityEngine;

namespace UserSettings.ServerSpecific.Entries
{
	public class SSGroupHeaderEntry : MonoBehaviour, ISSEntry
	{
		[SerializeField]
		private SSEntryLabel _label;

		[SerializeField]
		private float _normalPadding;

		[SerializeField]
		private float _shortPadding;

		private SSGroupHeader _setting;

		public bool CheckCompatibility(ServerSpecificSettingBase setting)
		{
			return setting is SSGroupHeader;
		}

		public void Init(ServerSpecificSettingBase setting)
		{
			RectTransform obj = base.transform as RectTransform;
			_setting = setting as SSGroupHeader;
			obj.sizeDelta = new Vector2(y: _setting.ReducedPadding ? _shortPadding : _normalPadding, x: obj.sizeDelta.x);
			_label.Set(_setting);
			SSGroupHeader setting2 = _setting;
			setting2.OnSettingUpdate = (Action)Delegate.Combine(setting2.OnSettingUpdate, new Action(SettingUpdated));
		}

		protected void OnDestroy()
		{
			if (_setting != null)
			{
				SSGroupHeader setting = _setting;
				setting.OnSettingUpdate = (Action)Delegate.Remove(setting.OnSettingUpdate, new Action(SettingUpdated));
			}
		}

		private void SettingUpdated()
		{
			_label.Set(_setting);
		}
	}
}
