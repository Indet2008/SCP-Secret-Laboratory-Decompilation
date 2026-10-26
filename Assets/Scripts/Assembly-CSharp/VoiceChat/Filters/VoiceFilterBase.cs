using CustomPlayerEffects;
using GameObjectPools;
using PlayerRoles;
using UnityEngine;

namespace VoiceChat.Filters
{
	public abstract class VoiceFilterBase<T> : MonoBehaviour, IPoolResettable where T : StatusEffectBase
	{
		private byte? _lastSetIntensity;

		protected PlayerRoleBase Role { get; private set; }

		private void Start()
		{
			Role = GetComponentInParent<PlayerRoleBase>();
			StatusEffectBase.OnIntensityChanged += OnIntensityChanged;
		}

		private void OnDestroy()
		{
			StatusEffectBase.OnIntensityChanged -= OnIntensityChanged;
		}

		private void OnIntensityChanged(StatusEffectBase effect, byte oldIntensity, byte newIntensity)
		{
			if (Role.TryGetOwner(out var hub) && effect is T && (object)hub == effect.Hub)
			{
				SetFilters(oldIntensity, newIntensity);
				_lastSetIntensity = newIntensity;
			}
		}

		protected abstract void SetFilters(byte oldIntensity, byte newIntensity);

		public void ResetObject()
		{
			if (_lastSetIntensity.HasValue && _lastSetIntensity.Value > 0)
			{
				SetFilters(_lastSetIntensity.Value, 0);
				_lastSetIntensity = null;
			}
		}
	}
}
