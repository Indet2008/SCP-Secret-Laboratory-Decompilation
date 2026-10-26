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

		private Graphic _vigorGraphic;

		private StatSlider _vigorInstance;

		private void LateUpdate()
		{
			_sinkholeCooldown.Update();
			_attackCooldownElement.Update();
		}

		private void Update()
		{
			if (_vigorGraphic == null && _vigorInstance != null)
			{
				Slider componentInChildren = _vigorInstance.GetComponentInChildren<Slider>(includeInactive: true);
				if (componentInChildren != null && componentInChildren.fillRect != null)
				{
					_vigorGraphic = componentInChildren.fillRect.GetComponent<Graphic>();
				}
			}
			if (_vigorGraphic != null)
			{
				UpdateFlash(_vigorGraphic, _vigorFlashSw, _normalColor, ref _vigorIdleTime);
			}
			if (_cooldownFlasher != null)
			{
				UpdateFlash(_cooldownFlasher, _cooldownFlashSw, _normalColor, ref _cooldownIdleTime);
			}
		}

		private void UpdateFlash(Graphic targetGraphic, Stopwatch sw, Color normalColor, ref float idleTime)
		{
			Color color;
			if (sw.IsRunning && sw.Elapsed.TotalSeconds < (double)_flashDuration)
			{
				float f = Mathf.Sin((CurTime - idleTime) * _flashSpeed * MathF.PI);
				color = Color.Lerp(normalColor, Color.red, Mathf.Abs(f));
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
			_attackCooldownElement.Setup(_attackCooldown, null);
			_sinkholeCooldown.Setup(_sinkholeController.ReadonlyCooldown, null);
			_singleton = this;
			_singletonSet = true;
			if (hub.isLocalPlayer)
			{
				Scp106PortalShake.Register(_role, _role.FpcModule.CharacterModelInstance as Scp106Model);
			}
			if (hub.isLocalPlayer && StatSliderManager.TryAdd(_vigorSlider, out var instance))
			{
				instance.gameObject.SetActive(value: true);
				_vigorInstance = instance;
			}
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

		// Vignette that closes in while SCP-106 is submerged (amt 0..1).
		public static void SetDissolveAnimation(float amt)
		{
			if (_singletonSet && !(_singleton._vignetteVolume == null))
			{
				float num = Mathf.Clamp01(amt) * ((_singleton._maxVignette > 0f) ? Mathf.Min(_singleton._maxVignette, 1f) : 1f);
				_singleton._vignetteVolume.weight = num;
				_singleton._vignetteVolume.enabled = num > 0f;
			}
		}
	}
}
