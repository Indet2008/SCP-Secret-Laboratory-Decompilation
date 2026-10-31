using UnityEngine;

namespace Discord.Modules
{
	public abstract class DiscordModuleBase : MonoBehaviour
	{
		[SerializeField]
		private bool _isEnabled;

		public virtual bool IsEnabled
		{
			get
			{
				return _isEnabled;
			}
			set
			{
				_isEnabled = value;
			}
		}

		public void UpdateModule()
		{
			if (IsEnabled)
			{
				OnUpdateModule();
			}
		}

		protected virtual void OnUpdateModule()
		{
		}

		protected virtual void OnDestroy()
		{
		}
	}
}
