using AudioPooling;
using Hazards;
using MapGeneration.Holidays;
using Mirror;
using PlayerRoles.FirstPersonControl;
using PlayerRoles.PlayableScps.Scp939;
using PlayerStatsSystem;
using UnityEngine;

namespace CustomPlayerEffects
{
	public class Prismatic : TickingEffectBase, IDamageModifierEffect, IMovementSpeedModifier, ISoundtrackMutingEffect, IHolidayEffect
	{
		public struct BreakMessage : NetworkMessage
		{
			public Vector3 SoundPos;
		}

		private const float HealingPerTick = 5f;

		public static readonly float DeathSaveHealth = 1f;

		public static readonly float VitalitySpeedMultipler = 1f;

		public static readonly float HumanAHPEfficacy = 1f;

		public static readonly float TeslaImmunityTime = 2f;

		public static readonly float BreakSoundDistance = 25f;

		public static readonly float BreakVolumeModifier = 0.25f;

		public static readonly float DamageImmunityTime = 0.25f;

		[SerializeField]
		private AudioSource _ambienceSource;

		[SerializeField]
		private AudioClip _effectBreakSound;

		private float _lastSaveTime;

		private bool _isDamageModifierEnabled;

		private HealthStat _hpStat;

		public PrismaticCloud OriginCloud { get; set; }

		public override EffectClassification Classification => EffectClassification.Positive;

		public bool MuteSoundtrack => base.IsEnabled;

		public float MovementSpeedMultiplier => 1.05f;

		public bool MovementModifierActive => base.IsEnabled;

		public float MovementSpeedLimit => float.MaxValue;

		public bool DamageModifierActive
		{
			get
			{
				if (_isDamageModifierEnabled)
				{
					if (!base.IsEnabled)
					{
						return IsTeslaImmunityActive;
					}
					return true;
				}
				return false;
			}
		}

		public HolidayType[] TargetHolidays { get; } = new HolidayType[1] { HolidayType.Halloween };

		private bool IsTeslaImmunityActive => _lastSaveTime + TeslaImmunityTime >= Time.timeSinceLevelLoad;

		private bool IsImmunityActive => _lastSaveTime + DamageImmunityTime >= Time.timeSinceLevelLoad;

		public float GetDamageModifier(float baseDamage, DamageHandlerBase handler, HitboxType hitboxType)
		{
			UniversalDamageHandler universalDamageHandler = handler as UniversalDamageHandler;
			if (IsImmunityActive)
			{
				return 0f;
			}
			if (IsTeslaImmunityActive && universalDamageHandler != null && universalDamageHandler.TranslationId == DeathTranslations.Tesla.Id)
			{
				return 0f;
			}
			if (!base.IsEnabled)
			{
				return 0.85f;
			}
			if (universalDamageHandler != null && (universalDamageHandler.TranslationId == DeathTranslations.Scp207.Id || universalDamageHandler.TranslationId == DeathTranslations.PocketDecay.Id))
			{
				return 0.85f;
			}
			if (handler is Scp939DamageHandler { Scp939DamageType: Scp939DamageType.LungeTarget })
			{
				return 0.85f;
			}
			float curValue = base.Hub.playerStats.GetModule<HealthStat>().CurValue;
			float curValue2 = base.Hub.playerStats.GetModule<AhpStat>().CurValue;
			float num = curValue + curValue2;
			if (curValue > baseDamage || num > baseDamage)
			{
				return 0.85f;
			}
			DisableEffect();
			if (OriginCloud != null)
			{
				OriginCloud.IgnoredTargets.Add(base.Hub);
			}
			NetworkServer.SendToReady(new BreakMessage
			{
				SoundPos = base.Hub.transform.position
			});
			_lastSaveTime = Time.timeSinceLevelLoad;
			return (num - DeathSaveHealth) / baseDamage;
		}

		protected override void OnTick()
		{
			if (NetworkServer.active)
			{
				_hpStat.ServerHeal(5f);
			}
		}

		protected override void Enabled()
		{
			base.Enabled();
			_isDamageModifierEnabled = true;
			if (!_ambienceSource.isPlaying)
			{
				_ambienceSource.Play();
			}
			else if (_ambienceSource.volume == 0f)
			{
				_ambienceSource.Stop();
				_ambienceSource.Play();
			}
			_ambienceSource.mute = true;
			_ambienceSource.volume = 1f;
			if (NetworkServer.active)
			{
				_hpStat = base.Hub.playerStats.GetModule<HealthStat>();
			}
		}

		protected override void Update()
		{
			base.Update();
			if (!(_ambienceSource.volume <= 0f))
			{
				_ambienceSource.mute = !base.IsSpectated && !base.IsLocalPlayer;
				if (!base.IsEnabled)
				{
					_ambienceSource.volume -= Time.deltaTime;
				}
			}
		}

		private static void OnBreak(BreakMessage msg)
		{
			if (ReferenceHub.TryGetLocalHub(out var hub) && hub.playerEffectsController.TryGetEffect<Prismatic>(out var playerEffect))
			{
				AudioSourcePoolManager.PlayAtPosition(playerEffect._effectBreakSound, msg.SoundPos, BreakSoundDistance, BreakVolumeModifier);
			}
		}

		[RuntimeInitializeOnLoadMethod]
		private static void Init()
		{
			CustomNetworkManager.OnClientReady += () =>
			{
				NetworkClient.ReplaceHandler<BreakMessage>(OnBreak);
			};
		}
	}
}
