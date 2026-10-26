using System.Collections.Generic;
using Footprinting;
using InventorySystem;
using InventorySystem.Items.Armor;
using InventorySystem.Items.Firearms;
using InventorySystem.Items.Firearms.Ammo;
using InventorySystem.Items.Firearms.Modules;
using Mirror;
using PlayerRoles;
using PlayerRoles.Ragdolls;
using UnityEngine;

namespace PlayerStatsSystem
{
	public class FirearmDamageHandler : AttackerDamageHandler
	{
		private string _ammoName;

		private sbyte _hitDirectionX;

		private sbyte _hitDirectionZ;

		private readonly float _penetration;

		private readonly string _deathReasonFormat;

		private readonly bool _useHumanHitboxes;

		private static readonly Dictionary<HitboxType, float> HitboxToForce = new Dictionary<HitboxType, float>
		{
			[HitboxType.Body] = 0.08f,
			[HitboxType.Headshot] = 0.08f,
			[HitboxType.Limb] = 0.016f
		};

		private static readonly Dictionary<HitboxType, float> HitboxDamageMultipliers = new Dictionary<HitboxType, float>
		{
			[HitboxType.Headshot] = 2f,
			[HitboxType.Limb] = 0.7f
		};

		private static readonly Dictionary<ItemType, float> AmmoToForce = new Dictionary<ItemType, float>
		{
			[ItemType.Ammo12gauge] = 1.9f,
			[ItemType.Ammo44cal] = 1.2f,
			[ItemType.Ammo9x19] = 0.7f
		};

		private const float UpwardVelocityFactor = 0.1f;

		public override float Damage { get; set; }

		public override Footprint Attacker { get; protected set; }

		public override bool AllowSelfDamage => false;

		public override string RagdollInspectText => string.Format(_deathReasonFormat, _ammoName);

		public override string DeathScreenText => string.Empty;

		public override string ServerLogsText => "Shot by " + Attacker.Nickname + " with " + WeaponType.ToString() + " to the '" + Hitbox.ToString() + "' hitbox.";

		public override string ServerMetricsText => base.ServerMetricsText + "," + WeaponType;

		public Firearm Firearm { get; private set; }

		public ItemType WeaponType { get; private set; }

		public ItemType AmmoType { get; private set; }

		public FirearmDamageHandler()
		{
			_deathReasonFormat = DeathTranslations.BulletWounds.RagdollTranslation;
		}

		public FirearmDamageHandler(Firearm firearm, float damage, float penetration, bool useHumanMutlipliers = true)
			: this()
		{
			Damage = damage;
			Attacker = firearm.Footprint;
			Firearm = firearm;
			WeaponType = firearm.ItemTypeId;
			AmmoType = (firearm.TryGetModule<IPrimaryAmmoContainerModule>(out var module) ? module.AmmoType : ItemType.None);
			_penetration = penetration;
			_useHumanHitboxes = useHumanMutlipliers;
			Vector3 forward = firearm.Owner.PlayerCameraReference.forward;
			_hitDirectionX = (sbyte)Mathf.RoundToInt(forward.x * 127f);
			_hitDirectionZ = (sbyte)Mathf.RoundToInt(forward.z * 127f);
		}

		public override void WriteAdditionalData(NetworkWriter writer)
		{
			base.WriteAdditionalData(writer);
			writer.WriteSByte((sbyte)WeaponType);
			writer.WriteSByte((sbyte)AmmoType);
			writer.WriteByte((byte)Hitbox);
			writer.WriteSByte(_hitDirectionX);
			writer.WriteSByte(_hitDirectionZ);
		}

		public override void ReadAdditionalData(NetworkReader reader)
		{
			base.ReadAdditionalData(reader);
			WeaponType = (ItemType)reader.ReadSByte();
			AmmoType = (ItemType)reader.ReadSByte();
			Hitbox = (HitboxType)reader.ReadByte();
			_hitDirectionX = reader.ReadSByte();
			_hitDirectionZ = reader.ReadSByte();
			if (InventoryItemLoader.TryGetItem<AmmoItem>(AmmoType, out var result))
			{
				_ammoName = result.Name;
			}
		}

		public override void ProcessRagdoll(BasicRagdoll ragdoll)
		{
			base.ProcessRagdoll(ragdoll);
			if (!HitboxToForce.TryGetValue(Hitbox, out var value) || !(ragdoll is DynamicRagdoll dynamicRagdoll))
			{
				return;
			}
			float num = value * (AmmoToForce.TryGetValue(AmmoType, out var value2) ? value2 : 1f);
			Rigidbody[] linkedRigidbodies = dynamicRagdoll.LinkedRigidbodies;
			for (int i = 0; i < linkedRigidbodies.Length; i++)
			{
				linkedRigidbodies[i].AddForce(num * 127f * 0.1f * Vector3.up, ForceMode.VelocityChange);
			}
			Vector3 force = new Vector3(_hitDirectionX, 0f, _hitDirectionZ) * num;
			HitboxData[] hitboxes = dynamicRagdoll.Hitboxes;
			for (int i = 0; i < hitboxes.Length; i++)
			{
				HitboxData hitboxData = hitboxes[i];
				if (hitboxData.RelatedHitbox == Hitbox)
				{
					hitboxData.Target.AddForce(force, ForceMode.VelocityChange);
				}
			}
		}

		protected override void ProcessDamage(ReferenceHub ply)
		{
			if (!_useHumanHitboxes && ply.IsHuman())
			{
				Hitbox = HitboxType.Body;
			}
			if (_useHumanHitboxes && HitboxDamageMultipliers.TryGetValue(Hitbox, out var value))
			{
				Damage *= value;
			}
			base.ProcessDamage(ply);
			if (Damage != 0f && ply.roleManager.CurrentRole is IArmoredRole armoredRole)
			{
				int armorEfficacy = armoredRole.GetArmorEfficacy(Hitbox);
				int bulletPenetrationPercent = Mathf.RoundToInt(_penetration * 100f);
				float num = Mathf.Clamp(ply.playerStats.GetModule<HumeShieldStat>().CurValue, 0f, Damage);
				float baseDamage = Mathf.Max(0f, Damage - num);
				float num2 = BodyArmorUtils.ProcessDamage(armorEfficacy, baseDamage, bulletPenetrationPercent);
				Damage = num2 + num;
			}
		}
	}
}
