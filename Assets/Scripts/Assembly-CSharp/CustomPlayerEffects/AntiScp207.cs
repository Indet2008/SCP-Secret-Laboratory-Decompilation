using AudioPooling;
using System;
using System.Collections.Generic;
using InventorySystem.Items.Scp1509;
using Mirror;
using NorthwoodLib.Pools;
using PlayerRoles.FirstPersonControl;
using PlayerStatsSystem;
using RemoteAdmin.Interfaces;
using UnityEngine;

namespace CustomPlayerEffects
{
	public class AntiScp207 : CokeBase<AntiScp207Stack>, ISpectatorDataPlayerEffect, ICustomDisplayName, IDamageModifierEffect
	{
		public struct BreakMessage : NetworkMessage
		{
			public Vector3 SoundPos;
		}

		private const float AhpDecayValue = 1f;

		public static readonly float DeathSaveHealth = 1f;

		public static readonly float VitalitySpeedMultipler = 1f;

		public static readonly float HumanAHPEfficacy = 1f;

		public static readonly float TeslaImmunityTime = 2f;

		public static readonly float BreakSoundDistance = 25f;

		public static readonly float BreakVolumeModifier = 0.45f;

		public static readonly float DamageImmunityTime = 0.75f;

		[SerializeField]
		private AudioClip[] _ambienceSounds;

		[SerializeField]
		private AudioSource _ambienceSource;

		[SerializeField]
		private AudioClip _effectBreakSound;

		private float _lastSaveTime;

		private bool _isDamageModifierEnabled;

		private bool _simulating;

		private AhpProcess _ahpProcess;

		private HealthStat _healthStat;

		private AhpStat _ahpStat;

		public override EffectClassification Classification => EffectClassification.Mixed;

		public override Dictionary<PlayerMovementState, float> StateMultipliers { get; } = new Dictionary<PlayerMovementState, float>
		{
			[PlayerMovementState.Crouching] = 1f,
			[PlayerMovementState.Sneaking] = 0.7f,
			[PlayerMovementState.Walking] = 0.6f,
			[PlayerMovementState.Sprinting] = 0.1f
		};

		public string DisplayName => "SCP-207?";

		public bool CanBeDisplayed => true;

		public override float MovementSpeedMultiplier
		{
			get
			{
				if (!Vitality.CheckPlayer(base.Hub))
				{
					return base.CurrentStack.SpeedMultiplier;
				}
				return VitalitySpeedMultipler;
			}
		}

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

		private bool IsTeslaImmunityActive => _lastSaveTime + TeslaImmunityTime >= Time.timeSinceLevelLoad;

		private bool IsImmunityActive => _lastSaveTime + DamageImmunityTime >= Time.timeSinceLevelLoad;

		private float CurrentHealing => base.CurrentStack.HealAmount * GetMovementStateMultiplier();

		public override bool CheckConflicts(StatusEffectBase other)
		{
			return _isDamageModifierEnabled = !base.CheckConflicts(other);
		}

		public bool GetSpectatorText(out string s)
		{
			s = ((base.Intensity > 1) ? $"SCP-207? (x{base.Intensity})" : "SCP-207?");
			return true;
		}

		public float GetDamageModifier(float baseDamage, DamageHandlerBase handler, HitboxType hitboxType)
		{
			if (_simulating)
			{
				return 1f;
			}
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
				return 1f;
			}
			if (universalDamageHandler != null && (universalDamageHandler.TranslationId == DeathTranslations.Scp207.Id || universalDamageHandler.TranslationId == DeathTranslations.PocketDecay.Id || universalDamageHandler.TranslationId == DeathTranslations.Scp1509.Id))
			{
				return 1f;
			}
			if (handler is Scp1509DamageHandler)
			{
				return 1f;
			}
			HealthStat module = base.Hub.playerStats.GetModule<HealthStat>();
			AhpStat module2 = base.Hub.playerStats.GetModule<AhpStat>();
			HumeShieldStat module3 = base.Hub.playerStats.GetModule<HumeShieldStat>();
			if (SimulateHandlerOutput(module, module2, module3, handler) != DamageHandlerBase.HandlerOutput.Death)
			{
				return 1f;
			}
			module.CurValue = 1f;
			module3.CurValue = 0f;
			module2.ServerKillAllProcesses();
			DisableEffect();
			NetworkServer.SendToReady(new BreakMessage
			{
				SoundPos = base.Hub.transform.position
			});
			_lastSaveTime = Time.timeSinceLevelLoad;
			return 0f;
		}

