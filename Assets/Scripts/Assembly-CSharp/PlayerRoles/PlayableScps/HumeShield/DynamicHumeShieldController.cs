using System.Collections.Generic;
using AudioPooling;
using CustomPlayerEffects;
using GameObjectPools;
using LabApi.Events.Arguments.ScpEvents;
using LabApi.Events.Handlers;
using Mirror;
using PlayerRoles.RoleAssign;
using PlayerStatsSystem;
using UnityEngine;

namespace PlayerRoles.PlayableScps.HumeShield
{
	public class DynamicHumeShieldController : HumeShieldModuleBase, IPoolSpawnable, IPoolResettable
	{
		public struct ShieldBreakMessage : NetworkMessage
		{
			public ReferenceHub Target;
		}

		private const float ShieldBreakSoundRange = 37f;

		private const MixerChannel ShieldBreakSoundChannel = MixerChannel.NoDucking;

		public AnimationCurve ShieldOverHealth;

		public float RegenerationRate;

		public float RegenerationCooldown;

		[SerializeField]
		private AudioClip _shieldBreakSound;

		[SerializeField]
		private bool _hideWhenEmpty;

		private readonly HashSet<IHumeShieldBlocker> _blockers = new HashSet<IHumeShieldBlocker>();

		private HealthStat _hp;

		private double _nextRegenTime;

		private int _blockersCount;

		private float _initialRegenRate;

		private float _initialRegenCooldown;

		public bool IsBlocked
		{
			get
			{
				_blockersCount -= _blockers.RemoveWhere((IHumeShieldBlocker x) => (x is Object obj && obj == null) || x == null || !x.HumeShieldBlocked);
				return _blockersCount > 0;
			}
		}

		public virtual AudioClip ShieldBreakSound => _shieldBreakSound;

		public virtual bool ServerPlayBreakSound
		{
			get
			{
				if (base.Owner.IsSCP())
				{
					return ShieldBreakSound != null;
				}
				return false;
			}
		}

		public override float HsMax
		{
			get
			{
				float num = ShieldOverHealth.Evaluate(_hp.NormalizedValue);
				if (RoleAssigner.ScpsOverflowing)
				{
					num *= RoleAssigner.ScpOverflowMaxHsMultiplier;
				}
				return num;
			}
		}

		public override float HsRegeneration
		{
			get
			{
				if (!(_nextRegenTime < NetworkTime.time) || IsBlocked)
				{
					return 0f;
				}
				return RegenerationRate;
			}
		}

		public override Color? HsWarningColor
		{
			get
			{
				if (!IsBlocked)
				{
					return null;
				}
				return new Color(1f, 0f, 0f, 0.3f);
			}
		}

		public override bool HideWhenEmpty => _hideWhenEmpty;

		public void AddBlocker(IHumeShieldBlocker blocker)
		{
			if (_blockers.Add(blocker))
			{
				_blockersCount++;
			}
		}

		public void ResumeRegen()
		{
			_nextRegenTime = 0.0;
		}

		public override void OnHsValueChanged(float prevValue, float newValue)
		{
			if (NetworkServer.active && !(newValue > 0f) && !(prevValue <= 0f) && ServerPlayBreakSound)
			{
				NetworkServer.SendToReady(new ShieldBreakMessage
				{
					Target = base.Owner
				});
				ScpEvents.OnHumeShieldBroken(new ScpHumeShieldBrokenEventArgs(base.Owner));
			}
		}

		public override void SpawnObject()
		{
			base.SpawnObject();
			PlayerStats playerStats = base.Owner.playerStats;
			_hp = playerStats.GetModule<HealthStat>();
			playerStats.OnThisPlayerDamaged += OnDamaged;
			if (NetworkServer.active)
			{
				base.HsCurrent = ShieldOverHealth.Evaluate(1f);
			}
		}

		public void ResetObject()
		{
			if (base.Owner != null)
			{
				base.Owner.playerStats.OnThisPlayerDamaged -= OnDamaged;
			}
			RegenerationCooldown = _initialRegenCooldown;
			RegenerationRate = _initialRegenRate;
			_nextRegenTime = 0.0;
			_blockersCount = 0;
			_blockers.Clear();
		}

		private void OnDamaged(DamageHandlerBase dhb)
		{
			if (NetworkServer.active && !AnyActiveModifierEffects())
			{
				_nextRegenTime = NetworkTime.time + (double)RegenerationCooldown;
			}
		}

		private bool AnyActiveModifierEffects()
		{
			for (int i = 0; i < base.Owner.playerEffectsController.EffectsLength; i++)
			{
				StatusEffectBase statusEffectBase = base.Owner.playerEffectsController.AllEffects[i];
				if (statusEffectBase.IsEnabled && statusEffectBase is IHumeRegenModifier { HumeRegenCooldownEnabled: false })
				{
					return true;
				}
			}
			return false;
		}

		[RuntimeInitializeOnLoadMethod]
		private static void Init()
		{
			CustomNetworkManager.OnClientReady += () =>
			{
				NetworkClient.ReplaceHandler<ShieldBreakMessage>(ProcessBreakMessage);
			};
		}

		private static void ProcessBreakMessage(ShieldBreakMessage msg)
		{
			if (!(msg.Target == null) && msg.Target.roleManager.CurrentRole is IHumeShieldedRole { HumeShieldModule: DynamicHumeShieldController humeShieldModule })
			{
				AudioSourcePoolManager.PlayOnTransform(humeShieldModule.ShieldBreakSound, humeShieldModule.transform, 37f, 1f, FalloffType.Exponential, MixerChannel.NoDucking);
			}
		}

		private void Awake()
		{
			_initialRegenCooldown = RegenerationCooldown;
			_initialRegenRate = RegenerationRate;
		}
	}
}
