using System.Text;
using InventorySystem;
using InventorySystem.Items;
using InventorySystem.Items.Armor;
using Mirror;
using PlayerRoles.Blood;
using PlayerRoles.FirstPersonControl;
using PlayerRoles.FirstPersonControl.Spawnpoints;
using PlayerRoles.PlayableScps.HumeShield;
using Respawning.NamingRules;
using UnityEngine;

namespace PlayerRoles
{
	public class HumanRole : FpcStandardRoleBase, IArmoredRole, IInventoryRole, IHumeShieldedRole, ICustomNicknameDisplayRole, IBleedableRole
	{
		[SerializeField]
		private RoleTypeId _roleId;

		[SerializeField]
		private Team _team;

		[SerializeField]
		private Color _roleColor;

		[SerializeField]
		private MonoBehaviour _spawnpointHandler;

		[field: SerializeField]
		public BloodSettings BloodSettings { get; private set; }

		[field: SerializeField]
		public HumeShieldModuleBase HumeShieldModule { get; private set; }

		public override RoleTypeId RoleTypeId => _roleId;

		public override Team Team => _team;

		public override Color RoleColor => _roleColor;

		public override float MaxHealth => 100f;

		public Color NicknameColor => RoleColor;

		public override ISpawnpointHandler SpawnpointHandler => _spawnpointHandler as ISpawnpointHandler;

		public byte UnitNameId { get; private set; }

		private bool UsesUnitNames
		{
			get
			{
				UnitNamingRule rule;
				return NamingRulesManager.TryGetNamingRule(Team, out rule);
			}
		}

		public override void WritePublicSpawnData(NetworkWriter writer)
		{
			if (UsesUnitNames)
			{
				writer.WriteByte(UnitNameId);
			}
			base.WritePublicSpawnData(writer);
		}

		public override void ReadSpawnData(NetworkReader reader)
		{
			if (UsesUnitNames)
			{
				UnitNameId = reader.ReadByte();
			}
			base.ReadSpawnData(reader);
		}

		internal override void Init(ReferenceHub hub, RoleChangeReason spawnReason, RoleSpawnFlags spawnFlags)
		{
			base.Init(hub, spawnReason, spawnFlags);
			if (NetworkServer.active && UsesUnitNames)
			{
				UnitNameId = (byte)(NamingRulesManager.GeneratedNames.TryGetValue(Team, out var value) ? ((byte)value.Count) : 0);
				if (UnitNameId != 0 && spawnReason != RoleChangeReason.Respawn && spawnReason != RoleChangeReason.RespawnMiniwave)
				{
					UnitNameId--;
				}
			}
		}

		public int GetArmorEfficacy(HitboxType hitbox)
		{
			if (!TryGetOwner(out var hub) || !hub.inventory.TryGetBodyArmor(out var bodyArmor))
			{
				return 0;
			}
			return hitbox switch
			{
				HitboxType.Headshot => bodyArmor.HelmetEfficacy, 
				HitboxType.Body => bodyArmor.VestEfficacy, 
				_ => 0, 
			};
		}

		public void WriteNickname(StringBuilder sb)
		{
			if (TryGetOwner(out var hub))
			{
				NicknameSync.WriteDefaultInfo(hub, sb);
				if (NamingRulesManager.TryGetNamingRule(Team, out var rule))
				{
					PlayerInfoArea shownPlayerInfo = hub.nicknameSync.ShownPlayerInfo;
					string unitName = NamingRulesManager.ClientFetchReceived(Team, UnitNameId);
					rule.AppendName(sb, unitName, RoleTypeId, shownPlayerInfo);
				}
			}
		}

		public bool AllowDisarming(ReferenceHub detainer)
		{
			if (Team.GetFaction() == detainer.GetFaction())
			{
				return false;
			}
			if (!TryGetOwner(out var hub))
			{
				return false;
			}
			if (hub.interCoordinator.AnyBlocker(BlockedInteraction.BeDisarmed))
			{
				return false;
			}
			return true;
		}

		public bool AllowUndisarming(ReferenceHub releaser)
		{
			if (releaser.interCoordinator.AnyBlocker(BlockedInteraction.UndisarmPlayers))
			{
				return false;
			}
			return releaser.IsHuman();
		}
	}
}
