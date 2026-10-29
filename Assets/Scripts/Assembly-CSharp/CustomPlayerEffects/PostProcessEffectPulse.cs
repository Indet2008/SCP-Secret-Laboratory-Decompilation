using UnityEngine;
using UnityEngine.Rendering;
using UnityEngine.Serialization;

namespace CustomPlayerEffects
{
	public abstract class PostProcessEffectPulse : MonoBehaviour
	{
		[SerializeField]
		[FormerlySerializedAs("PulseIntensity")]
		private float _pulseIntensity = 1f;

		public float animationSpeedMultiplier = 1f;

		private float _defaultIntensity;

		private float timer;

		private AnimationCurve pulseAnimation = new AnimationCurve();

		public float PulseIntensity
		{
			get
			{
				return _pulseIntensity;
			}
			set
			{
				_pulseIntensity = value;
				UpdateAnimationCurve();
			}
		}

		protected abstract float EffectValue { get; set; }

		protected abstract void SetEffectType(VolumeProfile profile);

		public void Pulse()
		{
			base.enabled = true;
		}

		private void Awake()
		{
			SetEffectType(GetComponent<Volume>().profile);
			_defaultIntensity = EffectValue;
			UpdateAnimationCurve();
			EffectValue = _defaultIntensity;
			base.enabled = false;
			timer = 0f;
		}

		private void UpdateAnimationCurve()
		{
			pulseAnimation.keys = new Keyframe[3]
			{
				new Keyframe(0f, _defaultIntensity),
				new Keyframe(0.5f, _pulseIntensity),
				new Keyframe(1f, _defaultIntensity)
			};
		}

		private void Update()
		{
			if (timer >= 1f)
			{
				EffectValue = _defaultIntensity;
				base.enabled = false;
				timer = 0f;
			}
			else
			{
				timer += Time.deltaTime * animationSpeedMultiplier;
				EffectValue = pulseAnimation.Evaluate(timer);
			}
		}

		private void Reset()
		{
			EffectValue = _defaultIntensity;
			base.enabled = false;
			timer = 0f;
		}
	}
}
