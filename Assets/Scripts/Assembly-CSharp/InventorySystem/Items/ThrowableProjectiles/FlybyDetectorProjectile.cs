using System.Collections.Generic;
using Mirror;
using Mirror.RemoteCalls;
using PlayerRoles;
using RelativePositioning;
using UnityEngine;

namespace InventorySystem.Items.ThrowableProjectiles
{
	public class FlybyDetectorProjectile : SingleTrajectoryProjectile
	{
		private enum FriendlyFireInteraction
		{
			UseFriendlyFireConfig = 0,
			CollideWithEveryone = 1,
			CollideWithOnlyEnemies = 2
		}

		private static readonly CachedLayerMask HitboxMask;

		private static readonly Collider[] Detections;

		private readonly HashSet<ReferenceHub> _alreadyHitPlayers = new HashSet<ReferenceHub>();

		private RelativePosition _prevPosition;

		private bool _stopped;

		[SerializeField]
		private float _selfDamageDelay;

		[SerializeField]
		private FriendlyFireInteraction _friendlyFireInteraction;

		[SerializeField]
		private bool _stopProjectileOnImpact;

		[SerializeField]
		private bool _allowMultipleTriggering;

		protected override bool AlreadyCollided
		{
			get
			{
				if (!base.AlreadyCollided)
				{
					return _stopped;
				}
				return true;
			}
		}

		protected override void Awake()
		{
			base.Awake();
			_prevPosition = new RelativePosition(base.Position);
		}

		protected override void Update()
		{
			base.Update();
			if (!NetworkServer.active || AlreadyCollided)
			{
				return;
			}
			_selfDamageDelay -= Time.deltaTime;
			int num = Physics.OverlapCapsuleNonAlloc(base.Position, _prevPosition.Position, base.ProjectileRadius, Detections, HitboxMask);
			for (int i = 0; i < num; i++)
			{
				if (!Detections[i].TryGetComponent<HitboxIdentity>(out var component))
				{
					continue;
				}
				ReferenceHub targetHub = component.TargetHub;
				if ((!(targetHub == PreviousOwner.Hub) || !(_selfDamageDelay > 0f)) && (_allowMultipleTriggering || _alreadyHitPlayers.Add(targetHub)) && _friendlyFireInteraction switch
				{
					FriendlyFireInteraction.CollideWithEveryone => true, 
					FriendlyFireInteraction.CollideWithOnlyEnemies => HitboxIdentity.IsEnemy(PreviousOwner.Role, targetHub.GetRoleId()), 
					FriendlyFireInteraction.UseFriendlyFireConfig => HitboxIdentity.IsDamageable(PreviousOwner.Role, targetHub.GetRoleId()), 
					_ => false, 
				})
				{
					ServerProcessHit(component);
					if (_stopProjectileOnImpact)
					{
						RpcStopProjectile();
						break;
					}
				}
			}
			_prevPosition = new RelativePosition(base.Position);
		}

		public virtual void ServerProcessHit(HitboxIdentity hid)
		{
		}

		[ClientRpc]
		public void RpcStopProjectile()
		{
			NetworkWriterPooled writer = NetworkWriterPool.Get();
			SendRPCInternal("System.Void InventorySystem.Items.ThrowableProjectiles.FlybyDetectorProjectile::RpcStopProjectile()", 646104935, writer, 0, includeOwner: true);
			NetworkWriterPool.Return(writer);
		}

		static FlybyDetectorProjectile()
		{
			HitboxMask = new CachedLayerMask("Hitbox");
			Detections = new Collider[16];
			RemoteProcedureCalls.RegisterRpc(typeof(FlybyDetectorProjectile), "System.Void InventorySystem.Items.ThrowableProjectiles.FlybyDetectorProjectile::RpcStopProjectile()", InvokeUserCode_RpcStopProjectile);
		}

		public override bool Weaved()
		{
			return true;
		}

		protected void UserCode_RpcStopProjectile()
		{
			_stopped = true;
		}

		protected static void InvokeUserCode_RpcStopProjectile(NetworkBehaviour obj, NetworkReader reader, NetworkConnectionToClient senderConnection)
		{
			if (!NetworkClient.active)
			{
				Debug.LogError("RPC RpcStopProjectile called on server.");
			}
			else
			{
				((FlybyDetectorProjectile)obj).UserCode_RpcStopProjectile();
			}
		}
	}
}
