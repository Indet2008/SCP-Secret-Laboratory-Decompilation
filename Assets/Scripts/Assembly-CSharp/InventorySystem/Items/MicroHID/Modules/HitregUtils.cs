using System;
using System.Collections.Generic;
using PlayerRoles;
using PlayerStatsSystem;
using UnityEngine;

namespace InventorySystem.Items.MicroHID.Modules
{
	public static class HitregUtils
	{
		public static readonly CachedLayerMask DetectionMask = new CachedLayerMask("Hitbox", "Glass", "Door");

		public static readonly Collider[] DetectionsNonAlloc = new Collider[64];

		public static readonly RaycastHit[] HitsNonAlloc = new RaycastHit[64];

		public static readonly HashSet<uint> DetectedNetIds = new HashSet<uint>();

		public static readonly List<IDestructible> DetectedDestructibles = new List<IDestructible>();

		public static bool ServerDealDamage(this IDestructible target, FiringModeControllerModule firingCtrl, float damage)
		{
			MicroHidDamageHandler microHidDamageHandler = new MicroHidDamageHandler(firingCtrl, damage);
			if (!target.Damage(damage, microHidDamageHandler, target.CenterOfMass))
			{
				return false;
			}
			if (target is HitboxIdentity hitboxIdentity)
			{
				Hitmarker.SendHitmarkerConditionally(1f, microHidDamageHandler, hitboxIdentity.TargetHub);
			}
			else
			{
				Hitmarker.SendHitmarkerDirectly(firingCtrl.MicroHid.Owner, 1f);
			}
			return true;
		}

		public static void Raycast(Transform plyCam, float thickness, float range, out int detections)
		{
			Vector3 position = plyCam.position;
			detections = Physics.SphereCastNonAlloc(position, thickness, plyCam.forward, HitsNonAlloc, range, DetectionMask);
			DetectedDestructibles.Clear();
			DetectedNetIds.Clear();
			for (int i = 0; i < detections; i++)
			{
				Collider collider = HitsNonAlloc[i].collider;
				DetectionsNonAlloc[i] = collider;
				if (collider.TryGetComponent<IDestructible>(out var component) && (!Physics.Linecast(position, component.CenterOfMass, out var hitInfo, PlayerRolesUtils.AttackMask) || !(hitInfo.collider != collider)) && DetectedNetIds.Add(component.NetworkId))
				{
					DetectedDestructibles.Add(component);
				}
			}
		}

		public static void OverlapSphere(Vector3 point, float radius, out int detections, Predicate<IDestructible> prevalidator = null)
		{
			detections = Physics.OverlapSphereNonAlloc(point, radius, DetectionsNonAlloc, DetectionMask);
			DetectedDestructibles.Clear();
			DetectedNetIds.Clear();
			for (int i = 0; i < detections; i++)
			{
				if (DetectionsNonAlloc[i].TryGetComponent<IDestructible>(out var component) && !Physics.Linecast(point, component.CenterOfMass, PlayerRolesUtils.AttackMask) && (prevalidator == null || prevalidator(component)) && DetectedNetIds.Add(component.NetworkId))
				{
					DetectedDestructibles.Add(component);
				}
			}
		}
	}
}
