using UnityEngine;

namespace InventorySystem.Items.Firearms.Modules.Misc
{
	public class FullAutoRateLimiter
	{
		private bool _lastWasReady;

		private float _remainingCooldown;

		public bool Ready => _remainingCooldown <= 0f;

		public void Update()
		{
			if (Ready)
			{
				_lastWasReady = true;
				return;
			}
			_lastWasReady = false;
			_remainingCooldown -= Time.deltaTime;
		}

		public void Clear()
		{
			_remainingCooldown = 0f;
			_lastWasReady = true;
		}

		public void Trigger(float cooldown)
		{
			if (_lastWasReady)
			{
				_remainingCooldown = cooldown;
			}
			else
			{
				_remainingCooldown += cooldown;
			}
		}
	}
}
