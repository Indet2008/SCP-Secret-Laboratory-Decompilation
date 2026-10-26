using UnityEngine;

namespace CustomPlayerEffects
{
	public abstract class SubEffectBase : MonoBehaviour
	{
		protected StatusEffectBase MainEffect { get; private set; }

		protected ReferenceHub Hub => MainEffect.Hub;

		protected bool IsLocalPlayer => MainEffect.IsLocalPlayer;

		public virtual bool IsActive
		{
			get
			{
				if (base.gameObject.activeInHierarchy)
				{
					return MainEffect.IsEnabled;
				}
				return false;
			}
		}

		public virtual void DisableEffect()
		{
		}

		internal virtual void Init(StatusEffectBase mainEffect)
		{
			MainEffect = mainEffect;
		}

		internal virtual void UpdateEffect()
		{
		}
	}
}
