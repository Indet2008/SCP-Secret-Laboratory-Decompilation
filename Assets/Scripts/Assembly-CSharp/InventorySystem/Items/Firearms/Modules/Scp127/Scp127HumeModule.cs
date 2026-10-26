using System;
using System.Collections.Generic;
using InventorySystem.Items.Autosync;
using Mirror;
using PlayerRoles;
using PlayerRoles.PlayableScps.HumeShield;
using PlayerStatsSystem;
using UnityEngine;
using Utils.NonAllocLINQ;

namespace InventorySystem.Items.Firearms.Modules.Scp127
{
	public class Scp127HumeModule : ModuleBase, IHumeShieldProvider
	{
		[Serializable]
		private struct MaxHumeTierPair
		{
			public Scp127Tier Tier;

			public float MaxShield;
		}

		private class HumeShieldSession
		{
			public readonly HumeShieldStat Stat;

			public readonly ReferenceHub Hub;

			private double _lastDamage;

			private double _lastUnequip;

			private Scp127HumeModule _lastModule;

			public float LastUnequipElapsed
			{
				get
				{
					return (float)(_lastUnequip - NetworkTime.time);
				}
				set
				{
					_lastUnequip = NetworkTime.time + (double)value;
				}
			}

			public float LastDamageElapsed => (float)(NetworkTime.time - _lastDamage);

			public Scp127HumeModule EquippedModule
			{
				get
				{
					if (_lastModule != null)
					{
						if (!_lastModule.Item.IsEquipped)
						{
							return null;
						}
						return _lastModule;
					}
					if (!(Hub.inventory.CurInstance is Firearm firearm))
					{
						return null;
					}
					if (!firearm.TryGetModule<Scp127HumeModule>(out var module))
					{
						return null;
					}
					_lastModule = module;
					return _lastModule;
				}
			}

			public void RegisterDamage()
			{
				_lastDamage = NetworkTime.time;
			}

			public HumeShieldSession(Scp127HumeModule hs)
			{
				Hub = hs.Item.Owner;
				Stat = Hub.playerStats.GetModule<HumeShieldStat>();
				_lastModule = hs;
			}
		}

		private static readonly List<HumeShieldSession> ServerActiveSessions = new List<HumeShieldSession>();

		[SerializeField]
		private MaxHumeTierPair[] _maxPerTier;

		public float HsMax
		{
			get
			{
				Scp127Tier tierForItem = Scp127TierManagerModule.GetTierForItem(base.Item);
				AhpStat module = base.Item.Owner.playerStats.GetModule<AhpStat>();
				MaxHumeTierPair[] maxPerTier = _maxPerTier;
				for (int i = 0; i < maxPerTier.Length; i++)
				{
					MaxHumeTierPair maxHumeTierPair = maxPerTier[i];
					if (maxHumeTierPair.Tier == tierForItem)
					{
						return Mathf.Max(0f, maxHumeTierPair.MaxShield - module.CurValue);
					}
				}
				return 0f;
			}
		}

		[field: SerializeField]
		public float ShieldRegenRate { get; private set; }

		[field: SerializeField]
		public float ShieldDecayRate { get; private set; }

		[field: SerializeField]
		public float ShieldOnDamagePause { get; private set; }

		[field: SerializeField]
		public float UnequipDecayDelay { get; private set; }

		public bool ForceBarVisible => false;

		public Color? HsWarningColor => null;

		public float HsRegeneration { get; private set; }

		internal override void TemplateUpdate()
		{
			base.TemplateUpdate();
			if (NetworkServer.active)
			{
				ServerUpdateSessions();
			}
		}

		internal override void OnEquipped()
		{
			base.OnEquipped();
			if (NetworkServer.active)
			{
				ReferenceHub owner = base.Item.Owner;
				if (owner.IsHuman() && !ServerActiveSessions.Any((HumeShieldSession x) => x.Hub == owner))
				{
					ServerActiveSessions.Add(new HumeShieldSession(this));
				}
			}
		}

		internal override void OnHolstered()
		{
			base.OnHolstered();
			HsRegeneration = 0f;
			foreach (HumeShieldSession serverActiveSession in ServerActiveSessions)
			{
				if (!(serverActiveSession.Hub != base.Item.Owner))
				{
					serverActiveSession.LastUnequipElapsed = UnequipDecayDelay;
				}
			}
		}

		internal override void OnClientReady()
		{
			base.OnClientReady();
			ServerActiveSessions.Clear();
		}

		internal override void OnTemplateReloaded(ModularAutosyncItem template, bool wasEverLoaded)
		{
			base.OnTemplateReloaded(template, wasEverLoaded);
			if (!wasEverLoaded)
			{
				ReferenceHub.OnPlayerRemoved += RemoveSession;
				PlayerRoleManager.OnServerRoleSet += (ReferenceHub hub, RoleTypeId _, RoleChangeReason _) =>
				{
					RemoveSession(hub);
				};
				PlayerStats.OnAnyPlayerDamaged += OnAnyPlayerDamaged;
			}
		}

		private void OnAnyPlayerDamaged(ReferenceHub hub, DamageHandlerBase handler)
		{
			if (!NetworkServer.active)
			{
				return;
			}
			foreach (HumeShieldSession serverActiveSession in ServerActiveSessions)
			{
				if (!(serverActiveSession.Hub != hub))
				{
					serverActiveSession.RegisterDamage();
				}
			}
		}

		private void ServerUpdateSessions()
		{
			for (int num = ServerActiveSessions.Count - 1; num >= 0; num--)
			{
				HumeShieldSession humeShieldSession = ServerActiveSessions[num];
				Scp127HumeModule equippedModule = humeShieldSession.EquippedModule;
				HumeShieldStat stat = humeShieldSession.Stat;
				if (equippedModule != null)
				{
					if (stat.CurValue <= equippedModule.HsMax)
					{
						bool flag = humeShieldSession.LastDamageElapsed > ShieldOnDamagePause;
						equippedModule.HsRegeneration = (flag ? ShieldRegenRate : 0f);
					}
					else
					{
						equippedModule.HsRegeneration = 0f;
						stat.CurValue = equippedModule.HsMax;
					}
				}
				else if (!(humeShieldSession.LastUnequipElapsed > 0f))
				{
					stat.CurValue -= Time.deltaTime * ShieldDecayRate;
					if (!(stat.CurValue > 0f))
					{
						ServerActiveSessions.RemoveAt(num);
					}
				}
			}
		}

		private void RemoveSession(ReferenceHub hub)
		{
			for (int num = ServerActiveSessions.Count - 1; num >= 0; num--)
			{
				if (!(ServerActiveSessions[num].Hub != hub))
				{
					ServerActiveSessions.RemoveAt(num);
				}
			}
		}
	}
}
