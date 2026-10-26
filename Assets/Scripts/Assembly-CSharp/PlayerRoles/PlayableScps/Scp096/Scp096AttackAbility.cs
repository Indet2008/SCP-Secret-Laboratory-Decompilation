using System;
using System.Collections.Generic;
using CustomPlayerEffects;
using GameObjectPools;
using Mirror;
using PlayerRoles.FirstPersonControl;
using PlayerRoles.Spectating;
using PlayerRoles.Subroutines;
using PlayerStatsSystem;
using RelativePositioning;
using UnityEngine;
using Utils.Networking;

namespace PlayerRoles.PlayableScps.Scp096
{
	public class Scp096AttackAbility : KeySubroutine<Scp096Role>, IPoolResettable
	{
		public const float DefaultAttackCooldown = 0.5f;

		private const float HumanDamage = 60f;

		private const float ConcussionDuration = 2.5f;

		private const float DoorDamage = 250f;

		private const int WindowDamage = 500;

		private const float BacktrackingDisSqr = 9f;

		private const byte LeftAttackSyncCode = 64;

		[SerializeField]
		private float _sphereHitboxRadius;

		[SerializeField]
		private float _sphereHitboxOffset;

		private static readonly List<FpcBacktracker> BacktrackedPlayers = new List<FpcBacktracker>();

		private static readonly List<ReferenceHub> PlayersToSend = new List<ReferenceHub>();

		private readonly AbilityCooldown _clientAttackCooldown = new AbilityCooldown();

		private readonly TolerantAbilityCooldown _serverAttackCooldown = new TolerantAbilityCooldown();

		private Scp096HitHandler _leftHitHandler;

		private Scp096HitHandler _rightHitHandler;

		private Scp096AudioPlayer _audioPlayer;

		private Scp096HitResult _hitResult;

		private bool AttackPossible
		{
			get
			{
				if (base.CastRole.IsRageState(Scp096RageState.Enraged))
				{
					return base.CastRole.IsAbilityState(Scp096AbilityState.None);
				}
				return false;
			}
		}

		protected override ActionName TargetKey => ActionName.Shoot;

		public bool LeftAttack { get; private set; }

		public event Action<Scp096HitResult> OnHitReceived;

		public event Action OnAttackTriggered;

		public override void ServerWriteRpc(NetworkWriter writer)
		{
			base.ServerWriteRpc(writer);
			byte b = (byte)_hitResult;
			if (LeftAttack)
			{
				b |= 0x40;
			}
			writer.WriteByte(b);
		}

		public override void ClientProcessRpc(NetworkReader reader)
		{
			base.ClientProcessRpc(reader);
			byte b = reader.ReadByte();
			LeftAttack = (b & 0x40) != 0;
			Scp096HitResult scp096HitResult = (Scp096HitResult)(b & -65);
			OnHitReceived?.Invoke(scp096HitResult);
			if (scp096HitResult != Scp096HitResult.None && (base.Owner.isLocalPlayer || base.Owner.IsLocallySpectated()))
			{
				Hitmarker.PlayHitmarker(1f);
			}
		}

		public override void ClientWriteCmd(NetworkWriter writer)
		{
			base.ClientWriteCmd(writer);
			writer.WriteRelativePosition(new RelativePosition(base.CastRole.FpcModule.Position));
			writer.WriteQuaternion(base.Owner.PlayerCameraReference.rotation);
			foreach (ReferenceHub item in PlayersToSend)
			{
				if (item.roleManager.CurrentRole is IFpcRole fpcRole)
				{
					Vector3 position = fpcRole.FpcModule.Position;
					writer.WriteReferenceHub(item);
					writer.WriteRelativePosition(new RelativePosition(position));
				}
			}
		}

		public override void ServerProcessCmd(NetworkReader reader)
		{
			base.ServerProcessCmd(reader);
			if (!_serverAttackCooldown.TolerantIsReady || !AttackPossible)
			{
				return;
			}
			BacktrackedPlayers.Clear();
			RelativePosition relativePosition = reader.ReadRelativePosition();
			BacktrackedPlayers.Add(new FpcBacktracker(base.Owner, relativePosition.Position, reader.ReadQuaternion()));
			while (reader.Position < reader.Capacity)
			{
				bool num = reader.TryReadReferenceHub(out var hub);
				Vector3 position = reader.ReadRelativePosition().Position;
				if (num)
				{
					BacktrackedPlayers.Add(new FpcBacktracker(hub, position));
				}
			}
			ServerAttack();
			BacktrackedPlayers.ForEach((FpcBacktracker x) =>
			{
				x.RestorePosition();
			});
			_serverAttackCooldown.Trigger(0.5);
		}

		private void ServerAttack()
		{
			if (NetworkServer.active)
			{
				LeftAttack = !LeftAttack;
				base.CastRole.StateController.SetAbilityState(Scp096AbilityState.Attacking);
				Transform playerCameraReference = base.Owner.PlayerCameraReference;
				Scp096HitHandler scp096HitHandler = (LeftAttack ? _leftHitHandler : _rightHitHandler);
				scp096HitHandler.Clear();
				_hitResult = scp096HitHandler.DamageSphere(playerCameraReference.position + playerCameraReference.forward * _sphereHitboxOffset, _sphereHitboxRadius);
				_audioPlayer.ServerPlayAttack(_hitResult);
				ServerSendRpc(toAll: true);
			}
		}

		public override void ResetObject()
		{
			base.ResetObject();
			_clientAttackCooldown.Clear();
			_serverAttackCooldown.Clear();
		}

		public override void SpawnObject()
		{
			base.SpawnObject();
			_leftHitHandler = new Scp096HitHandler(base.CastRole, Scp096DamageHandler.AttackType.SlapLeft, 500f, 250f, 60f, 0f);
			_rightHitHandler = new Scp096HitHandler(base.CastRole, Scp096DamageHandler.AttackType.SlapRight, 500f, 250f, 60f, 0f);
			_rightHitHandler.OnPlayerHit += (ReferenceHub ply) =>
			{
				ply.playerEffectsController.EnableEffect<Concussed>(2.5f);
			};
			_leftHitHandler.OnPlayerHit += (ReferenceHub ply) =>
			{
				ply.playerEffectsController.EnableEffect<Concussed>(2.5f);
			};
		}

		protected override void Update()
		{
			base.Update();
			if (NetworkServer.active && _serverAttackCooldown.IsReady && base.CastRole.IsAbilityState(Scp096AbilityState.Attacking))
			{
				base.CastRole.ResetAbilityState();
			}
		}

		protected override void OnKeyDown()
		{
			base.OnKeyDown();
			if (!AttackPossible || !_clientAttackCooldown.IsReady)
			{
				return;
			}
			PlayersToSend.Clear();
			Vector3 position = base.CastRole.FpcModule.Position;
			foreach (ReferenceHub allHub in ReferenceHub.AllHubs)
			{
				if (allHub.roleManager.CurrentRole is IFpcRole fpcRole && HitboxIdentity.IsEnemy(base.Owner, allHub) && !((fpcRole.FpcModule.Position - position).sqrMagnitude > 9f))
				{
					PlayersToSend.Add(allHub);
				}
			}
			ClientSendCmd();
			_clientAttackCooldown.Trigger(0.5);
			OnAttackTriggered?.Invoke();
		}

		protected override void Awake()
		{
			base.Awake();
			GetSubroutine<Scp096AudioPlayer>(out _audioPlayer);
		}
	}
}
