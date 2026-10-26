using GameObjectPools;
using InventorySystem.Items;
using LabApi.Events.Arguments.Scp106Events;
using LabApi.Events.Handlers;
using Mirror;
using PlayerRoles.Spectating;
using UnityEngine;

namespace PlayerRoles.PlayableScps.Scp106
{
	public class Scp106StalkAbility : Scp106VigorAbilityBase, IPoolResettable, IInteractionBlocker
	{
		private enum RpcType
		{
			StalkActive = 0,
			StalkInactive = 1,
			NotEnoughVigor = 2
		}

		private const float VigorRegeneration = 0.03f;

		private const float VigorStalkCostStationary = 0.06f;

		private const float VigorStalkCostMoving = 0.09f;

		private const float MinVigorToSubmerge = 0.35f;

		private const BlockedInteraction Interactions = BlockedInteraction.All;

		private const float MovementRange = 5f;

		private const double MovementTimer = 2.0;

		private const float EmergeNoticeRange = 4f;

		private bool _valueDirty;

		private Scp106SinkholeController _sinkhole;

		private double _movementTime;

		private Vector3 _lastPosition;

		private bool _isMoving;

		private RpcType _rpcType;

		[SerializeField]
		private CooldownAudio _cooldownAudio;

		protected override ActionName TargetKey => ActionName.Run;

		public override bool ServerWantsSubmerged => StalkActive;

		public BlockedInteraction BlockedInteractions => BlockedInteraction.All;

		public bool CanBeCleared => !StalkActive;

		public bool StalkActive { get; private set; }

		private void UpdateServerside()
		{
			if (_valueDirty)
			{
				_valueDirty = false;
				ServerSendRpc(toAll: true);
			}
			if (_sinkhole.IsDuringAnimation)
			{
				return;
			}
			if (StalkActive)
			{
				float num = (base.CastRole.FpcModule.Motor.MovementDetected ? 0.09f : 0.06f);
				base.VigorAmount -= Time.deltaTime * num;
				if (base.VigorAmount == 0f && base.CastRole.FpcModule.IsGrounded)
				{
					ServerSetStalk(stalkActive: false);
				}
			}
			else
			{
				UpdateMovementState();
			}
		}

		private void UpdateMovementState()
		{
			if (Vector3.Distance(_lastPosition, base.Owner.transform.position) > 5f)
			{
				_lastPosition = base.Owner.transform.position;
				_movementTime = NetworkTime.time + 2.0;
				_isMoving = true;
			}
			if (NetworkTime.time > _movementTime)
			{
				_isMoving = false;
			}
			if (_isMoving)
			{
				base.VigorAmount += 0.03f * Time.deltaTime;
			}
		}

		protected override void Awake()
		{
			base.Awake();
			_sinkhole = base.CastRole.Sinkhole;
			PlayerRoleManager.OnRoleChanged += (ReferenceHub hub, PlayerRoleBase old, PlayerRoleBase cur) =>
			{
				if (NetworkServer.active && cur is SpectatorRole)
				{
					ServerSendRpc(hub);
				}
			};
		}

		protected override void Update()
		{
			base.Update();
			if (NetworkServer.active)
			{
				UpdateServerside();
			}
		}

		protected override void OnKeyDown()
		{
			base.OnKeyDown();
			if (!_sinkhole.ReadonlyCooldown.IsReady)
			{
				Scp106Hud.PlayFlash(vigor: false);
			}
			ClientSendCmd();
		}

		public override void ServerProcessCmd(NetworkReader reader)
		{
			base.ServerProcessCmd(reader);
			if (_sinkhole.IsDuringAnimation || !_sinkhole.ReadonlyCooldown.IsReady || !base.CastRole.FpcModule.IsGrounded)
			{
				return;
			}
			if (StalkActive)
			{
				ServerSetStalk(stalkActive: false);
			}
			else if (base.VigorAmount < 0.35f)
			{
				if (base.Role.IsLocalPlayer)
				{
					Scp106Hud.PlayFlash(vigor: true);
				}
				_rpcType = RpcType.NotEnoughVigor;
				ServerSendRpc(toAll: false);
			}
			else
			{
				ServerSetStalk(stalkActive: true);
			}
		}

		public override void ServerWriteRpc(NetworkWriter writer)
		{
			base.ServerWriteRpc(writer);
			writer.WriteByte((byte)_rpcType);
			if (_rpcType == RpcType.StalkInactive)
			{
				writer.WriteVector3(base.Owner.transform.position);
			}
		}

		public override void ClientProcessRpc(NetworkReader reader)
		{
			base.ClientProcessRpc(reader);
			if (NetworkServer.activeHost)
			{
				return;
			}
			switch ((RpcType)reader.ReadByte())
			{
			case RpcType.NotEnoughVigor:
				Scp106Hud.PlayFlash(vigor: true);
				break;
			case RpcType.StalkActive:
				if (!StalkActive)
				{
					StalkActive = true;
				}
				break;
			case RpcType.StalkInactive:
				if (StalkActive)
				{
					StalkActive = false;
					_sinkhole.PlayEmergenceAlert(reader.ReadVector3(), 4f);
				}
				break;
			}
		}

		public override void ResetObject()
		{
			base.ResetObject();
			StalkActive = false;
			_isMoving = false;
		}

		private void ServerSetStalk(bool stalkActive)
		{
			if (StalkActive != stalkActive)
			{
				Scp106ChangingStalkModeEventArgs e = new Scp106ChangingStalkModeEventArgs(base.Owner, stalkActive);
				Scp106Events.OnChangingStalkMode(e);
				if (e.IsAllowed)
				{
					StalkActive = stalkActive;
					Scp106Events.OnChangedStalkMode(new Scp106ChangedStalkModeEventArgs(base.Owner, stalkActive));
					base.Owner.interCoordinator.AddBlocker(this);
					_rpcType = ((!stalkActive) ? RpcType.StalkInactive : RpcType.StalkActive);
					ServerSendRpc(toAll: true);
				}
			}
		}
	}
}
