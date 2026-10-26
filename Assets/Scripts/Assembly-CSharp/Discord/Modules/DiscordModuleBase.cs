namespace Discord.Modules
{
	public abstract class DiscordModuleBase : global::UnityEngine.MonoBehaviour
	{
		[global::UnityEngine.SerializeField]
		private bool _isEnabled;

		public virtual bool IsEnabled
		{
			get
			{
				return default;
			}
			set
			{
			}
		}

		public void UpdateModule()
		{
		}

		protected virtual void OnUpdateModule()
		{
		}

		protected virtual void OnDestroy()
		{
		}

		protected DiscordModuleBase()
		{
		}
	}
}
