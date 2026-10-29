using System;
using System.Diagnostics;
using Mirror;
using PlayerRoles.PlayableScps.HUDs;
using PlayerRoles.Subroutines;
using PlayerStatsSystem;
using UnityEngine;
using UnityEngine.UI;

namespace PlayerRoles.PlayableScps.Scp106
{
	public class Scp106Hud : ScpHudBase
	{
		// Client-only serialized fields restored from the v14 client layout (server build stripped them).
		[global::UnityEngine.SerializeField]
		private global::UnityEngine.Rendering.Volume _vignetteVolume;

		[global::UnityEngine.SerializeField]
		private float _maxVignette;

		[global::UnityEngine.SerializeField]
		private global::PlayerStatsSystem.StatSlider _vigorSlider;


		private readonly Stopwatch _vigorFlashSw = new Stopwatch();

		private readonly Stopwatch _cooldownFlashSw = new Stopwatch();

		[SerializeField]
		private AbilityHud _sinkholeCooldown;

		[SerializeField]
		private Graphic _cooldownFlasher;

		[SerializeField]
		private AbilityHud _attackCooldownElement;

		[SerializeField]
		private Color _normalColor;

		[SerializeField]
		private float _flashSpeed;

		[SerializeField]
		private float _flashDuration;

		[SerializeField]
		private GameObject _diedRoot;

		private Scp106Role _role;

		private Scp106MovementModule _fpc;

		private Scp106SinkholeController _sinkholeController;

		private float _vigorIdleTime;

		private float _cooldownIdleTime;

		private readonly AbilityCooldown _attackCooldown = new AbilityCooldown();

		private static Scp106Hud _singleton;

		private static bool _singletonSet;

		private static float CurTime => Time.timeSinceLevelLoad;

		private UnityEngine.Rendering.HighDefinition.Vignette _vignette;

		private CustomRendering.ScreenDissolve _dissolve;

		private Graphic[] _vigorGraphics;

		private StatSlider _vigorInstance;

		private void LateUpdate()
		{
			if (_vignette != null)
			{
				_vignette.intensity.value = _fpc.CurSlowdown * _maxVignette;
			}
			UpdateFlash(_cooldownFlasher, _cooldownFlashSw, Color.white, ref _cooldownIdleTime);
			if (_vigorGraphics != null)
			{
				foreach (Graphic graphic in _vigorGraphics)
				{
					UpdateFlash(graphic, _vigorFlashSw, _normalColor, ref _vigorIdleTime);
				}
			}
			_sinkholeCooldown.Update();
			_attackCooldownElement.Update();
		}

		private void UpdateFlash(Graphic targetGraphic, Stopwatch sw, Color normalColor, ref float idleTime)
		{
			Color color;
			if (sw.IsRunning && (double)_flashDuration > sw.Elapsed.TotalSeconds)
			{
				float t = Mathf.Abs(Mathf.Sin((CurTime - idleTime) * _flashSpeed * MathF.PI));
				color = Color.Lerp(normalColor, Color.red, t);
			}
			else
			{
				color = Color.Lerp(targetGraphic.color, normalColor, Time.deltaTime * _flashSpeed);
				idleTime = CurTime;
			}
			targetGraphic.color = new Color(color.r, color.g, color.b, targetGraphic.color.a);
		}

		protected override void OnDestroy()
		{
			base.OnDestroy();
			if (_vigorInstance != null)
			{
				StatSliderManager.TryRemove<VigorStat>();
				_vigorInstance = null;
			}
			if (!(this != _singleton))
			{
				_singletonSet = false;
			}
		}

		internal override void OnDied()
		{
			base.enabled = false;
			_diedRoot.SetActive(value: false);
		}

		internal override void Init(ReferenceHub hub)
		{
			base.Init(hub);
			_role = hub.roleManager.CurrentRole as Scp106Role;
			_fpc = _role.FpcModule as Scp106MovementModule;
			_role.SubroutineModule.TryGetSubroutine<Scp106SinkholeController>(out _sinkholeController);
			UnityEngine.Rendering.VolumeProfile profile = _vignetteVolume.profile;
			profile.TryGet<UnityEngine.Rendering.HighDefinition.Vignette>(out _vignette);
			profile.TryGet<CustomRendering.ScreenDissolve>(out _dissolve);
			if (StatSliderManager.TryAdd(_vigorSlider, out var instance))
			{
				instance.gameObject.SetActive(value: true);
				_vigorInstance = instance;
				_vigorGraphics = instance.gameObject.GetComponentsInChildren<Graphic>(includeInactive: true);
			}
			_attackCooldownElement.Setup(_attackCooldown, null);
			_sinkholeCooldown.Setup(_sinkholeController.ReadonlyCooldown, null);
			_singleton = this;
			_singletonSet = true;
		}

		public static void PlayCooldownAnimation(double nextTime)
		{
			if (_singletonSet)
			{
				float num = (float)(nextTime - NetworkTime.time);
				_singleton._attackCooldown.Trigger(num);
			}
		}

		public static void PlayFlash(bool vigor)
		{
			if (_singletonSet)
			{
				(vigor ? _singleton._vigorFlashSw : _singleton._cooldownFlashSw).Restart();
			}
		}

		// Screen dissolve while SCP-106 submerges/emerges (amt 0..1).
		public static void SetDissolveAnimation(float amt)
		{
			if (_singletonSet && _singleton._dissolve != null)
			{
				_singleton._dissolve.DissolveAmount.value = Mathf.Clamp01(amt);
			}
		}
	}
}
