using System;
using System.Collections.Generic;
using Footprinting;
using InventorySystem.Crosshairs;
using InventorySystem.Items.Firearms.Attachments;
using InventorySystem.Items.Firearms.BasicMessages;
using InventorySystem.Items.Firearms.Modules.Misc;
using InventorySystem.Items.Firearms.ShotEvents;
using NorthwoodLib.Pools;
using PlayerRoles;
using PlayerRoles.FirstPersonControl;
using PlayerRoles.Spectating;
using PlayerStatsSystem;
using UnityEngine;

namespace InventorySystem.Items.Firearms.Modules
{
	public abstract class HitscanHitregModuleBase : ModuleBase, IHitregModule, ICustomCrosshairItem, IDisplayableInaccuracyProviderModule, IInaccuracyProviderModule
	{
		public static readonly CachedLayerMask HitregMask = new CachedLayerMask("Default", "Hitbox", "Glass", "CCTV", "Door");

		private HitscanResult _resultNonAlloc;

		private ImpactEffectsModule _impactEffectsModule;

		private Footprint _cachedFootprint;

		private bool _footprintCacheSet;

		private float? _scheduledHitmarker;

		[field: SerializeField]
		public virtual float BaseDamage { get; protected set; }

		[field: SerializeField]
		[field: Range(0f, 1f)]
		public virtual float BasePenetration { get; protected set; }

		[field: SerializeField]
		public virtual float FullDamageDistance { get; protected set; }

		[field: SerializeField]
		public virtual float DamageFalloffDistance { get; protected set; }

		[field: SerializeField]
		public virtual float BaseBulletInaccuracy { get; private set; }

		public virtual float DisplayDamage => EffectiveDamage;

		public virtual float DisplayPenetration => EffectivePenetration;

		public virtual bool UseHitboxMultipliers => true;

		public virtual Type CrosshairType => typeof(SingleBulletFirearmCrosshair);

		public virtual float Inaccuracy => BaseBulletInaccuracy * base.Firearm.AttachmentsValue(AttachmentParam.BulletInaccuracyMultiplier);

		public virtual DisplayInaccuracyValues DisplayInaccuracy => new DisplayInaccuracyValues(0f, 0f, 0f, Inaccuracy);

		protected ReferenceHub PrimaryTarget { get; private set; }

		protected ShotEvent LastShotEvent { get; private set; }

		protected HitscanResult ResultNonAlloc => _resultNonAlloc ?? (_resultNonAlloc = new HitscanResult());

		protected Ray ForwardRay
		{
			get
			{
				Transform playerCameraReference = Owner.PlayerCameraReference;
				return new Ray(playerCameraReference.position, playerCameraReference.forward);
			}
		}

		protected float CurrentInaccuracy
		{
			get
			{
				float num = 0f;
				ModuleBase[] modules = base.Firearm.Modules;
				for (int i = 0; i < modules.Length; i++)
				{
					if (modules[i] is IInaccuracyProviderModule inaccuracyProviderModule)
					{
						num += inaccuracyProviderModule.Inaccuracy;
					}
				}
				return num;
			}
		}

		protected virtual float EffectiveDamage => BaseDamage * base.Firearm.AttachmentsValue(AttachmentParam.DamageMultiplier);

		protected virtual float EffectivePenetration => BasePenetration * base.Firearm.AttachmentsValue(AttachmentParam.PenetrationMultiplier);

		protected Footprint Footprint
		{
			get
			{
				if (!_footprintCacheSet)
				{
					_footprintCacheSet = true;
					_cachedFootprint = new Footprint(Owner);
				}
				return _cachedFootprint;
			}
			set
			{
				_cachedFootprint = value;
				_footprintCacheSet = true;
			}
		}

		private ReferenceHub Owner => base.Firearm.Owner;

		public static event Action<ReferenceHub, HitscanResult> ServerAnyPlayerFired;

		public event Action ServerOnFired;