		private DamageHandlerBase.HandlerOutput SimulateHandlerOutput(HealthStat healthStat, AhpStat ahpStat, HumeShieldStat humeShieldStat, DamageHandlerBase dhb)
		{
			float curValue = healthStat.CurValue;
			float curValue2 = humeShieldStat.CurValue;
			float curValue3 = ahpStat.CurValue;
			List<AhpProcessSnapshot> list = ListPool<AhpProcessSnapshot>.Shared.Rent(ahpStat.GenerateSnapshots());
			_simulating = true;
			DamageHandlerBase.HandlerOutput result = dhb.ApplyDamage(base.Hub);
			_simulating = false;
			healthStat.CurValue = curValue;
			ahpStat.CurValue = curValue3;
			humeShieldStat.CurValue = curValue2;
			foreach (AhpProcessSnapshot item in list)
			{
				if (ahpStat.ServerTryGetProcess(item.KillCode, out var process))
				{
					process.OverrideProcess(item);
				}
				else
				{
					ahpStat.ServerAddProcess(item);
				}
			}
			if (_ahpProcess != null && ahpStat.CurValue <= 0f)
			{
				_ahpProcess.DecayRate = 0f;
			}
			ahpStat.ServerUpdateProcesses();
			ListPool<AhpProcessSnapshot>.Shared.Return(list);
			return result;
		}

		protected override void IntensityChanged(byte prevState, byte newState)
		{
			base.IntensityChanged(prevState, newState);
			if (base.IsLocalPlayer)
			{
				_ambienceSource.Stop();
				if (newState > 0)
				{
					_ambienceSource.clip = _ambienceSounds[Mathf.Min(newState, _ambienceSounds.Length) - 1];
					_ambienceSource.Play();
				}
			}
		}

		protected override void OnTick()
		{
			if (!NetworkServer.active)
			{
				return;
			}
			float currentHealing = CurrentHealing;
			if (!_healthStat.FullyHealed)
			{
				if (_ahpProcess != null)
				{
					_ahpProcess.DecayRate = 0f;
				}
				_healthStat.ServerHeal(currentHealing);
			}
			else
			{
				if (_ahpProcess == null)
				{
					_ahpProcess = _ahpStat.ServerAddProcess(0f, _ahpStat.MaxValue, 0f - currentHealing, 0.7f, 0f, persistant: true);
				}
				_ahpProcess.DecayRate = 0f - currentHealing;
			}
		}

		protected override void Enabled()
		{
			base.Enabled();
			_isDamageModifierEnabled = true;
			_ahpProcess = null;
			if (!base.Hub.playerStats.TryGetModule<HealthStat>(out _healthStat))
			{
				throw new NullReferenceException();
			}
			if (!base.Hub.playerStats.TryGetModule<AhpStat>(out _ahpStat))
			{
				throw new NullReferenceException();
			}
		}

		protected override void Disabled()
		{
			base.Disabled();
			if (_ahpProcess != null)
			{
				_ahpProcess.DecayRate = 1f;
			}
		}

		private static void OnBreak(BreakMessage msg)
		{
			if (StaticUnityMethods.IsPlaying && ReferenceHub.LocalHub.playerEffectsController.TryGetEffect<AntiScp207>(out var playerEffect))
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
