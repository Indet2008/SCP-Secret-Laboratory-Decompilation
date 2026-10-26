using CustomPlayerEffects;
using UnityEngine;

namespace InventorySystem.Items.Usables.Scp1344
{
	public class Scp1344XrayProviderBase : MonoBehaviour
	{
		private StatusEffectBase _statusEffect;

		public ReferenceHub Hub => _statusEffect.Hub;

		public virtual void OnInit(StatusEffectBase scp1344fx)
		{
			_statusEffect = scp1344fx;
		}

		public virtual void OnVisionEnabled()
		{
		}

		public virtual void OnVisionDisabled()
		{
		}

		public virtual void OnUpdate()
		{
		}
	}
}
