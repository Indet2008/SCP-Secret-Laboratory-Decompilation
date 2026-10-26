using UnityEngine;

namespace CameraShaking
{
	public class TrackerShake : IShakeEffect
	{
		private const float FadeoutTime = 0.1f;

		private readonly float _intensity;

		private readonly Transform _tracker;

		private readonly Quaternion _offset;

		private bool _isVisible;

		private float _remainingFade;

		private Quaternion _lastKnownRotation;

		public TrackerShake(Transform target, Vector3 offset, float intensity = 1f)
			: this(target, Quaternion.Euler(offset), intensity)
		{
		}

		public TrackerShake(Transform target, Quaternion offset, float intensity = 1f)
		{
			_tracker = target;
			_offset = offset;
			_intensity = intensity;
			_remainingFade = 0.1f;
			_isVisible = true;
		}

		public bool GetEffect(ReferenceHub ply, out ShakeEffectValues shakeValues)
		{
			if (_tracker == null || !_tracker.gameObject.activeInHierarchy)
			{
				_isVisible = false;
			}
			Quaternion quaternion;
			if (_isVisible)
			{
				quaternion = _tracker.localRotation * _offset;
				if (_intensity != 1f)
				{
					quaternion = Quaternion.LerpUnclamped(Quaternion.identity, quaternion, _intensity);
				}
				_lastKnownRotation = quaternion;
			}
			else
			{
				_remainingFade -= Time.deltaTime;
				quaternion = Quaternion.Lerp(Quaternion.identity, _lastKnownRotation, _remainingFade / 0.1f);
			}
			Vector3 eulerAngles = quaternion.eulerAngles;
			quaternion = Quaternion.Euler(0f - eulerAngles.x, eulerAngles.z, eulerAngles.y);
			shakeValues = new ShakeEffectValues(quaternion, Quaternion.Inverse(quaternion));
			return _remainingFade > 0f;
		}
	}
}
