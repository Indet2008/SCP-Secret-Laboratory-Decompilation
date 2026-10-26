using System;

namespace UserSettings
{
	public class CachedUserSetting<TCachedValue>
	{
		private TCachedValue _cachedValue;

		private ushort _enumType;

		private ushort _enumKey;

		private bool _wasEverSet;

		public TCachedValue Value
		{
			get
			{
				if (!_wasEverSet)
				{
					UpdateValue(UserSetting<TCachedValue>.Get(_enumType, _enumKey));
				}
				return _cachedValue;
			}
			set
			{
				UserSetting<TCachedValue>.Set(_enumType, _enumKey, value);
			}
		}

		public CachedUserSetting(Enum trackedEnum)
		{
			ushort stableTypeHash = SettingsKeyGenerator.GetStableTypeHash(trackedEnum.GetType());
			ushort trackedEnumKey = ((IConvertible)trackedEnum).ToUInt16((IFormatProvider)null);
			Setup(stableTypeHash, trackedEnumKey);
		}

		public CachedUserSetting(ushort trackedEnumType, ushort trackedEnumKey)
		{
			Setup(trackedEnumType, trackedEnumKey);
		}

		private void Setup(ushort trackedEnumType, ushort trackedEnumKey)
		{
			_enumType = trackedEnumType;
			_enumKey = trackedEnumKey;
			UserSetting<TCachedValue>.AddListener(trackedEnumType, trackedEnumKey, UpdateValue);
		}

		public void Destroy()
		{
			UserSetting<TCachedValue>.RemoveListener(UpdateValue);
		}

		private void UpdateValue(TCachedValue val)
		{
			_cachedValue = val;
			_wasEverSet = true;
		}
	}
}
