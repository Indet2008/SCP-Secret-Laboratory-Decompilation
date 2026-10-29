using System;
using System.Collections.Generic;
using System.Text;
using CustomPlayerEffects.Danger;
using InventorySystem.Items.Firearms.Attachments;
using InventorySystem.Searching;
using Mirror;
using PlayerRoles.Spectating;
using RemoteAdmin.Interfaces;
using UnityEngine;

namespace CustomPlayerEffects
{
	public class Scp1853 : TickingEffectBase, ISpectatorDataPlayerEffect, IHealableEffect, IConflictableEffect, IWeaponModifierPlayerEffect, ISearchTimeModifier, ICustomDisplayName, IUsableItemModifierEffect, IHeavyItemPenaltyImmunity, ISoundtrackMutingEffect, IDisplayInfoEffect
	{
		[Serializable]
		private struct SerializedStat
		{
			public AttachmentParam Parameter;

			public float BoostPercentage;

			public float MaxBoost;

			public bool IsAdditive;

			public SerializedStat(AttachmentParam param, float boostPercentage, float maxBoost = 0f, bool isAdditive = true)
			{
				Parameter = param;
				BoostPercentage = boostPercentage;
				MaxBoost = maxBoost;
				IsAdditive = isAdditive;
			}
		}

		public const float DangerPerIntensity = 0.25f;

		private const float MinimumDanger = 1f;

		private const float MaximumDanger = 5f;

		private const float SearchSpeed = 1.5f;

		private const float EquipAndUse = 0.2f;

		private const float ItemUsageMaxMultiplier = 0.4f;

		private const float NoMaxBoost = 0f;

		private const float StatMultiplierPerDanger = 0.5f;

		private static readonly SerializedStat[] BaseWeaponModifiers = new SerializedStat[6]
		{
			new SerializedStat(AttachmentParam.AdsSpeedMultiplier, 0.2f, 0.4f),
			new SerializedStat(AttachmentParam.OverallRecoilMultiplier, 0.2f, 0f, isAdditive: false),
			new SerializedStat(AttachmentParam.AdsInaccuracyMultiplier, 0.2f, 0f, isAdditive: false),
			new SerializedStat(AttachmentParam.HipInaccuracyMultiplier, 0.2f, 0f, isAdditive: false),
			new SerializedStat(AttachmentParam.ReloadSpeedMultiplier, 0.35f),
			new SerializedStat(AttachmentParam.DrawSpeedMultiplier, 0.2f)
		};

		private static readonly ItemType[] AffectedItems = new ItemType[8]
		{
			ItemType.SCP018,
			ItemType.SCP500,
			ItemType.SCP330,
			ItemType.GrenadeFlash,
			ItemType.GrenadeHE,
			ItemType.Medkit,
			ItemType.Painkillers,
			ItemType.Adrenaline
		};

		public DangerStackBase[] Dangers = new DangerStackBase[8]
		{
			new WarheadDanger(),
			new CardiacArrestDanger(),
			new RageTargetDanger(),
			new CorrodingDanger(),
			new PlayerDamagedDanger(),
			new ScpEncounterDanger(),
			new ZombieEncounterDanger(),
			new ArmedEnemyDanger()
		};

		[SerializeField]
		private AudioSource _dangerChangedSource;

		[SerializeField]
		private AudioSource _heartbeatSource;

		[SerializeField]
		private AudioClip _dangerIncreasedClip;

		[SerializeField]
		private AudioClip _dangerDecreasedClip;

		private readonly Dictionary<AttachmentParam, float> _processedParams = new Dictionary<AttachmentParam, float>();

		private float _searchSpeedMultiplier;

		private VignetteSmoothnessPulse _vignetteSmoothnessPulse;

		private VignettePulse _vignettePulse;

		private float _cachedTickTime;

		protected override void Awake()
		{
			base.Awake();
			_vignettePulse = GetComponent<VignettePulse>();
			_vignetteSmoothnessPulse = GetComponent<VignetteSmoothnessPulse>();
			_cachedTickTime = TimeBetweenTicks;
		}


		public override EffectClassification Classification => EffectClassification.Positive;

		public override byte MaxIntensity => 20;

		public bool ParamsActive => base.IsEnabled;

		public float ItemUsageSpeedMultiplier { get; private set; }

		public string DisplayName => "SCP-1853";

		public bool CanBeDisplayed => true;

		public bool SprintingDisabled => false;

		public bool MuteSoundtrack => base.IsEnabled;

		public float CurrentDanger => (float)(int)base.Intensity * 0.25f;

		public float StatMultiplier => 1f + (float)OffsetedDanger * 0.5f;

		private int OffsetedDanger => Mathf.Max(0, Mathf.FloorToInt(CurrentDanger - 1f));

