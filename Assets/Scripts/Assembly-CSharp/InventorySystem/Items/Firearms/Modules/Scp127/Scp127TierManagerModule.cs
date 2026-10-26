using System;
using System.Collections.Generic;
using InventorySystem.Drawers;
using InventorySystem.GUI;
using InventorySystem.Items.Autosync;
using LabApi.Events.Arguments.Scp127Events;
using LabApi.Events.Handlers;
using Mirror;
using PlayerRoles.PlayableScps.Scp049.Zombies;
using PlayerStatsSystem;
using UnityEngine;

namespace InventorySystem.Items.Firearms.Modules.Scp127
{
	public class Scp127TierManagerModule : ModuleBase, IItemAlertDrawer, IItemDrawer
	{
		[Serializable]
		public struct TierThreshold
		{
			public Scp127Tier Tier;

			public float RequiredDamage;
		}

		private class InstanceRecord
		{
			public readonly Dictionary<uint, OwnerStats> Data = new Dictionary<uint, OwnerStats>();

			public OwnerStats GetStats(ReferenceHub hub)
			{
				return GetStats(hub.netId);
			}

			public OwnerStats GetStats(uint netId)
			{
				return Data.GetOrAdd(netId, () => new OwnerStats());
			}
		}

		private class OwnerStats
		{
			public Scp127Tier Tier;

			public float Progress;

			public float ServerExp;

			public byte CompressedProgress
			{
				get
				{
					return (byte)Mathf.FloorToInt(Progress * 255f);
				}
				set
				{
					Progress = (float)(int)value / 255f;
				}
			}
		}

		private static readonly Dictionary<ushort, InstanceRecord> ProgressDatabase = new Dictionary<ushort, InstanceRecord>();

		private float _remainingInterval;

		private readonly ItemHintAlertHelper _hint = new ItemHintAlertHelper(InventoryGuiTranslation.Scp127OnEquip, null);

		private static readonly Type[] LowRewardRoles = new Type[1] { typeof(ZombieRole) };

		private static readonly float LowRewardRoleOnDamageExpMultiplier = 0.5f;

		private static readonly float DamageToHumeExpMultiplier = 0.5f;

		[field: SerializeField]
		public float KillBonus { get; private set; }

		[field: SerializeField]
		public float PassiveExpAmount { get; private set; }

		[field: SerializeField]
		public float PassiveExpInterval { get; private set; }

		[field: SerializeField]
		public TierThreshold[] Thresholds { get; private set; }

		public Scp127Tier CurTier
		{
			get
			{
				return GetTierForItem(base.Item);
			}
			set
			{
				float expForTier = GetExpForTier(value);
				ServerSetStats(expForTier);
			}
		}

		public float ServerExp
		{
			get
			{
				return GetStats(base.Firearm).ServerExp;
			}
			set
			{
				ServerSetStats(value);
			}
		}

		public AlertContent Alert => _hint.Alert;

		public static event Action<Firearm> ServerOnDamaged;

		public static event Action<Firearm, ReferenceHub> ServerOnKilled;

		public static event Action<Firearm> ServerOnLevelledUp;

		public static Scp127Tier GetTierForItem(ItemBase item)
		{
			return GetStats(item).Tier;
		}

		public static void GetTierAndProgressForItem(ItemBase item, out Scp127Tier tier, out float progress)
		{
			OwnerStats stats = GetStats(item);
			tier = stats.Tier;
			progress = stats.Progress;
		}

		public Scp127Tier GetTierForExp(float exp)
		{
			Scp127Tier scp127Tier = Scp127Tier.Tier1;
			TierThreshold[] thresholds = Thresholds;
			for (int i = 0; i < thresholds.Length; i++)
			{
				TierThreshold tierThreshold = thresholds[i];
				if (!(tierThreshold.RequiredDamage > exp) && tierThreshold.Tier >= scp127Tier)
				{
					scp127Tier = tierThreshold.Tier;
				}
			}
			return scp127Tier;
		}

		public float GetExpForTier(Scp127Tier tier)
		{
			TierThreshold[] thresholds = Thresholds;
			for (int i = 0; i < thresholds.Length; i++)
			{
				TierThreshold tierThreshold = thresholds[i];
				if (tierThreshold.Tier == tier)
				{
					return tierThreshold.RequiredDamage;
				}
			}
			return 0f;
		}

		public float GetProgress(Scp127Tier curTier, float curExp)
		{
			float expForTier = GetExpForTier(curTier);
			float expForTier2 = GetExpForTier(curTier + 1);
			if (expForTier2 != 0f)
			{
				return Mathf.InverseLerp(expForTier, expForTier2, curExp);
			}
			return 0f;
		}

