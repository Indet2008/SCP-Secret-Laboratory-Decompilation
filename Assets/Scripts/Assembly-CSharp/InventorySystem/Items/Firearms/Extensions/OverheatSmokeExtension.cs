using UnityEngine;

namespace InventorySystem.Items.Firearms.Extensions
{
	public class OverheatSmokeExtension : OverheatExtensionBase
	{
		[SerializeField]
		private float _temperatureThreshold;

		[SerializeField]
		private ParticleSystem _particleSystem;

		private bool _lastExceeded;

		public override void SetupAny()
		{
			base.SetupAny();
			UpdateParticleSystem(TemperatureTrackerModule.GetTemperature(base.Identifier), forceUpdate: true);
		}

		protected override void OnTemperatureChanged(float temp)
		{
			UpdateParticleSystem(temp, forceUpdate: false);
		}

		private void UpdateParticleSystem(float curTemp, bool forceUpdate)
		{
			bool flag = curTemp > _temperatureThreshold;
			if (_lastExceeded != flag || forceUpdate)
			{
				ParticleSystem.EmissionModule emission = _particleSystem.emission;
				emission.enabled = flag;
				_lastExceeded = flag;
			}
		}
	}
}
