using System;

namespace RemoteAdmin.Generic
{
	[Serializable]
	public abstract class RaSetting<T>
	{
		private T _value;

		public virtual T Value
		{
			get
			{
				return _value;
			}
			set
			{
				_value = value;
			}
		}

		public virtual T DefaultValue { get; }

		public abstract string Path { get; }

		public void Load()
		{
			OnLoad();
		}

		public void Save()
		{
			OnSave();
		}

		public virtual void Reset()
		{
			Value = DefaultValue;
			Save();
		}

		protected abstract void OnLoad();

		protected abstract void OnSave();
	}
}
