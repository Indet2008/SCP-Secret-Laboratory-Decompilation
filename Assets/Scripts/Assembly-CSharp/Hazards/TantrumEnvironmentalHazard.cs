using System.Collections.Generic;
using System.Runtime.CompilerServices;
using System.Runtime.InteropServices;
using CustomPlayerEffects;
using Footprinting;
using InventorySystem.Items.ThrowableProjectiles;
using InventorySystem.Items.Usables.Scp244;
using LabApi.Events.Arguments.PlayerEvents;
using LabApi.Events.Handlers;
using MEC;
using Mirror;
using Mirror.RemoteCalls;
using PlayerRoles;
using RelativePositioning;
using UnityEngine;

namespace Hazards
{
	public class TantrumEnvironmentalHazard : TemporaryHazard
	{
		// Client-only serialized fields restored from the v14 client layout (server build stripped them).
		[global::UnityEngine.SerializeField]
		private global::UnityEngine.Animator _animator;

		[global::UnityEngine.SerializeField]
		private global::UnityEngine.Rendering.HighDefinition.DecalProjector _decal;

		[global::UnityEngine.SerializeField]
		private float _dissolveSpeed;


		public static readonly List<TantrumEnvironmentalHazard> AllTantrums;

		private const float ExplosionHeight = 5f;

		private const float DelayedDestroy = 6f;

		[CompilerGenerated]
		[SyncVar]
		private RelativePosition SynchronizedPosition__BackingField;

		private float _decaySpeedOverride = -1f;

		private readonly float _explodeDistance = 5.25f;

		[SerializeField]
		private Transform _correctPosition;

		public override Vector3 SourcePosition
		{
			get
			{
				return _correctPosition.position + SourceOffset;
			}
			set
			{
				base.transform.position = value;
			}
		}

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

		public bool PlaySizzle { get; set; }

		public override float HazardDuration { get; set; } = 180f;

		public override float DecaySpeed
		{
			get
			{
				if (_decaySpeedOverride >= 0f)
				{
					return _decaySpeedOverride;
				}
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
			if (!IsActive || player.IsSCP())
			{
				return false;
			}
			if (!base.OnEnter(player))
			{
				return false;
			}
			player.playerEffectsController.EnableEffect<Stained>(1f);
			PlayerEvents.OnEnteredHazard(new PlayerEnteredHazardEventArgs(player, this));
			return true;
		}

		public override void OnStay(ReferenceHub player)
		{
			player.playerEffectsController.EnableEffect<Stained>(1f);
		}

		public override bool OnExit(ReferenceHub player)
		{
			if (!base.OnExit(player))
			{
				return false;
			}
			if (!IsActive || player.IsSCP())
			{
				return false;
			}
			player.playerEffectsController.EnableEffect<Stained>(2f);
			PlayerEvents.OnLeftHazard(new PlayerLeftHazardEventArgs(player, this));
			return true;
		}

		protected override void Start()
		{
			base.Start();
			ClientApplyDecalSize();
			if (NetworkServer.active)
			{
				AllTantrums.Add(this);
				ExplosionGrenade.OnExploded += CheckExplosion;
			}
		}

		[Server]
		public override void ServerDestroy()
		{
			if (!NetworkServer.active)
			{
				Debug.LogWarning("[Server] function 'System.Void Hazards.TantrumEnvironmentalHazard::ServerDestroy()' called when server was not active");
				return;
			}
			base.ServerDestroy();
			RpcDespawn(PlaySizzle);
			ServerDelayedDestroy(6f);
		}

		protected override void OnDestroy()
		{
			base.OnDestroy();
			if (NetworkServer.active)
			{
				AllTantrums.Remove(this);
				ExplosionGrenade.OnExploded -= CheckExplosion;
			}
		}

		[ClientRpc]
		private void RpcDespawn(bool playSizzle)
		{
			NetworkWriterPooled writer = NetworkWriterPool.Get();
			writer.WriteBool(playSizzle);
			SendRPCInternal("System.Void Hazards.TantrumEnvironmentalHazard::RpcDespawn(System.Boolean)", -963326249, writer, 0, includeOwner: true);
			NetworkWriterPool.Return(writer);
		}

		private void ServerDelayedDestroy(float waitTime)
		{
			if (NetworkServer.active)
			{
				Timing.RunCoroutine(DelayedPuddleRemoval(waitTime).CancelWith(base.gameObject));
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
					PlaySizzle = true;
					ServerDestroy();
				}
			}
		}

		private void ClientApplyDecalSize()
		{
		}

		private IEnumerator<float> DelayedPuddleRemoval(float waitTime)
		{
			yield return Timing.WaitForSeconds(waitTime);
			NetworkServer.Destroy(base.gameObject);
		}

		static TantrumEnvironmentalHazard()
		{
			AllTantrums = new List<TantrumEnvironmentalHazard>();
			RemoteProcedureCalls.RegisterRpc(typeof(TantrumEnvironmentalHazard), "System.Void Hazards.TantrumEnvironmentalHazard::RpcDespawn(System.Boolean)", InvokeUserCode_RpcDespawn__Boolean);
		}

		public override bool Weaved()
		{
			return true;
		}

		protected void UserCode_RpcDespawn__Boolean(bool playSizzle)
		{
		}

		protected static void InvokeUserCode_RpcDespawn__Boolean(NetworkBehaviour obj, NetworkReader reader, NetworkConnectionToClient senderConnection)
		{
			if (!NetworkClient.active)
			{
				Debug.LogError("RPC RpcDespawn called on server.");
			}
			else
			{
				((TantrumEnvironmentalHazard)obj).UserCode_RpcDespawn__Boolean(reader.ReadBool());
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
