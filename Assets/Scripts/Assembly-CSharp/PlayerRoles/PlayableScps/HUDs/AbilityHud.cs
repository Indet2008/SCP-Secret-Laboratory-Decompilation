using System;
using System.Diagnostics;
using PlayerRoles.Subroutines;
using UnityEngine;
using UnityEngine.UI;

namespace PlayerRoles.PlayableScps.HUDs
{
	[Serializable]
	public class AbilityHud
	{
		[Serializable]
		private class GraphicColor
		{
			public Color StartingColor;

			public Graphic Graphic;

			private GraphicColor(Graphic graphic)
			{
				Graphic = graphic;
				StartingColor = graphic.color;
			}
		}

		[SerializeField]
		private GameObject _parent;

		[SerializeField]
		private CanvasGroup _fader;

		[SerializeField]
		private Image _durationCircle;

		[SerializeField]
		private Image _cooldownCircle;

		[SerializeField]
		private bool _inverseDuration;

		[SerializeField]
		private bool _inverseCooldown;

		[SerializeField]
		private bool _showDurationAtCooldown;

		[SerializeField]
		private Vector3 _startScale = Vector3.one;

		[SerializeField]
		private float _flashDuration;

		[SerializeField]
		private float _flashSpeed;

		[SerializeField]
		private GraphicColor[] _graphics;

		private readonly Stopwatch _flashStopwatch = new Stopwatch();

		private float _flashIdleTime;

		private IAbilityCooldown _cooldown;

		private IAbilityCooldown _duration;

		private RectTransform _rt;

		private bool _hasDuration;

		private bool _hasFader;

		private readonly Stopwatch _fullStopwatch = new Stopwatch();

		private const float MinFullTime = 0.3f;

		private const float FadeSpeed = 8.5f;

		public void Setup(IAbilityCooldown cd, IAbilityCooldown duration)
		{
			_cooldown = cd;
			_duration = duration;
			_rt = _cooldownCircle.rectTransform;
			_hasDuration = _duration != null;
			_hasFader = _fader != null;
			bool flag = UpdateVisibility();
			if (_hasFader)
			{
				_fader.alpha = (flag ? 1 : 0);
			}
			else
			{
				_parent.SetActive(flag);
			}
		}

		public void Update(bool forceHidden = false)
		{
			bool flag = !forceHidden && UpdateVisibility();
			if (_hasFader)
			{
				_fader.alpha = Mathf.Clamp01(_fader.alpha + Time.deltaTime * (flag ? 8.5f : (-8.5f)));
			}
			else
			{
				_parent.SetActive(flag);
			}
		}

		private bool UpdateVisibility()
		{
			bool result = UpdateCooldown();
			if (_hasDuration && UpdateDuration())
			{
				result = true;
			}
			return result;
		}

		private bool UpdateCooldown()
		{
			float t = FillCircle(_cooldown, _cooldownCircle, _inverseCooldown);
			_rt.localScale = Vector3.Lerp(_startScale, Vector3.one, t);
			return !_cooldown.IsReady;
		}

		private bool UpdateDuration()
		{
			if (_duration.IsReady)
			{
				_durationCircle.enabled = false;
				if (_fullStopwatch.IsRunning)
				{
					return _fullStopwatch.Elapsed.TotalSeconds < 0.30000001192092896;
				}
				return false;
			}
			_durationCircle.enabled = _showDurationAtCooldown || _cooldown.IsReady;
			FillCircle(_duration, _durationCircle, !_inverseDuration);
			_fullStopwatch.Restart();
			return true;
		}

		private float FillCircle(IAbilityCooldown cd, Image circle, bool inverse)
		{
			float num = cd.Readiness;
			if (inverse)
			{
				num = 1f - num;
			}
			circle.fillAmount = num;
			return num;
		}

		public void LateUpdate()
		{
			_graphics.ForEach((GraphicColor x) =>
			{
				UpdateFlash(x.Graphic, _flashStopwatch, x.StartingColor, ref _flashIdleTime);
			});
		}

		public void FlashAbility()
		{
			_flashStopwatch.Restart();
		}

		private void UpdateFlash(Graphic targetGraphic, Stopwatch sw, Color normalColor, ref float idleTime)
		{
			Color color;
			if (sw.IsRunning && sw.Elapsed.TotalSeconds < (double)_flashDuration)
			{
				float f = Mathf.Sin((Time.timeSinceLevelLoad - idleTime) * _flashSpeed * MathF.PI);
				color = Color.Lerp(normalColor, Color.red, Mathf.Abs(f));
			}
			else
			{
				color = Color.Lerp(targetGraphic.color, normalColor, Time.deltaTime * _flashSpeed);
				idleTime = Time.timeSinceLevelLoad;
			}
			targetGraphic.color = new Color(color.r, color.g, color.b, targetGraphic.color.a);
		}
	}
}