		protected override void IntensityChanged(byte prevState, byte newState)
		{
			float statMultiplier = StatMultiplier;
			float num = Mathf.Floor((float)(int)prevState * 0.25f);
			float num2 = Mathf.Floor((float)(int)newState * 0.25f);
			SerializedStat[] baseWeaponModifiers = BaseWeaponModifiers;
			for (int i = 0; i < baseWeaponModifiers.Length; i++)
			{
				SerializedStat serializedStat = baseWeaponModifiers[i];
				float boostAmount = serializedStat.BoostPercentage * statMultiplier;
				_processedParams[serializedStat.Parameter] = CalculateStat(boostAmount, serializedStat.MaxBoost, serializedStat.IsAdditive);
			}
			_searchSpeedMultiplier = 1.5f;
			ItemUsageSpeedMultiplier = CalculateStat(0.2f * statMultiplier, 0.4f);
			if (base.IsLocalPlayer || base.Hub.IsLocallySpectated())
			{
				UpdateHeartbeat();
				if (num != num2 && num != 0f && num2 != 0f)
				{
					bool flag = num2 > num;
					_dangerChangedSource.PlayOneShot(flag ? _dangerIncreasedClip : _dangerDecreasedClip, 1f);
				}
			}
		}

		public override void OnStopSpectating()
		{
			base.OnStopSpectating();
			UpdateHeartbeat();
		}

		protected override void OnTick()
		{
			if (base.Hub.isLocalPlayer || base.Hub.IsLocallySpectated())
			{
				TimeBetweenTicks = _cachedTickTime - (float)OffsetedDanger * 0.35f;
				ExecuteVignettePulse();
			}
		}

		protected override void Enabled()
		{
			base.Enabled();
			UpdateHeartbeat();
			if (NetworkServer.active)
			{
				DangerStackBase[] dangers = Dangers;
				for (int i = 0; i < dangers.Length; i++)
				{
					dangers[i].Initialize(base.Hub);
				}
			}
		}

		protected override void Disabled()
		{
			base.Disabled();
			UpdateHeartbeat();
			if (NetworkServer.active)
			{
				DangerStackBase[] dangers = Dangers;
				for (int i = 0; i < dangers.Length; i++)
				{
					dangers[i].Dispose();
				}
			}
		}

		protected override void Update()
		{
			base.Update();
			if (!base.IsEnabled || !NetworkServer.active)
			{
				return;
			}
			float num = 1f;
			DangerStackBase[] dangers = Dangers;
			foreach (DangerStackBase dangerStackBase in dangers)
			{
				if (dangerStackBase.IsActive)
				{
					num += dangerStackBase.DangerValue;
				}
			}
			num = Mathf.Clamp(num, 1f, 5f);
			byte b = (byte)(num / 0.25f);
			if (b != base.Intensity)
			{
				base.Intensity = b;
			}
		}

		private void ExecuteVignettePulse()
		{
			int offsetedDanger = OffsetedDanger;
			float animationSpeedMultiplier = (float)offsetedDanger * 0.35f + 1f;
			_vignetteSmoothnessPulse.PulseIntensity = (float)offsetedDanger * 0.015f + 0.25f;
			_vignettePulse.PulseIntensity = (float)offsetedDanger * 0.0015f + 0.575f;
			_vignetteSmoothnessPulse.animationSpeedMultiplier = animationSpeedMultiplier;
			_vignettePulse.animationSpeedMultiplier = animationSpeedMultiplier;
			_vignetteSmoothnessPulse.Pulse();
			_vignettePulse.Pulse();
		}

		private void UpdateHeartbeat()
		{
			if (!base.Hub.isLocalPlayer && !base.Hub.IsLocallySpectated())
			{
				if (_heartbeatSource.isPlaying)
				{
					_heartbeatSource.Stop();
				}
				return;
			}
			int offsetedDanger = OffsetedDanger;
			if (offsetedDanger < 1)
			{
				if (_heartbeatSource.isPlaying)
				{
					_heartbeatSource.Stop();
				}
			}
			else if (!_heartbeatSource.isPlaying)
			{
				_heartbeatSource.Play();
			}
			_heartbeatSource.volume = (float)offsetedDanger * 0.2f + 0.3f;
			_heartbeatSource.pitch = (float)offsetedDanger * 0.1f + 0.64f;
		}

		private float CalculateStat(float boostAmount, float max = 0f, bool isAdditive = true)
		{
			if (max > 0f)
			{
				boostAmount = Mathf.Clamp(boostAmount, 0f, max);
			}
			return 1f + (isAdditive ? boostAmount : (0f - boostAmount));
		}

		public bool IsHealable(ItemType it)
		{
			return it == ItemType.SCP500;
		}

		public bool GetSpectatorText(out string s)
		{
			s = $"SCP-1853 ({CurrentDanger} danger)";
			return true;
		}

		public bool TryGetSpeed(ItemType item, out float speed)
		{
			speed = ItemUsageSpeedMultiplier;
			if (base.IsEnabled)
			{
				return AffectedItems.Contains(item);
			}
			return false;
		}

		public float ProcessSearchTime(float val)
		{
			return val / Mathf.Max(_searchSpeedMultiplier, 1f);
		}

		public bool TryGetWeaponParam(AttachmentParam param, out float val)
		{
			return _processedParams.TryGetValue(param, out val);
		}

		public bool CheckConflicts(StatusEffectBase other)
		{
			if (!(other is CokeBase))
			{
				return false;
			}
			if (!base.Hub.playerEffectsController.TryGetEffect<Poisoned>(out var playerEffect))
			{
				return false;
			}
			if (!playerEffect.IsEnabled)
			{
				playerEffect.ForceIntensity(1);
			}
			return true;
		}

		public void AppendDisplayInfo(StringBuilder sb)
		{
			sb.AppendFormat("(Danger: {0})", CurrentDanger);
		}
	}
}
