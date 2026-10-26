using System;
using InventorySystem.Items;
using MapGeneration.Holidays;
using Mirror;
using PlayerRoles;
using PlayerRoles.FirstPersonControl;
using PlayerRoles.FirstPersonControl.Thirdperson;
using PlayerRoles.PlayableScps;
using UnityEngine;

namespace CustomPlayerEffects
{
	public class OrangeCandy : StatusEffectBase, ISoundtrackMutingEffect, IHolidayEffect
	{
		private const float Radius = 0.3f;

		private const float MaxRange = 60f;

		private const float MinimumFlashDistance = 4.4f;

		private const float PersistanceModifier = 1.15f;

		private const float FlashPersistanceModifier = 1.0333333f;

		[SerializeField]
		private AudioSource _effectSource;

		[SerializeField]
		private Light _lightSource;

		[SerializeField]
		private AnimationCurve _lightCurve;

		[SerializeField]
		private Material _litMaterial;

		private ModelVisualEffect _effectHandler;

		private float _elapsed;

		private float _maxElapsed;

		public bool MuteSoundtrack => base.IsEnabled;

		public override EffectClassification Classification => EffectClassification.Positive;

		public HolidayType[] TargetHolidays { get; } = new HolidayType[1] { HolidayType.Halloween };

		protected override void Awake()
		{
			base.Awake();
			_maxElapsed = _lightCurve.keys[_lightCurve.length - 1].time;
			SharedHandsController.OnHandsSet = (Action<SharedHandsController.HandsVisuals>)Delegate.Combine(SharedHandsController.OnHandsSet, new Action<SharedHandsController.HandsVisuals>(OnHandsSet));
			SharedHandsController.OnHandsReset = (Action<SharedHandsController.HandsVisuals>)Delegate.Combine(SharedHandsController.OnHandsReset, new Action<SharedHandsController.HandsVisuals>(OnHandsReset));
		}

		private void OnDestroy()
		{
			SharedHandsController.OnHandsSet = (Action<SharedHandsController.HandsVisuals>)Delegate.Remove(SharedHandsController.OnHandsSet, new Action<SharedHandsController.HandsVisuals>(OnHandsSet));
			SharedHandsController.OnHandsReset = (Action<SharedHandsController.HandsVisuals>)Delegate.Remove(SharedHandsController.OnHandsReset, new Action<SharedHandsController.HandsVisuals>(OnHandsReset));
		}

		private void OnHandsSet(SharedHandsController.HandsVisuals visuals)
		{
			if (base.IsEnabled && ReferenceHub.TryGetPovHub(out var hub) && !(hub != base.Hub))
			{
				SetOrangeHands(status: true);
			}
		}

		private void OnHandsReset(SharedHandsController.HandsVisuals visuals)
		{
			if (base.IsEnabled && ReferenceHub.TryGetPovHub(out var hub) && !(hub != base.Hub))
			{
				SetOrangeHands(status: false);
			}
		}

		protected override void Enabled()
		{
			if (NetworkServer.active)
			{
				base.Hub.playerEffectsController.DisableEffect<WhiteCandy>();
				base.Hub.playerEffectsController.DisableEffect<Metal>();
			}
			_elapsed = 0f;
			_effectSource.Play();
			_effectHandler = new ModelVisualEffect(base.Hub.GetModel(), _litMaterial);
			if (SharedHandsController.Singleton.LastHandVisuals.HasValue)
			{
				OnHandsSet(SharedHandsController.Singleton.LastHandVisuals.Value);
			}
		}

		protected override void IntensityChanged(byte prevState, byte newState)
		{
			base.IntensityChanged(prevState, newState);
			if (base.IsLocalPlayer || base.IsSpectated)
			{
				SetOrangeHands(newState != 0);
			}
		}

		public override void OnBeginSpectating()
		{
			base.OnBeginSpectating();
			SetOrangeHands(base.IsEnabled);
		}

		public override void OnStopSpectating()
		{
			base.OnStopSpectating();
			SetOrangeHands(status: false);
		}

		private void SetOrangeHands(bool status)
		{
			if (SharedHandsController.Singleton.LastHandVisuals.HasValue)
			{
				SharedHandsController.HandsVisuals value = SharedHandsController.Singleton.LastHandVisuals.Value;
				if (status)
				{
					value.SetOverrideTexture(_litMaterial);
				}
				else
				{
					value.SetDefaultTextures();
				}
			}
		}

		protected override void Update()
		{
			base.Update();
			UpdateBlindingEffect();
			if (base.IsEnabled || _elapsed != 0f)
			{
				if (base.IsEnabled)
				{
					_elapsed += Time.deltaTime;
				}
				else
				{
					_elapsed -= Time.deltaTime;
				}
				_elapsed = Mathf.Clamp(_elapsed, 0f, _maxElapsed);
				_lightSource.enabled = _elapsed > 0f;
				_lightSource.intensity = _lightCurve.Evaluate(_elapsed);
			}
		}

		protected override void Disabled()
		{
			_effectSource.Stop();
			_effectHandler?.Restore();
		}

		private void UpdateBlindingEffect()
		{
			if (!base.IsEnabled || !(base.Hub.roleManager.CurrentRole is IFpcRole fpcRole))
			{
				return;
			}
			Vector3 position = fpcRole.FpcModule.Position;
			foreach (ReferenceHub allHub in ReferenceHub.AllHubs)
			{
				if (!(base.Hub == allHub) && HitboxIdentity.IsEnemy(base.Hub, allHub) && allHub.roleManager.CurrentRole is IFpcRole fpcRole2 && VisionInformation.GetVisionInformation(allHub, allHub.PlayerCameraReference, position, 0.3f, 60f, checkFog: true, checkLineOfSight: true, 0, checkInDarkness: false).IsLooking)
				{
					allHub.playerEffectsController.EnableEffect<OrangeWitness>(Time.deltaTime * 1.15f, addDuration: true);
					if (!(Vector3.Distance(fpcRole2.FpcModule.Position, position) > 4.4f))
					{
						allHub.playerEffectsController.EnableEffect<Flashed>(Time.deltaTime * 1.0333333f, addDuration: true);
					}
				}
			}
		}
	}
}
