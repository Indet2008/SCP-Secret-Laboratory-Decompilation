using System;

namespace RemoteAdmin.Generic
{
	[Serializable]
	public abstract class EnumSetting<T> : RaSetting<T> where T : struct, Enum
	{
		protected override void OnSave()
		{
			PlayerPrefsSl.Set(Path, Convert.ToInt32(Value));
		}

		protected override void OnLoad()
		{
			int value = PlayerPrefsSl.Get(Path, Convert.ToInt32(DefaultValue));
			Value = (T)Enum.ToObject(typeof(T), value);
		}
	}
}