		public void Fire(ReferenceHub primaryTarget, ShotEvent shotEvent)
		{
			PrimaryTarget = primaryTarget;
			LastShotEvent = shotEvent;
			EnableSelfDamageProtection();
			Fire();
			ServerOnFired?.Invoke();
			ServerAnyPlayerFired?.Invoke(Owner, _resultNonAlloc);
			RestoreHitboxes();
		}

		protected override void OnInit()
		{
			base.OnInit();
			if (!base.Firearm.TryGetModule<ImpactEffectsModule>(out _impactEffectsModule))
			{
				_impactEffectsModule = null;
			}
		}

		internal override void AlwaysUpdate()
		{
			base.AlwaysUpdate();
			if (_scheduledHitmarker.HasValue)
			{
				float num = HitmarkerSizeAtDamage(_scheduledHitmarker.Value);
				if (num > 0f)
				{
					Hitmarker.SendHitmarkerDirectly(Footprint.Hub, num);
				}
				_scheduledHitmarker = null;
			}
		}

		protected abstract void Fire();

		protected Ray RandomizeRay(Ray ray, float angle)
		{
			float num = Mathf.Max(UnityEngine.Random.value, UnityEngine.Random.value);
			Vector3 vector = UnityEngine.Random.insideUnitSphere * num;
			ray.direction = Quaternion.Euler(angle * vector) * ray.direction;
			return ray;
		}

		protected virtual float DamageAtDistance(float dist)
		{
			dist -= FullDamageDistance;
			if (dist <= 0f)
			{
				return EffectiveDamage;
			}
			float num = dist / DamageFalloffDistance;
			return EffectiveDamage * Mathf.Clamp01(1f - num);
		}

		protected virtual float HitmarkerSizeAtDamage(float damage)
		{
			return damage / EffectiveDamage;
		}

		protected void SendDamageIndicator(uint receiverNetId, float dmgDealt)
		{
			if (Footprint.Hub.roleManager.CurrentRole is IFpcRole fpcRole)
			{
				SendDamageIndicator(receiverNetId, dmgDealt, fpcRole.FpcModule.Position);
			}
		}

		protected void SendDamageIndicator(uint receiverNetId, float dmgDealt, Vector3 position)
		{
			if (ReferenceHub.TryGetHubNetID(receiverNetId, out var hub))
			{
				new DamageIndicatorMessage(dmgDealt, position).SendToSpectatorsOf(hub, includeTarget: true);
			}
		}

		protected HitscanResult ServerPrescan(Ray targetRay, bool nonAlloc = true)
		{
			HitscanResult hitscanResult;
			if (nonAlloc)
			{
				hitscanResult = ResultNonAlloc;
				hitscanResult.Clear();
			}
			else
			{
				hitscanResult = new HitscanResult();
			}
			ServerAppendPrescan(targetRay, hitscanResult);
			return hitscanResult;
		}

		protected void ServerAppendPrescan(Ray targetRay, HitscanResult toAppend)
		{
			float maxDistance = DamageFalloffDistance + FullDamageDistance;
			if (!Physics.Raycast(targetRay, out var hitInfo, maxDistance, HitregMask))
			{
				return;
			}
			if (hitInfo.collider.TryGetComponent<IDestructible>(out var component))
			{
				if (ValidateTarget(component, toAppend))
				{
					toAppend.Destructibles.Add(new DestructibleHitPair(component, hitInfo, targetRay));
				}
			}
			else
			{
				toAppend.Obstacles.Add(new HitRayPair(targetRay, hitInfo));
			}
		}

		protected virtual void ServerApplyDamage(HitscanResult result)
		{
			foreach (DestructibleHitPair destructible in result.Destructibles)
			{
				ServerApplyDestructibleDamage(destructible, result);
			}
			foreach (HitRayPair obstacle in result.Obstacles)
			{
				ServerApplyObstacleDamage(obstacle, result);
			}
			ServerSendAllIndicators(result);
		}

		protected virtual void ServerApplyObstacleDamage(HitRayPair hitInfo, HitscanResult result)
		{
			ServerPlayImpactEffects(hitInfo, allowBlood: false);
		}

