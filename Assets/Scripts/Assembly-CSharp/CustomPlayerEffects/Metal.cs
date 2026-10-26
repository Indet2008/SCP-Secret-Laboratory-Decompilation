using System;
using AudioPooling;
using InventorySystem;
using InventorySystem.Items;
using MapGeneration.Holidays;
using Mirror;
using PlayerRoles;
using PlayerRoles.FirstPersonControl;
using PlayerRoles.FirstPersonControl.Thirdperson;
using PlayerStatsSystem;
using UnityEngine;

namespace CustomPlayerEffects
{
	public class Metal : StatusEffectBase, IMovementSpeedModifier, IUsableItemModifierEffect, ICustomHitSfxEffect, IDamageModifierEffect, IFootstepEffect, IHolidayEffect, ICustomFallSfxEffect, IPulseEffect
	{
		private const float GravityMultiplier = 4f;

		private const float AllDamageMultiplier = 0.2f;

		private const float FallDamageMultiplier = 0.05f;

		private const float AreaDamageSqrDistance = 4f;

		private const float AreaDamageMultiplier = 0.4f;

		private const int BaseFallDamage = 80;

		private const float MaxShakeAmount = 0.35f;

		private const float MaxShakeDistanceSqr = 16f;

		private const float MinFallDamageAllowed = 35f;

		[SerializeField]
		private Material _metalMaterial;

		[SerializeField]
		private Material _metaFirstPersonMaterial;

		[SerializeField]
		private AudioSource _ambienceSource;

		[SerializeField]
		private AudioClip[] _onHitSfx;

		[SerializeField]
		private AudioClip[] _effectThemes;

		[SerializeField]
		private AudioClip[] _footstepSounds;

		[SerializeField]
		private float _originalLoudness;

		private ModelVisualEffect _modelEffect;

		private FpcGravityController _prevController;

		private Vector3 _normalGravity;

		private Vector3 _fallGravity;

		public float MovementSpeedLimit
		{
			get
			{
				UpdateGravity();
				return float.MaxValue;
			}
		}

		public override EffectClassification Classification => EffectClassification.Mixed;

		public bool MovementModifierActive => base.IsEnabled;

		public float MovementSpeedMultiplier => 0.75f;

		public bool DamageModifierActive => base.IsEnabled;

		public HolidayType[] TargetHolidays { get; } = new HolidayType[1] { HolidayType.Halloween };

		public AudioClip HitSfx => _onHitSfx.RandomItem();

		[field: SerializeField]
		public AudioClip FallSfxClip { get; private set; }

		[field: SerializeField]
		[field: Range(0f, 1f)]
		public float FallSfxVolume { get; private set; } = 1f;

		private void UpdateGravity()
		{
			if ((base.IsLocalPlayer || NetworkServer.active) && _prevController != null)
			{
				Vector3 vector = ((_prevController.Motor.Velocity.y < 0f) ? _fallGravity : _normalGravity);
				if (!(_prevController.Gravity == vector))
				{
					_prevController.Gravity = vector;
				}
			}
		}

		protected override void Enabled()
		{
			base.Enabled();
			if (NetworkServer.active)
			{
				base.Hub.playerEffectsController.DisableEffect<WhiteCandy>();
				base.Hub.playerEffectsController.DisableEffect<OrangeCandy>();
			}
			_modelEffect = new ModelVisualEffect(base.Hub.GetModel(), _metalMaterial);
			_ambienceSource.clip = _effectThemes[UnityEngine.Random.Range(0, _effectThemes.Length)];
			_ambienceSource.Play();
			if (base.IsLocalPlayer || NetworkServer.active)
			{
				if (base.Hub.roleManager.CurrentRole is IFpcRole fpcRole)
				{
					_prevController = fpcRole.FpcModule.Motor.GravityController;
					_normalGravity = _prevController.Gravity;
					_fallGravity = _normalGravity * 4f;
				}
				else
				{
					_prevController = null;
				}
			}
		}

		protected override void Disabled()
		{
			base.Disabled();
			_ambienceSource.Stop();
			_modelEffect?.Restore();
			if ((base.IsLocalPlayer || NetworkServer.active) && _prevController != null)
			{
				_prevController.Gravity = _normalGravity;
				_prevController = null;
			}
		}

		protected override void IntensityChanged(byte prevState, byte newState)
		{
			base.IntensityChanged(prevState, newState);
			if (base.IsLocalPlayer || base.IsSpectated)
			{
				SetMetalHands(newState != 0);
			}
		}

		public override void OnBeginSpectating()
		{
			base.OnBeginSpectating();
			SetMetalHands(base.IsEnabled);
		}

		public override void OnStopSpectating()
		{
			base.OnStopSpectating();
			SetMetalHands(status: false);
		}

