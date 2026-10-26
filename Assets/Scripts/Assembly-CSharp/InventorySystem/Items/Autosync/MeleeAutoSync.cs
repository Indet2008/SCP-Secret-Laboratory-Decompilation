using System.Collections.Generic;
using DrawableLine;
using Mirror;
using NorthwoodLib.Pools;
using PlayerRoles.FirstPersonControl;
using RelativePositioning;
using UnityEngine;
using Utils.Networking;
using Utils.NonAllocLINQ;

namespace InventorySystem.Items.Autosync
{
	public abstract class MeleeAutoSync : AutosyncItem
	{
		public enum HitResult
		{
			HitPlayer = 0,
			KilledPlayer = 1,
			HitWall = 2,
			Missed = 3
		}

		private const int MaxDetections = 128;

		private static readonly Collider[] DetectedColliders = new Collider[128];

		private static readonly IDestructible[] DetectedDestructibles = new IDestructible[128];

		private static readonly HashSet<uint> DetectedNetIds = new HashSet<uint>();

		private static readonly HashSet<ReferenceHub> DetectedHubs = new HashSet<ReferenceHub>();

		private static readonly HashSet<FpcBacktracker> BacktrackedPlayers = new HashSet<FpcBacktracker>();

		private static int _detectionsLen;

		public float MeleeDamage;

		public virtual float HitregRadius => 1.5f;

		public virtual float HitregOffset => 1.5f;

		public virtual float MaxDotProduct => 0.05f;

		public virtual CachedLayerMask DetectionMask => new CachedLayerMask("Hitbox", "Glass");

		public virtual CachedLayerMask LinecastMask { get; } = new CachedLayerMask("Default", "InvisibleCollider", "Fence", "Door", "Glass");

		public virtual CachedLayerMask BreakableLinecastMask { get; } = new CachedLayerMask("Default", "InvisibleCollider", "Fence", "Door");

		public virtual CachedLayerMask HitWallMask { get; } = new CachedLayerMask("Default", "Glass");

		public abstract byte AttackPreformedByte { get; }

		public bool AnyDetected
		{
			get
			{
				DetectDestructibles();
				return _detectionsLen > 0;
			}
		}

		public bool ClientTryAttack()
		{
			if (!(base.Owner.roleManager.CurrentRole is IFpcRole fpcRole))
			{
				return false;
			}
			NetworkWriter writer;
			using (new AutosyncCmd(base.ItemId, out writer))
			{
				writer.WriteByte(AttackPreformedByte);
				writer.WriteRelativePosition(new RelativePosition(fpcRole.FpcModule.Position));
				writer.WriteQuaternion(base.Owner.PlayerCameraReference.rotation);
				DetectDestructibles();
				if (_detectionsLen > 255)
				{
					_detectionsLen = 255;
				}
				List<ReferenceHub> list = ListPool<ReferenceHub>.Shared.Rent(_detectionsLen);
				for (int i = 0; i < _detectionsLen; i++)
				{
					if (DetectedDestructibles[i] is HitboxIdentity hitboxIdentity)
					{
						list.Add(hitboxIdentity.TargetHub);
					}
				}
				writer.WriteByte((byte)list.Count);
				foreach (ReferenceHub item in list)
				{
					writer.WriteReferenceHub(item);
					writer.WriteRelativePosition(new RelativePosition(item));
				}
				ListPool<ReferenceHub>.Shared.Return(list);
			}
			return true;
		}

		public HitResult ServerAttack(NetworkReader reader)
		{
			if (reader != null)
			{
				RelativePosition relativePosition = reader.ReadRelativePosition();
				Quaternion claimedRot = reader.ReadQuaternion();
				BacktrackedPlayers.Add(new FpcBacktracker(base.Owner, relativePosition.Position, claimedRot));
				byte b = reader.ReadByte();
				for (int i = 0; i < b; i++)
				{
					bool num = reader.TryReadReferenceHub(out var hub);
					RelativePosition relativePosition2 = reader.ReadRelativePosition();
					if (num)
					{
						BacktrackedPlayers.Add(new FpcBacktracker(hub, relativePosition2.Position));
					}
				}
			}
			DetectDestructibles();
			bool flag = false;
			_ = base.Owner.PlayerCameraReference.forward;
			ReferenceHub primaryTarget = DetectedHubs.GetPrimaryTarget(base.Owner.PlayerCameraReference);
			for (int j = 0; j < _detectionsLen; j++)
			{
				IDestructible destructible = DetectedDestructibles[j];
				bool isPrimaryTarget = destructible is HitboxIdentity hitboxIdentity && hitboxIdentity.TargetHub == primaryTarget;
				if (ApplyDamage(base.Owner, destructible, MeleeDamage, destructible.CenterOfMass, isPrimaryTarget))
				{
					flag = true;
				}
			}
			BacktrackedPlayers.ForEach((FpcBacktracker x) =>
			{
				x.RestorePosition();
			});
			BacktrackedPlayers.Clear();
			if (!flag && Physics.Raycast(base.Owner.PlayerCameraReference.position, base.Owner.PlayerCameraReference.forward, HitregRadius, HitWallMask))
			{
				return HitResult.HitWall;
			}
			if (!flag)
			{
				return HitResult.Missed;
			}
			return HitResult.HitPlayer;
		}

		public abstract bool ApplyDamage(ReferenceHub attacker, IDestructible victim, float damage, Vector3 direction, bool isPrimaryTarget);

		private void DetectDestructibles()
		{
			Transform playerCameraReference = base.Owner.PlayerCameraReference;
			Vector3 position = playerCameraReference.position + playerCameraReference.forward * HitregOffset;
			_detectionsLen = 0;
			int num = Physics.OverlapSphereNonAlloc(position, HitregRadius, DetectedColliders, DetectionMask);
			if (num == 0)
			{
				return;
			}
			DetectedNetIds.Clear();
			DetectedHubs.Clear();
			for (int i = 0; i < num; i++)
			{
				if (!DetectedColliders[i].TryGetComponent<IDestructible>(out var component) || component.NetworkId == base.Owner.netId)
				{
					continue;
				}
				Vector3 vector = component.CenterOfMass - playerCameraReference.position;
				float sqrMagnitude = vector.sqrMagnitude;
				Vector3 forward = playerCameraReference.forward;
				if (Vector3.Dot(vector / Mathf.Sqrt(sqrMagnitude), forward) <= MaxDotProduct)
				{
					continue;
				}
				bool flag = component is BreakableWindow;
				if (!Physics.Linecast(playerCameraReference.position, component.CenterOfMass, out var _, flag ? BreakableLinecastMask : LinecastMask) && DetectedNetIds.Add(component.NetworkId))
				{
					bool flag2 = ReferenceHub.TryGetHubNetID(component.NetworkId, out var hub);
					if ((!flag2 || !Physics.Linecast(playerCameraReference.position, hub.GetPosition(), out var _, LinecastMask)) && (!flag2 || HitboxIdentity.IsDamageable(base.Owner, hub)) && (!flag2 || DetectedHubs.Add(hub)))
					{
						DrawableLines.GenerateLine(playerCameraReference.position, component.CenterOfMass);
						DetectedDestructibles[_detectionsLen++] = component;
					}
				}
			}
		}
	}
}
