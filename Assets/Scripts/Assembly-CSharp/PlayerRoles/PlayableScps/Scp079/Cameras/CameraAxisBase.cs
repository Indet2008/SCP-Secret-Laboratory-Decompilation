using MapGeneration.StaticHelpers;
using PlayerRoles.Spectating;
using UnityEngine;

namespace PlayerRoles.PlayableScps.Scp079.Cameras
{
	public abstract class CameraAxisBase : IBlockStaticBatching
	{
		private float _val;

		private bool _wasEverSet;

		private bool _wasMoving;

		private const float LocalPlayerLerpMultiplier = 1f;

		private const float LocalPlayerPitchMultiplier = 1f;

		private const float LocalPlayerVolumeMultiplier = 0.4f;

		[SerializeField]
		private float _soundLerpSpeed;

		[SerializeField]
		private float _soundStopSpeed;

		[SerializeField]
		private float _localPlayerDiffLimiter;

		[SerializeField]
		private Vector2 _constraints;

		[SerializeField]
		protected AudioSource SoundEffectSource;

		[SerializeField]
		protected AnimationCurve SpeedCurve;

		[SerializeField]
		protected AnimationCurve VolumeCurve;

		[SerializeField]
		protected AnimationCurve PitchCurve;

		private bool IsFirstperson => Scp079Role.LocalInstanceActive;

		private bool IsSpectating
		{
			get
			{
				if (!SpectatorTargetTracker.TrackerSet)
				{
					return false;
				}
				if (SpectatorTargetTracker.CurrentTarget is Scp079SpectatableModule scp079SpectatableModule && scp079SpectatableModule != null)
				{
					return !scp079SpectatableModule.MainRole.Pooled;
				}
				return false;
			}
		}

		protected virtual float SpectatorLerpMultiplier => 0f;

		public float CurValue { get; internal set; }

		public float MinValue => _constraints.x;

		public float MaxValue => _constraints.y;

		public float TargetValue
		{
			get
			{
				return _val;
			}
			set
			{
				_val = Mathf.Clamp(value % 360f, _constraints.x, _constraints.y);
				if (!_wasEverSet)
				{
					CurValue = _val;
					_wasEverSet = true;
					_wasMoving = true;
					OnValueChanged(_val, null);
				}
			}
		}

		public ushort Value16BitCompression
		{
			get
			{
				return (ushort)Compress(_constraints, TargetValue, 65535);
			}
			set
			{
				TargetValue = Uncompress(_constraints, (int)value, 65535);
			}
		}

		public byte Value8BitCompression
		{
			get
			{
				return (byte)Compress(_constraints, TargetValue, 255);
			}
			set
			{
				TargetValue = Uncompress(_constraints, (int)value, 255);
			}
		}

		public Vector2 Constraints
		{
			get
			{
				return _constraints;
			}
			set
			{
				_constraints = value;
			}
		}

		internal virtual void Update(Scp079Camera cam)
		{
			if (CurValue == TargetValue)
			{
				if (_wasMoving)
				{
					float num = SoundEffectSource.volume - _soundStopSpeed * Time.deltaTime;
					if (num <= 0f)
					{
						SoundEffectSource.Stop();
						_wasMoving = false;
					}
					SoundEffectSource.volume = Mathf.Clamp01(num);
				}
				return;
			}
			float time = Mathf.Abs(CurValue - TargetValue);
			bool isFirstperson = IsFirstperson;
			bool isSpectating = IsSpectating;
			float num2 = SpeedCurve.Evaluate(time);
			float num3 = VolumeCurve.Evaluate(time);
			float num4 = PitchCurve.Evaluate(time);
			float num5 = ((_soundLerpSpeed == 0f) ? 1f : (_soundLerpSpeed * Time.deltaTime));
			if (isFirstperson | isSpectating)
			{
				num3 *= 0.4f;
				num4 *= 1f;
				num5 *= 1f;
			}
			if (!_wasMoving)
			{
				SoundEffectSource.Play();
				_wasMoving = true;
			}
			if (isFirstperson)
			{
				CurValue = Mathf.Clamp(CurValue, TargetValue - _localPlayerDiffLimiter, TargetValue + _localPlayerDiffLimiter);
			}
			else if (isSpectating)
			{
				CurValue = Mathf.Lerp(CurValue, TargetValue, Time.deltaTime * SpectatorLerpMultiplier);
			}
			num2 *= Time.deltaTime;
			CurValue = ((_constraints.x == -360f || _constraints.y == 360f) ? Mathf.MoveTowardsAngle(CurValue, TargetValue, num2) : Mathf.MoveTowards(CurValue, TargetValue, num2));
			SoundEffectSource.volume = Mathf.Lerp(SoundEffectSource.volume, num3, num5);
			SoundEffectSource.pitch = Mathf.Lerp(SoundEffectSource.pitch, num4, num5);
			OnValueChanged(CurValue, cam);
		}

		internal virtual void Awake(Scp079Camera cam)
		{
			_wasEverSet = false;
		}

		protected abstract void OnValueChanged(float newValue, Scp079Camera cam);

		private int Compress(Vector2 constraints, float val, int maxVal)
		{
			return Mathf.RoundToInt(Mathf.InverseLerp(constraints.x, constraints.y, val) * (float)maxVal);
		}

		private float Uncompress(Vector2 constraints, float val, int maxVal)
		{
			return Mathf.Lerp(constraints.x, constraints.y, val / (float)maxVal);
		}
	}
}