		protected virtual void ServerApplyDestructibleDamage(DestructibleHitPair target, HitscanResult result)
		{
			float num = DamageAtDistance(target.Hit.distance);
			AttackerDamageHandler handler = GetHandler(num);
			IDestructible destructible = target.Destructible;
			if (destructible is HitboxIdentity hitboxIdentity && !hitboxIdentity.TargetHub.IsAlive())
			{
				result.RegisterDamage(destructible, num, handler);
				return;
			}
			Vector3 point = target.Hit.point;
			if (destructible.Damage(num, handler, point))
			{
				result.RegisterDamage(destructible, num, handler);
				ServerPlayImpactEffects(target.Raycast, num > 0f);
			}
		}

		protected virtual void ServerSendAllIndicators(HitscanResult result)
		{
			HashSet<uint> hashSet = HashSetPool<uint>.Shared.Rent();
			ServerAddHitmarkerDamage(result.OtherDamage);
			foreach (DestructibleDamageRecord damagedDestructible in result.DamagedDestructibles)
			{
				IDestructible destructible = damagedDestructible.Destructible;
				if (hashSet.Add(destructible.NetworkId))
				{
					float dmgDealt = result.CountDamage(destructible);
					SendDamageIndicator(destructible.NetworkId, dmgDealt);
				}
				if (!(destructible is HitboxIdentity hitboxIdentity))
				{
					ServerAddHitmarkerDamage(damagedDestructible.AppliedDamage);
				}
				else if (Hitmarker.CheckHitmarkerPerms(damagedDestructible.Handler, hitboxIdentity.TargetHub))
				{
					ServerAddHitmarkerDamage(damagedDestructible.AppliedDamage);
				}
			}
			AlwaysUpdate();
			HashSetPool<uint>.Shared.Return(hashSet);
		}

		protected virtual bool ValidateTarget(IDestructible target, HitscanResult resultThusFar)
		{
			if (!(target is HitboxIdentity hitboxIdentity))
			{
				return true;
			}
			if (PrimaryTarget == null)
			{
				return true;
			}
			if (hitboxIdentity.TargetHub == PrimaryTarget)
			{
				return true;
			}
			if (HitboxIdentity.IsEnemy(Owner, hitboxIdentity.TargetHub))
			{
				return true;
			}
			return false;
		}

		protected virtual AttackerDamageHandler GetHandler(float damageDealt)
		{
			return new FirearmDamageHandler(base.Firearm, damageDealt, EffectivePenetration, UseHitboxMultipliers);
		}

		protected void ServerAddHitmarkerDamage(float damageDealt)
		{
			float valueOrDefault = _scheduledHitmarker.GetValueOrDefault();
			if (!_scheduledHitmarker.HasValue)
			{
				valueOrDefault = 0f;
				_scheduledHitmarker = valueOrDefault;
			}
			_scheduledHitmarker += damageDealt;
		}

		protected void EnableSelfDamageProtection()
		{
			SetHitboxes(restore: false);
		}

		protected void RestoreHitboxes()
		{
			SetHitboxes(restore: true);
		}

		protected void ServerPlayImpactEffects(HitRayPair rc, bool allowBlood)
		{
			if ((object)_impactEffectsModule != null)
			{
				_impactEffectsModule.ServerProcessHit(rc.Hit, rc.Ray.origin, allowBlood);
			}
		}

		private void SetHitboxes(bool restore)
		{
			if (!(Owner == null))
			{
				ToggleColliders(Owner, !Owner.isLocalPlayer & restore);
				if (!(PrimaryTarget == null) && PrimaryTarget.isLocalPlayer)
				{
					ToggleColliders(PrimaryTarget, !restore);
				}
			}
		}

		private static void ToggleColliders(ReferenceHub target, bool state)
		{
			if (target.roleManager.CurrentRole is IFpcRole fpcRole)
			{
				fpcRole.FpcModule.CharacterModelInstance.Hitboxes.ForEach((HitboxIdentity x) =>
				{
					x.SetColliders(state);
				});
			}
		}
	}
}
