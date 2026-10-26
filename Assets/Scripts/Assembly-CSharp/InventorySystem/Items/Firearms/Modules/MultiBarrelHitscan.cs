using System;
using InventorySystem.Items.Firearms.ShotEvents;
using UnityEngine;

namespace InventorySystem.Items.Firearms.Modules
{
	public class MultiBarrelHitscan : HitscanHitregModuleBase
	{
		[Serializable]
		private struct BarrelOffset
		{
			public float RightPosition;

			public float TopPosition;

			public float RightDirection;

			public float TopDirection;
		}

		private Ray? _lastRay;

		[SerializeField]
		private BarrelOffset[] _barrels;

		internal override void EquipUpdate()
		{
			base.EquipUpdate();
			_lastRay = null;
		}

		protected override float HitmarkerSizeAtDamage(float damage)
		{
			return Mathf.Clamp01(base.HitmarkerSizeAtDamage(damage));
		}

		protected override void Fire()
		{
			Ray valueOrDefault = _lastRay.GetValueOrDefault();
			if (!_lastRay.HasValue)
			{
				valueOrDefault = RandomizeRay(base.ForwardRay, base.CurrentInaccuracy);
				_lastRay = valueOrDefault;
			}
			if (!(base.LastShotEvent is BulletShotEvent bulletShotEvent) || !_barrels.TryGet(bulletShotEvent.BarrelId, out var element))
			{
				ServerApplyDamage(ServerPrescan(_lastRay.Value));
			}
			else
			{
				ShootOffset(element);
			}
		}

		private void ShootOffset(BarrelOffset offset)
		{
			Transform playerCameraReference = base.Firearm.Owner.PlayerCameraReference;
			Vector3 origin = _lastRay.Value.origin;
			origin += playerCameraReference.up * offset.TopPosition;
			origin += playerCameraReference.right * offset.RightPosition;
			Vector3 direction = _lastRay.Value.direction;
			direction += Vector3.up * offset.TopDirection;
			Ray targetRay = new Ray(origin, (direction + Vector3.right * offset.RightDirection).normalized);
			ServerApplyDamage(ServerPrescan(targetRay));
		}
	}
}
