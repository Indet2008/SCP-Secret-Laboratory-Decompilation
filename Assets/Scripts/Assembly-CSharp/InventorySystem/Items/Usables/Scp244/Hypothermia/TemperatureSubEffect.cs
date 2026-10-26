using CustomPlayerEffects;
using PlayerRoles;
using UnityEngine;

namespace InventorySystem.Items.Usables.Scp244.Hypothermia
{
	public class TemperatureSubEffect : HypothermiaSubEffectBase
	{
		[SerializeField]
		private float _maxExitTemp;

		[SerializeField]
		private float _temperatureDrop;

		public float CurTemperature { get; private set; }

		public override bool IsActive => CurTemperature > 0f;

		internal override void UpdateEffect(float curExposure)
		{
			if (!base.Hub.IsAlive())
			{
				DisableEffect();
			}
			else if (curExposure == 0f)
			{
				if (CurTemperature != 0f)
				{
					float value = CurTemperature - _temperatureDrop * Time.deltaTime;
					CurTemperature = Mathf.Clamp(value, 0f, _maxExitTemp);
				}
			}
			else
			{
				CurTemperature += curExposure * RainbowTaste.CurrentMultiplier(base.Hub) * Time.deltaTime;
			}
		}

		public override void DisableEffect()
		{
			CurTemperature = 0f;
		}
	}
}