		public void ServerSetStats(float exp)
		{
			OwnerStats stats = GetStats(base.Firearm);
			stats.ServerExp = exp;
			stats.Tier = GetTierForExp(exp);
			stats.Progress = GetProgress(stats.Tier, stats.ServerExp);
			ServerSendStats(base.Firearm.ItemSerial, base.Firearm.Owner, stats.Tier, stats.CompressedProgress);
		}

		public override void ClientProcessRpcTemplate(NetworkReader reader, ushort serial)
		{
			base.ClientProcessRpcTemplate(reader, serial);
			if (!NetworkServer.active)
			{
				ushort serial2 = reader.ReadUShort();
				uint netId = reader.ReadUInt();
				OwnerStats stats = GetRecord(serial2).GetStats(netId);
				stats.Tier = (Scp127Tier)reader.ReadByte();
				stats.CompressedProgress = reader.ReadByte();
			}
		}

		internal override void ServerOnPlayerConnected(ReferenceHub hub, bool firstSubcomponent)
		{
			base.ServerOnPlayerConnected(hub, firstSubcomponent);
			foreach (AutosyncItem instance in AutosyncItem.Instances)
			{
				if (instance is Firearm firearm && firearm.ItemTypeId == base.Item.ItemTypeId && firearm.HasOwner && firearm.TryGetModule<Scp127TierManagerModule>(out var module))
				{
					OwnerStats stats = GetStats(firearm);
					module.ServerSendStats(firearm.ItemSerial, firearm.Owner, stats.Tier, stats.CompressedProgress);
				}
			}
		}

		internal override void OnTemplateReloaded(ModularAutosyncItem template, bool wasEverLoaded)
		{
			base.OnTemplateReloaded(template, wasEverLoaded);
			if (!wasEverLoaded)
			{
				PlayerStats.OnAnyPlayerDamaged += OnAnyPlayerDamaged;
				PlayerStats.OnAnyPlayerDied += OnAnyPlayerDied;
				ReferenceHub.OnPlayerRemoved += OnPlayerRemoved;
			}
		}

		internal override void OnClientReady()
		{
			base.OnClientReady();
			ProgressDatabase.Clear();
		}

		internal override void OnAdded()
		{
			base.OnAdded();
			if (NetworkServer.active)
			{
				OwnerStats stats = GetStats(base.Firearm);
				ServerSendStats(base.ItemSerial, base.Item.Owner, stats.Tier, stats.CompressedProgress);
			}
		}

		internal override void OnEquipped()
		{
			base.OnEquipped();
			_remainingInterval = PassiveExpInterval;
		}

		internal override void EquipUpdate()
		{
			base.EquipUpdate();
			_hint.Update(forceHide: false);
			if (NetworkServer.active)
			{
				_remainingInterval -= PassiveExpInterval * Time.deltaTime;
				if (_remainingInterval <= 0f)
				{
					ServerIncreaseExp(base.Firearm, PassiveExpAmount);
					_remainingInterval += PassiveExpInterval;
				}
			}
		}

		private void OnPlayerRemoved(ReferenceHub hub)
		{
			if (!NetworkServer.active)
			{
				return;
			}
			uint netId = hub.netId;
			foreach (KeyValuePair<ushort, InstanceRecord> item in ProgressDatabase)
			{
				item.Value.Data.Remove(netId);
			}
		}

		private void OnAnyPlayerDied(ReferenceHub deadPlayer, DamageHandlerBase handler)
		{
			if (!NetworkServer.active)
			{
				return;
			}
			if (ServerTryProcessLethalDamageAward(handler, deadPlayer, KillBonus))
			{
				FirearmDamageHandler firearmDamageHandler = handler as FirearmDamageHandler;
				ServerOnKilled?.Invoke(firearmDamageHandler.Firearm, deadPlayer);
			}
			uint netId = deadPlayer.netId;
			foreach (KeyValuePair<ushort, InstanceRecord> item in ProgressDatabase)
			{
				Dictionary<uint, OwnerStats> data = item.Value.Data;
				if (data.ContainsKey(netId))
				{
					data.Remove(netId);
					ServerSendStats(item.Key, deadPlayer, Scp127Tier.Tier1, 0);
				}
			}
		}

