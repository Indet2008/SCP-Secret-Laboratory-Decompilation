using System.Collections.Generic;
using CustomPlayerEffects;
using Interactables;
using Interactables.Interobjects;
using LabApi.Events.Arguments.Scp096Events;
using LabApi.Events.Handlers;
using Mirror;
using PlayerRoles.PlayableScps.HUDs;
using PlayerRoles.Subroutines;
using PlayerStatsSystem;
using UnityEngine;

namespace PlayerRoles.PlayableScps.Scp096
{
	public class Scp096ChargeAbility : KeySubroutine<Scp096Role>
	{
		private static readonly Collider[] DoorDetections = new Collider[8];

		private static readonly CachedLayerMask ClientsideDoorDetectorMask = new CachedLayerMask("Door");

		private static readonly HashSet<Collider> DisabledColliders = new HashSet<Collider>();

		public const float DefaultChargeCooldown = 5f;

		private const float DefaultChargeDuration = 1f;

		private const float DamageObjects = 750f;

		private const float DamageTarget = 90f;

		private const float DamageNonTarget = 35f;

		private const float ConcussionDurationTargets = 10f;

		private const float ConcussionDurationNonTargets = 4f;

		public AbilityHud ChargeAbilityHUD;

		private Scp096HitHandler _hitHandler;

		private Scp096TargetsTracker _targetsTracker;

		private Scp096AudioPlayer _audioPlayer;

		private Transform _tr;

		[SerializeField]
		private Vector3 _detectionOffset;

		[SerializeField]
		private Vector3 _detectionExtents;

		[SerializeField]
		private AudioClip[] _soundsLethal;

		[SerializeField]
		private AudioClip[] _soundsNonLethal;

		[SerializeField]
		private float _soundDistance;

		[SerializeField]
		private CooldownAudio _cooldownAudio;

		public readonly AbilityCooldown Cooldown = new AbilityCooldown();

		public readonly AbilityCooldown Duration = new AbilityCooldown();

		public bool CanCharge
		{
			get
			{
				if (base.CastRole.IsRageState(Scp096RageState.Enraged) && base.CastRole.IsAbilityState(Scp096AbilityState.None))
				{
					return Cooldown.IsReady;
				}
				return false;
			}
		}

		protected override ActionName TargetKey => ActionName.Zoom;

		public override void ClientProcessRpc(NetworkReader reader)
		{
			base.ClientProcessRpc(reader);
			Cooldown.ReadCooldown(reader);
			Duration.ReadCooldown(reader);
		}

		public override void ServerWriteRpc(NetworkWriter writer)
		{
			base.ServerWriteRpc(writer);
			Cooldown.WriteCooldown(writer);
			Duration.WriteCooldown(writer);
		}

		public override void ServerProcessCmd(NetworkReader reader)
		{
			base.ServerProcessCmd(reader);
			if (CanCharge)
			{
				Scp096ChargingEventArgs e = new Scp096ChargingEventArgs(base.Owner);
				Scp096Events.OnCharging(e);
				if (e.IsAllowed)
				{
					_hitHandler.Clear();
					Duration.Trigger(1.0);
					base.CastRole.StateController.SetAbilityState(Scp096AbilityState.Charging);
					ServerSendRpc(toAll: true);
					Scp096Events.OnCharged(new Scp096ChargedEventArgs(base.Owner));
				}
			}
		}

		public override void SpawnObject()
		{
			base.SpawnObject();
			_hitHandler = new Scp096HitHandler(base.CastRole, Scp096DamageHandler.AttackType.Charge, 750f, 750f, 90f, 35f);
			_hitHandler.OnPlayerHit += (ReferenceHub ply) =>
			{
				ply.playerEffectsController.EnableEffect<Concussed>(_targetsTracker.HasTarget(ply) ? 10f : 4f);
			};
		}

		protected override void OnKeyDown()
		{
			base.OnKeyDown();
			if (Cooldown.IsReady)
			{
				_ = Duration.IsReady;
			}
			ClientSendCmd();
		}

		protected override void Awake()
		{
			base.Awake();
			_tr = base.transform;
			GetSubroutine<Scp096AudioPlayer>(out _audioPlayer);
			GetSubroutine<Scp096TargetsTracker>(out _targetsTracker);
			base.CastRole.StateController.OnAbilityUpdate += (Scp096AbilityState _) =>
			{
				foreach (Collider disabledCollider in DisabledColliders)
				{
					if (!(disabledCollider == null))
					{
						disabledCollider.enabled = true;
					}
				}
				DisabledColliders.Clear();
			};
		}

		protected override void Update()
		{
			base.Update();
			if (base.CastRole.IsAbilityState(Scp096AbilityState.Charging))
			{
				if (NetworkServer.active)
				{
					UpdateServer();
				}
				if (base.Role.IsLocalPlayer)
				{
					UpdateLocalClient();
				}
			}
		}

		private void UpdateServer()
		{
			if (Duration.IsReady || !base.CastRole.IsRageState(Scp096RageState.Enraged))
			{
				base.CastRole.ResetAbilityState();
				Cooldown.Trigger(5.0);
				ServerSendRpc(toAll: true);
				return;
			}
			Scp096HitResult scp096HitResult = _hitHandler.DamageBox(_tr.TransformPoint(_detectionOffset), _detectionExtents, _tr.rotation);
			if (scp096HitResult != Scp096HitResult.None)
			{
				Hitmarker.SendHitmarkerDirectly(base.Owner, 1f);
				_audioPlayer.ServerPlayAttack(scp096HitResult);
			}
		}

		private void UpdateLocalClient()
		{
			int num = Physics.OverlapBoxNonAlloc(_tr.TransformPoint(_detectionOffset), _detectionExtents, DoorDetections, _tr.rotation, ClientsideDoorDetectorMask);
			for (int i = 0; i < num; i++)
			{
				if (DoorDetections[i].TryGetComponent<InteractableCollider>(out var component))
				{
					CheckDoor(component.Target as IInteractable);
				}
			}
		}

		private void CheckDoor(IInteractable inter)
		{
			if (!(inter is BreakableDoor { AllColliders: var allColliders }))
			{
				if (inter is PryableDoor door)
				{
					GetSubroutine<Scp096PrygateAbility>(out var sr);
					sr.ClientTryPry(door);
				}
				return;
			}
			foreach (Collider collider in allColliders)
			{
				if (collider.enabled)
				{
					collider.enabled = false;
					DisabledColliders.Add(collider);
				}
			}
		}
	}
}