		protected override void Awake()
		{
			base.Awake();
			SharedHandsController.OnHandsSet = (Action<SharedHandsController.HandsVisuals>)Delegate.Combine(SharedHandsController.OnHandsSet, new Action<SharedHandsController.HandsVisuals>(OnHandsSet));
			SharedHandsController.OnHandsReset = (Action<SharedHandsController.HandsVisuals>)Delegate.Combine(SharedHandsController.OnHandsReset, new Action<SharedHandsController.HandsVisuals>(OnHandsReset));
		}

		private void OnDestroy()
		{
			SharedHandsController.OnHandsSet = (Action<SharedHandsController.HandsVisuals>)Delegate.Remove(SharedHandsController.OnHandsSet, new Action<SharedHandsController.HandsVisuals>(OnHandsSet));
			SharedHandsController.OnHandsReset = (Action<SharedHandsController.HandsVisuals>)Delegate.Remove(SharedHandsController.OnHandsReset, new Action<SharedHandsController.HandsVisuals>(OnHandsReset));
		}

		private void OnHandsReset(SharedHandsController.HandsVisuals visuals)
		{
			if (base.IsEnabled && ReferenceHub.TryGetPovHub(out var hub) && !(hub != base.Hub))
			{
				SetMetalHands(status: false);
			}
		}

		private void OnHandsSet(SharedHandsController.HandsVisuals visuals)
		{
			if (base.IsEnabled && ReferenceHub.TryGetPovHub(out var hub) && !(hub != base.Hub))
			{
				SetMetalHands(status: true);
			}
		}

		private void SetMetalHands(bool status)
		{
			if (SharedHandsController.Singleton.LastHandVisuals.HasValue)
			{
				SharedHandsController.HandsVisuals value = SharedHandsController.Singleton.LastHandVisuals.Value;
				if (status)
				{
					value.SetOverrideTexture(_metaFirstPersonMaterial);
				}
				else
				{
					value.SetDefaultTextures();
				}
			}
		}

		public bool TryGetSpeed(ItemType item, out float speed)
		{
			if (!InventoryItemLoader.AvailableItems.TryGetValue(item, out var value))
			{
				speed = 1f;
				return false;
			}
			if (value.Category != ItemCategory.Medical)
			{
				speed = 1f;
				return false;
			}
			speed = 0.5f;
			return true;
		}

		public float GetDamageModifier(float baseDamage, DamageHandlerBase handler, HitboxType hitboxType)
		{
			StandardDamageHandler standardDamageHandler;
			if (!(handler is UniversalDamageHandler universalDamageHandler))
			{
				standardDamageHandler = handler as StandardDamageHandler;
				if (standardDamageHandler == null)
				{
					goto IL_0052;
				}
			}
			else
			{
				if (universalDamageHandler.TranslationId == DeathTranslations.Falldown.Id)
				{
					return ProcessFallDamage(baseDamage);
				}
				standardDamageHandler = (StandardDamageHandler)handler;
			}
			if (standardDamageHandler.Damage == -1f)
			{
				return 1f;
			}
			goto IL_0052;
			IL_0052:
			return 0.2f;
		}

		public float ProcessFootstepOverrides(AnimatedCharacterModel _, float dis)
		{
			AudioSourcePoolManager.PlayOnTransform(_footstepSounds.RandomItem(), base.transform, dis);
			return _originalLoudness;
		}

		public void ExecutePulse()
		{
			if (ReferenceHub.TryGetLocalHub(out var hub) && hub.roleManager.CurrentRole is IFpcRole target)
			{
				float t = Mathf.Clamp01(target.SqrDistanceTo(base.Hub) / 16f);
				float explosionForce = Mathf.Lerp(0.35f, 0f, t);
				ExplosionCameraShake.singleton.Shake(explosionForce);
			}
		}

		private float ProcessFallDamage(float baseDamage)
		{
			if (baseDamage < 35f)
			{
				return 0f;
			}
			OnServerProcessFall(baseDamage);
			return 0.05f;
		}

		private void OnServerProcessFall(float damage)
		{
			float damage2 = 80f + damage * 0.4f;
			foreach (ReferenceHub allHub in ReferenceHub.AllHubs)
			{
				if (!(allHub == base.Hub) && allHub.roleManager.CurrentRole is IFpcRole target && !(target.SqrDistanceTo(base.Hub) > 4f) && allHub.playerStats.DealDamage(new GrayCandyDamageHandler(base.Hub, damage2)))
				{
					allHub.playerEffectsController.ServerSendPulse<Metal>();
					Hitmarker.SendHitmarkerDirectly(base.Hub, 1f);
				}
			}
			base.Hub.playerEffectsController.ServerSendPulse<Metal>();
		}
	}
}
