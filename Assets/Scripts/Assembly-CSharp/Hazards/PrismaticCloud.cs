using System.Collections.Generic;
using System.Runtime.CompilerServices;
using System.Runtime.InteropServices;
using CustomPlayerEffects;
using Footprinting;
using InventorySystem.Items.ThrowableProjectiles;
using InventorySystem.Items.Usables.Scp244;
using MEC;
using Mirror;
using Mirror.RemoteCalls;
using NorthwoodLib.Pools;
using PlayerRoles;
using RelativePositioning;
using UnityEngine;

namespace Hazards
{
	public class PrismaticCloud : TemporaryHazard
	{
		public static readonly List<PrismaticCloud> Instances;

		public const float EffectDuration = 3f;

		private const float ExplosionHeight = 5f;

		private const float DelayedDestroy = 15f;

		[CompilerGenerated]
		[SyncVar]
		private RelativePosition SynchronizedPosition__BackingField;

		private readonly float _explodeDistance = 5.25f;

		[SerializeField]
		private Transform _correctPosition;

		[SerializeField]
		private ParticleSystem _particles;

		public override Vector3 SourcePosition
		{
			get
			{
				return _correctPosition.position + SourceOffset;
			}
			set
			{
				_correctPosition.position = value;
			}
		}

		public List<ReferenceHub> IgnoredTargets { get; private set; } = ListPool<ReferenceHub>.Shared.Rent();

		public RelativePosition SynchronizedPosition
		{
			[CompilerGenerated]
			get
			{
				return SynchronizedPosition__BackingField;
			}
			[CompilerGenerated]
			set
			{
				Network_003CSynchronizedPosition_003Ek__BackingField = value;
			}
		}

		public override float HazardDuration { get; set; } = 30f;

		public override float DecaySpeed
		{
			get
			{
				float num = 1f;
				foreach (Scp244DeployablePickup instance in Scp244DeployablePickup.Instances)
				{
					num += instance.FogPercentForPoint(SourcePosition);
				}
				return num;
			}
		}

		public RelativePosition Network_003CSynchronizedPosition_003Ek__BackingField
		{
			get
			{
				return SynchronizedPosition;
			}
			[param: In]
			set
			{
				GeneratedSyncVarSetter(value, ref SynchronizedPosition__BackingField, 1uL, null);
			}
		}

		public override bool OnEnter(ReferenceHub player)
		{
			if (!IsActive || player.IsSCP() || IgnoredTargets.Contains(player))
			{
				return false;
			}
			ServerEnableEffect(player);
			return base.OnEnter(player);
		}

		public override void OnStay(ReferenceHub player)
		{
			if (!IgnoredTargets.Contains(player))
			{
				ServerEnableEffect(player);
			}
		}

		public override bool OnExit(ReferenceHub player)
		{
			if (!IsActive || player.IsSCP() || IgnoredTargets.Contains(player))
			{
				return false;
			}
			ServerEnableEffect(player, changeOrigin: false);
			return base.OnExit(player);
		}

		protected override void Start()
		{
			base.Start();
			if (NetworkServer.active)
			{
				Instances.Add(this);
				ExplosionGrenade.OnExploded += CheckExplosion;
			}
		}

		[Server]
		public override void ServerDestroy()
		{
			if (!NetworkServer.active)
			{
				Debug.LogWarning("[Server] function 'System.Void Hazards.PrismaticCloud::ServerDestroy()' called when server was not active");
				return;
			}
			base.ServerDestroy();
			ServerDelayedDestroy(15f);
			RpcDespawn();
		}

		protected override void OnDestroy()
		{
			base.OnDestroy();
			ListPool<ReferenceHub>.Shared.Return(IgnoredTargets);
			if (NetworkServer.active)
			{
				Instances.Remove(this);
				ExplosionGrenade.OnExploded -= CheckExplosion;
			}
		}

		[ClientRpc]
		private void RpcDespawn()
		{
			NetworkWriterPooled writer = NetworkWriterPool.Get();
			SendRPCInternal("System.Void Hazards.PrismaticCloud::RpcDespawn()", -2006036242, writer, 0, includeOwner: true);
			NetworkWriterPool.Return(writer);
		}

		private void ServerEnableEffect(ReferenceHub target, bool changeOrigin = true)
		{
			Prismatic prismatic = target.playerEffectsController.EnableEffect<Prismatic>(3f);
			if (changeOrigin)
			{
				prismatic.OriginCloud = this;
			}
		}

		private void ServerDelayedDestroy(float waitTime)
		{
			if (NetworkServer.active)
			{
				Timing.RunCoroutine(DelayedRemoval(waitTime).CancelWith(base.gameObject));
			}
		}

		private void LateUpdate()
		{
			SourcePosition = SynchronizedPosition.Position;
		}

		private void CheckExplosion(Footprint attacker, Vector3 pos, ExplosionGrenade grenade)
		{
			Vector3 position = _correctPosition.position;
			if (!(Mathf.Abs(pos.y - position.y) > 5f))
			{
				float num = _explodeDistance * _explodeDistance;
				if (!((position - pos).SqrMagnitudeIgnoreY() > num))
				{
					ServerDestroy();
				}
			}
		}

		private IEnumerator<float> DelayedRemoval(float waitTime)
		{
			yield return Timing.WaitForSeconds(waitTime);
			NetworkServer.Destroy(base.gameObject);
		}

		static PrismaticCloud()
		{
			Instances = new List<PrismaticCloud>();
			RemoteProcedureCalls.RegisterRpc(typeof(PrismaticCloud), "System.Void Hazards.PrismaticCloud::RpcDespawn()", InvokeUserCode_RpcDespawn);
		}

		public override bool Weaved()
		{
			return true;
		}

		protected void UserCode_RpcDespawn()
		{
			_particles.Stop();
		}

		protected static void InvokeUserCode_RpcDespawn(NetworkBehaviour obj, NetworkReader reader, NetworkConnectionToClient senderConnection)
		{
			if (!NetworkClient.active)
			{
				Debug.LogError("RPC RpcDespawn called on server.");
			}
			else
			{
				((PrismaticCloud)obj).UserCode_RpcDespawn();
			}
		}

		protected override void SerializeSyncVars(NetworkWriter writer, bool forceAll)
		{
			base.SerializeSyncVars(writer, forceAll);
			if (forceAll)
			{
				writer.WriteRelativePosition(SynchronizedPosition);
				return;
			}
			writer.WriteULong(base.syncVarDirtyBits);
			if ((base.syncVarDirtyBits & 1L) != 0L)
			{
				writer.WriteRelativePosition(SynchronizedPosition);
			}
		}

		protected override void DeserializeSyncVars(NetworkReader reader, bool initialState)
		{
			base.DeserializeSyncVars(reader, initialState);
			if (initialState)
			{
				GeneratedSyncVarDeserialize(ref SynchronizedPosition__BackingField, null, reader.ReadRelativePosition());
				return;
			}
			long num = (long)reader.ReadULong();
			if ((num & 1L) != 0L)
			{
				GeneratedSyncVarDeserialize(ref SynchronizedPosition__BackingField, null, reader.ReadRelativePosition());
			}
		}
	}
}