		private void OnAnyPlayerDamaged(ReferenceHub damagedPlayer, DamageHandlerBase handler)
		{
			if (NetworkServer.active && handler is AttackerDamageHandler attackerDamageHandler)
			{
				ServerTryProcessNonLethalDamageAward(attackerDamageHandler, damagedPlayer, attackerDamageHandler.TotalDamageDealt);
			}
		}

		private bool VerifyDamage(FirearmDamageHandler handler)
		{
			if (handler.Firearm.ItemTypeId != base.Item.ItemTypeId)
			{
				return false;
			}
			if (handler.IsFriendlyFire)
			{
				return false;
			}
			Firearm firearm = handler.Firearm;
			if (firearm.Owner == null)
			{
				return false;
			}
			ServerOnDamaged?.Invoke(firearm);
			return true;
		}

		private bool ServerTryProcessLethalDamageAward(DamageHandlerBase dhBase, ReferenceHub attackedHub, float amount)
		{
			if (!(dhBase is FirearmDamageHandler firearmDamageHandler))
			{
				return false;
			}
			if (!VerifyDamage(firearmDamageHandler))
			{
				return false;
			}
			if (LowRewardRoles.Contains(attackedHub.roleManager.CurrentRole.GetType()))
			{
				return false;
			}
			ServerIncreaseExp(firearmDamageHandler.Firearm, amount);
			return true;
		}

		private bool ServerTryProcessNonLethalDamageAward(DamageHandlerBase dhBase, ReferenceHub attackedHub, float amount)
		{
			if (!(dhBase is FirearmDamageHandler firearmDamageHandler))
			{
				return false;
			}
			if (!VerifyDamage(firearmDamageHandler))
			{
				return false;
			}
			if (attackedHub.playerStats.TryGetModule<HumeShieldStat>(out var module) && module.CurValue > module.MinValue)
			{
				amount *= DamageToHumeExpMultiplier;
			}
			if (LowRewardRoles.Contains(attackedHub.roleManager.CurrentRole.GetType()))
			{
				amount *= LowRewardRoleOnDamageExpMultiplier;
			}
			ServerIncreaseExp(firearmDamageHandler.Firearm, amount);
			return true;
		}

		private void ServerIncreaseExp(Firearm firearm, float amount)
		{
			OwnerStats stats = GetStats(firearm);
			Scp127Tier tier = stats.Tier;
			byte compressedProgress = stats.CompressedProgress;
			Scp127GainingExperienceEventArgs e = new Scp127GainingExperienceEventArgs(firearm, amount);
			Scp127Events.OnGainingExperience(e);
			if (!e.IsAllowed)
			{
				return;
			}
			amount = e.ExperienceGain;
			stats.ServerExp += amount;
			Scp127Events.OnGainExperience(new Scp127GainExperienceEventArgs(firearm, amount));
			Scp127Tier scp127Tier = GetTierForExp(stats.ServerExp);
			bool flag = tier != scp127Tier;
			if (flag)
			{
				Scp127LevellingUpEventArgs e2 = new Scp127LevellingUpEventArgs(firearm, scp127Tier);
				Scp127Events.OnLevellingUp(e2);
				if (!e2.IsAllowed)
				{
					stats.Progress = GetProgress(stats.Tier, stats.ServerExp);
					if (compressedProgress != stats.CompressedProgress)
					{
						ServerSendStats(firearm.ItemSerial, firearm.Owner, stats.Tier, stats.CompressedProgress);
					}
					return;
				}
				scp127Tier = e2.Tier;
			}
			stats.Tier = scp127Tier;
			stats.Progress = GetProgress(stats.Tier, stats.ServerExp);
			if (flag || compressedProgress != stats.CompressedProgress)
			{
				ServerSendStats(firearm.ItemSerial, firearm.Owner, stats.Tier, stats.CompressedProgress);
				if (flag)
				{
					ServerOnLevelledUp?.Invoke(firearm);
					Scp127Events.OnLevelUp(new Scp127LevelUpEventArgs(firearm, stats.Tier));
				}
			}
		}

		private void ServerSendStats(ushort serial, ReferenceHub owner, Scp127Tier tier, byte progress)
		{
			SendRpc((NetworkWriter x) =>
			{
				x.WriteUShort(serial);
				x.WriteUInt(owner.netId);
				x.WriteByte((byte)tier);
				x.WriteByte(progress);
			});
		}

		private static InstanceRecord GetRecord(ushort serial)
		{
			return ProgressDatabase.GetOrAdd(serial, () => new InstanceRecord());
		}

		private static OwnerStats GetStats(ItemBase instance)
		{
			return GetRecord(instance.ItemSerial).GetStats(instance.Owner);
		}
	}
}
