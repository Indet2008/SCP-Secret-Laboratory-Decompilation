using System.Collections.Generic;
using AudioPooling;
using Footprinting;
using InventorySystem.Items;
using MapGeneration.Holidays;
using Mirror;
using PlayerRoles;
using PlayerRoles.FirstPersonControl;
using PlayerStatsSystem;
using UnityEngine;

namespace CustomPlayerEffects
{
	public class Spicy : TickingEffectBase, IInteractionBlocker, IHolidayEffect
	{
		private const int VfxInterval = 4;

		private const float EnemyDotProductThreshold = 0.75f;

		private const float OmnidirectionalRange = 0.7f;

		private const float ForwardRange = 5f;

		private const float SfxRange = 12f;

		private const float TickDamage = 15f;

		[SerializeField]
		private AudioClip _fireBreathingClip;

		[SerializeField]
		private AudioClip _initialScreechClip;

		[SerializeField]
		private GameObject _flameBreathVFX;

		private readonly HashSet<uint> _alreadyDamagedEntities = new HashSet<uint>();

		private int _vfxTimer;

		public override bool AllowEnabling => true;

		public bool CanBeCleared => !base.IsEnabled;

		public BlockedInteraction BlockedInteractions => BlockedInteraction.OpenInventory;

		public HolidayType[] TargetHolidays { get; } = new HolidayType[1] { HolidayType.Halloween };

		protected override void Enabled()
		{
			base.Enabled();
			_vfxTimer = 0;
			if (_initialScreechClip != null)
			{
				AudioSourcePoolManager.PlayOnTransform(_initialScreechClip, base.Hub.transform, 12f, 0.4f);
			}
			base.Hub.interCoordinator.AddBlocker(this);
		}

		protected override void Disabled()
		{
			base.Disabled();
		}

		protected override void OnTick()
		{
			bool flag = _vfxTimer <= 3;
			bool flag2 = _vfxTimer % 4 == 0;
			if (((_flameBreathVFX != null) & flag2) && !flag)
			{
				float num = (base.Hub.isLocalPlayer ? (-0.55f) : (-0.35f));
				Vector3 position = base.Hub.PlayerCameraReference.position + Vector3.up * num;
				if (Object.Instantiate(_flameBreathVFX, position, base.Hub.PlayerCameraReference.rotation, base.Hub.transform).TryGetComponent<WorldPlayerVFX>(out var component))
				{
					component.Assign(base.Hub);
				}
			}
			_vfxTimer++;
			if ((!NetworkServer.active | flag) || !(base.Hub.roleManager.CurrentRole is IFpcRole fpcRole))
			{
				return;
			}
			Vector3 position2 = fpcRole.FpcModule.Position;
			bool flag3 = false;
			foreach (ReferenceHub allHub in ReferenceHub.AllHubs)
			{
				if ((object)allHub == base.Hub || !(allHub.roleManager.CurrentRole is IFpcRole fpcRole2))
				{
					continue;
				}
				Vector3 vector = fpcRole2.FpcModule.Position - position2;
				float sqrMagnitude = vector.sqrMagnitude;
				if (sqrMagnitude > 25f)
				{
					continue;
				}
				float num2 = Mathf.Sqrt(sqrMagnitude);
				Vector3 vector2 = (Mathf.Approximately(num2, 0f) ? Vector3.zero : (vector / num2));
				float num3 = Vector3.Dot(vector2, base.Hub.PlayerCameraReference.forward);
				if ((num2 < 0.7f || num3 >= 0.75f) && !Physics.Raycast(position2, vector2, num2, PlayerRolesUtils.AttackMask) && _alreadyDamagedEntities.Add(allHub.networkIdentity.netId))
				{
					float num4 = 15f;
					if (allHub.playerStats.TryGetModule<HumeShieldStat>(out var module))
					{
						num4 = ((!(num4 * 3f < module.CurValue)) ? (num4 + module.CurValue / 3f) : (num4 * 3f));
					}
					ExplosionDamageHandler explosionDamageHandler = new ExplosionDamageHandler(new Footprint(base.Hub), Vector3.zero, num4, 100, ExplosionType.Custom);
					if (allHub.playerStats.DealDamage(explosionDamageHandler))
					{
						flag3 |= Hitmarker.CheckHitmarkerPerms(explosionDamageHandler, allHub);
						allHub.playerEffectsController.EnableEffect<Burned>(60f);
					}
				}
			}
			if (flag3)
			{
				Hitmarker.SendHitmarkerDirectly(base.Hub, 1f);
			}
			_alreadyDamagedEntities.Clear();
		}
	}
}
