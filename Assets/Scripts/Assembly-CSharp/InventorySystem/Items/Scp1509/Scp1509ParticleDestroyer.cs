using Mirror;
using UnityEngine;

namespace InventorySystem.Items.Scp1509
{
	public class Scp1509ParticleDestroyer : MonoBehaviour
	{
		[SerializeField]
		private float _timeTillDeath;

		[SerializeField]
		private float _timeTillParticleStop;

		[SerializeField]
		private ParticleSystem _particleSystem;

		private float _timer;

		private void Update()
		{
			if (NetworkServer.active)
			{
				Object.Destroy(base.gameObject);
				return;
			}
			_timer += Time.deltaTime;
			if (_timeTillParticleStop <= _timer)
			{
				_particleSystem.Stop();
			}
			if (!(_timeTillDeath > _timer))
			{
				Object.Destroy(base.gameObject);
			}
		}
	}
}
