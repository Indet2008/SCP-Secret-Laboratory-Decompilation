using System.Collections.Generic;
using InventorySystem.Items.Pickups;
using InventorySystem.Items.ThrowableProjectiles;
using UnityEngine;

namespace PlayerRoles.PlayableScps.Scp939.Ripples
{
	public class GrenadeRippleTrigger : RippleTriggerBase
	{
		private class ThrownGrenadeHandler
		{
			private readonly GrenadeRippleTrigger _tr;

			private readonly float _startTime;

			private int _nextTime;

			public ThrownGrenadeHandler(GrenadeRippleTrigger trigger)
			{
				_tr = trigger;
				_startTime = Time.timeSinceLevelLoad;
			}

			public bool UpdateSound()
			{
				if (_nextTime >= _tr._rippleTimes.Length)
				{
					return false;
				}
				float num = Time.timeSinceLevelLoad - _startTime;
				if (_tr._rippleTimes[_nextTime] > num)
				{
					return false;
				}
				_nextTime++;
				while (UpdateSound())
				{
				}
				return true;
			}
		}

		[SerializeField]
		private float[] _rippleTimes;

		[SerializeField]
		private float _audibleRangeSqr;

		private readonly Dictionary<ThrownProjectile, ThrownGrenadeHandler> _trackedGrenades = new Dictionary<ThrownProjectile, ThrownGrenadeHandler>();

		public override void SpawnObject()
		{
			base.SpawnObject();
			ThrownProjectile.OnProjectileSpawned += OnProjectileSpawned;
			ItemPickupBase.OnPickupDestroyed += OnPickupDestroyed;
		}

		public override void ResetObject()
		{
			base.ResetObject();
			ThrownProjectile.OnProjectileSpawned -= OnProjectileSpawned;
			ItemPickupBase.OnPickupDestroyed -= OnPickupDestroyed;
		}

		private void OnProjectileSpawned(ThrownProjectile tp)
		{
			if (tp.Info.ItemId == ItemType.GrenadeHE)
			{
				_trackedGrenades.Add(tp, new ThrownGrenadeHandler(this));
			}
		}

		private void OnPickupDestroyed(ItemPickupBase ipb)
		{
			if (ipb is ThrownProjectile key)
			{
				_trackedGrenades.Remove(key);
			}
		}

		private void Update()
		{
			if (!base.IsLocalOrSpectated)
			{
				return;
			}
			foreach (KeyValuePair<ThrownProjectile, ThrownGrenadeHandler> trackedGrenade in _trackedGrenades)
			{
				if (trackedGrenade.Value.UpdateSound())
				{
					PlayInRangeSqr(trackedGrenade.Key.Position, _audibleRangeSqr, Color.red);
				}
			}
		}
	}
}
