using Interactables.Interobjects;
using Mirror;
using PlayerRoles.Subroutines;
using PlayerStatsSystem;
using UnityEngine;

namespace PlayerRoles.PlayableScps.Scp096
{
	public class Scp096PrygateAbility : StandardSubroutine<Scp096Role>
	{
		private PryableDoor _syncDoor;

		private Scp096HitHandler _hitHandler;

		private Scp096AudioPlayer _audioPlayer;

		private const float DoorKillerHeight = 1.5f;

		private const float DoorKillerRadius = 0.2f;

		private const float MaxDisSqr = 8.12f;

		private const float HumanDamage = 200f;

		public void ClientTryPry(PryableDoor door)
		{
			_syncDoor = door;
			ClientSendCmd();
		}

		// Restored from the client build: interacting with a pryable gate as the local SCP-096 starts prying it.
		private void OnInteracted(Interactables.InteractableCollider col)
		{
			if (base.Role.IsLocalPlayer && col.Target is PryableDoor door)
			{
				ClientTryPry(door);
			}
		}

		public override void SpawnObject()
		{
			base.SpawnObject();
			_hitHandler = new Scp096HitHandler(base.CastRole, Scp096DamageHandler.AttackType.GateKill, 0f, 0f, 200f, 200f);
			Interactables.InteractionCoordinator.OnClientInteracted += OnInteracted;
		}

		public override void ResetObject()
		{
			base.ResetObject();
			Interactables.InteractionCoordinator.OnClientInteracted -= OnInteracted;
		}

		public override void ClientWriteCmd(NetworkWriter writer)
		{
			base.ClientWriteCmd(writer);
			writer.WriteNetworkBehaviour(_syncDoor);
		}

		public override void ServerProcessCmd(NetworkReader reader)
		{
			base.ServerProcessCmd(reader);
			if (base.CastRole.StateController.RageState != Scp096RageState.Enraged || base.CastRole.StateController.AbilityState == Scp096AbilityState.PryingGate)
			{
				return;
			}
			_syncDoor = reader.ReadNetworkBehaviour<PryableDoor>();
			if (!(_syncDoor == null) && !_syncDoor.TargetState && !(_syncDoor.GetExactState() > 0f) && !((_syncDoor.transform.position - base.CastRole.FpcModule.Position).sqrMagnitude > 8.12f))
			{
				base.Role.TryGetOwner(out var hub);
				if (_syncDoor.TryPryGate(hub))
				{
					_hitHandler.Clear();
					ServerSendRpc(toAll: true);
				}
			}
		}

		public override void ServerWriteRpc(NetworkWriter writer)
		{
			base.ServerWriteRpc(writer);
			writer.WriteNetworkBehaviour(_syncDoor);
		}

		public override void ClientProcessRpc(NetworkReader reader)
		{
			base.ClientProcessRpc(reader);
			_syncDoor = reader.ReadNetworkBehaviour<PryableDoor>();
			if (NetworkServer.active || base.Owner.isLocalPlayer)
			{
				(base.CastRole.FpcModule as Scp096MovementModule).SetTargetGate(_syncDoor);
			}
		}

		protected override void Awake()
		{
			base.Awake();
			GetSubroutine<Scp096AudioPlayer>(out _audioPlayer);
		}

		private void Update()
		{
			if (NetworkServer.active && base.CastRole.IsAbilityState(Scp096AbilityState.PryingGate) && !(_syncDoor == null))
			{
				Vector3 position = _syncDoor.transform.position + Vector3.up * 1.5f;
				Scp096HitResult scp096HitResult = _hitHandler.DamageSphere(position, 0.2f);
				if (scp096HitResult != Scp096HitResult.None)
				{
					_audioPlayer.ServerPlayAttack(scp096HitResult);
					Hitmarker.SendHitmarkerDirectly(base.Owner, 1f);
				}
			}
		}
	}
}
