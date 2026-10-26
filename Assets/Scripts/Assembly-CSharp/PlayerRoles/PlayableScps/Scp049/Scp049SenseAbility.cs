using System;
using System.Collections.Generic;
using LabApi.Events.Arguments.Scp049Events;
using LabApi.Events.Handlers;
using Mirror;
using PlayerRoles.FirstPersonControl;
using PlayerRoles.PlayableScps.HUDs;
using PlayerRoles.PlayableScps.Scp049.Zombies;
using PlayerRoles.Spectating;
using PlayerRoles.Subroutines;
using UnityEngine;
using Utils.Networking;

namespace PlayerRoles.PlayableScps.Scp049
{
	public class Scp049SenseAbility : KeySubroutine<Scp049Role>
	{
		// Client-only serialized fields restored from the v14 client layout (server build stripped them).
		[global::UnityEngine.SerializeField]
		private global::UnityEngine.AudioSource _goodsenseAudioSource;

		[global::UnityEngine.SerializeField]
		private global::PlayerRoles.PlayableScps.CooldownAudio _cooldownAudio;


		private const float BaseCooldown = 25f;

		private const float TargetLostCooldown = 25f;

		private const float AttemptFailCooldown = 2.5f;

		private const float EffectDuration = 20f;

		private const float HeightDiffIgnoreY = 0.1f;

		private const float NearbyDistanceSqr = 4.5f;

		public readonly AbilityCooldown Cooldown = new AbilityCooldown();

		public readonly AbilityCooldown Duration = new AbilityCooldown();

		public readonly HashSet<ReferenceHub> DeadTargets = new HashSet<ReferenceHub>();

		public readonly HashSet<ReferenceHub> SpecialZombies = new HashSet<ReferenceHub>();

		public AbilityHud SenseAbilityHUD;

		[SerializeField]
		private GameObject _effectPrefab;

		[SerializeField]
		private float _dotThreshold = 0.88f;

		[SerializeField]
		private float _distanceThreshold = 100f;

		private Scp049AttackAbility _attackAbility;

		private Transform _pulseEffect;

		private bool _hasPulseUnsafe;

		public ReferenceHub Target { get; private set; }

		public bool HasTarget { get; private set; }

		public float DistanceFromTarget { get; private set; }

		protected override ActionName TargetKey => ActionName.ToggleFlashlight;

		private bool CanSeeIndicator
		{
			get
			{
				if (base.Owner.isLocalPlayer || base.Owner.IsLocallySpectated())
				{
					return true;
				}
				return ReferenceHub.LocalHub.GetRoleId() == RoleTypeId.Scp0492;
			}
		}

		public event Action OnFailed;

		public event Action OnSuccess;

		public void ServerLoseTarget()
		{
			HasTarget = false;
			Cooldown.Trigger(25.0);
			ServerSendRpc(toAll: true);
			Scp049Events.OnSenseLostTarget(new Scp049SenseLostTargetEventArgs(base.Owner, Target));
		}

		public void ServerProcessKilledPlayer(ReferenceHub hub)
		{
			if (HasTarget && !(Target != hub))
			{
				DeadTargets.Add(hub);
				SpecialZombies.Add(hub);
				Cooldown.Trigger(25.0);
				HasTarget = false;
				ServerSendRpc(toAll: true);
				Scp049Events.OnSenseKilledTarget(new Scp049SenseKilledTargetEventArgs(base.Owner, Target));
			}
		}

		public bool IsTarget(ReferenceHub hub)
		{
			if (HasTarget)
			{
				return hub == Target;
			}
			return false;
		}

		protected override void Update()
		{
			base.Update();
			if (HasTarget)
			{
				bool flag = false;
				if (Target.roleManager.CurrentRole is IFpcRole fpcRole)
				{
					flag = true;
					Vector3 position = fpcRole.FpcModule.Position;
					Vector3 position2 = base.CastRole.FpcModule.Position;
					DistanceFromTarget = (position - position2).sqrMagnitude;
				}
				if (!HitboxIdentity.IsEnemy(base.Owner, Target))
				{
					flag = false;
				}
				if (NetworkServer.active && !((base.CastRole.VisibilityController.ValidateVisibility(Target) && !Duration.IsReady) & flag))
				{
					ServerLoseTarget();
				}
			}
		}

		protected override void OnKeyDown()
		{
			base.OnKeyDown();
			if (Duration.IsReady && Cooldown.IsReady)
			{
				if (!CanFindTarget(out var bestTarget))
				{
					Target = null;
					OnFailed?.Invoke();
					ClientSendCmd();
				}
				else
				{
					OnSuccess?.Invoke();
					Target = bestTarget;
					ClientSendCmd();
				}
			}
		}

		public override void SpawnObject()
		{
			base.SpawnObject();
			GetSubroutine<Scp049AttackAbility>(out _attackAbility);
			PlayerRoleManager.OnRoleChanged += OnRoleChanged;
			SpectatorTargetTracker.OnTargetChanged += OnSpectatorTargetChanged;
			_attackAbility.OnServerHit += OnServerHit;
		}

		public override void ResetObject()
		{
			base.ResetObject();
			Cooldown.Clear();
			Duration.Clear();
			DeadTargets.Clear();
			HasTarget = false;
			PlayerRoleManager.OnRoleChanged -= OnRoleChanged;
			SpectatorTargetTracker.OnTargetChanged -= OnSpectatorTargetChanged;
			_attackAbility.OnServerHit -= OnServerHit;
		}

		private void OnServerHit(ReferenceHub hub)
		{
			if (HasTarget && !(hub == Target))
			{
				ServerLoseTarget();
			}
		}

		private void OnSpectatorTargetChanged()
		{
			if (_hasPulseUnsafe)
			{
				if (_pulseEffect != null)
				{
					UnityEngine.Object.Destroy(_pulseEffect.gameObject);
				}
				_hasPulseUnsafe = false;
			}
		}

		private void OnRoleChanged(ReferenceHub userHub, PlayerRoleBase prevRole, PlayerRoleBase newRole)
		{
			if (NetworkServer.active)
			{
				if (newRole is HumanRole || newRole is ZombieRole)
				{
					DeadTargets.Remove(userHub);
				}
				if (prevRole is SpectatorRole && !(newRole is ZombieRole))
				{
					SpecialZombies.Remove(userHub);
				}
			}
		}

		public override void ServerProcessCmd(NetworkReader reader)
		{
			if (!Cooldown.IsReady || !Duration.IsReady)
			{
				return;
			}
			HasTarget = false;
			Target = reader.ReadReferenceHub();
			if (Target == null)
			{
				Cooldown.Trigger(2.5);
				ServerSendRpc(toAll: true);
			}
			else
			{
				if (!HitboxIdentity.IsEnemy(base.Owner, Target) || !(Target.roleManager.CurrentRole is FpcStandardRoleBase fpcStandardRoleBase))
				{
					return;
				}
				float radius = fpcStandardRoleBase.FpcModule.CharController.radius;
				Vector3 cameraPosition = fpcStandardRoleBase.CameraPosition;
				if (VisionInformation.GetVisionInformation(base.Owner, base.Owner.PlayerCameraReference, cameraPosition, radius, _distanceThreshold, checkFog: true, checkLineOfSight: true, 0, checkInDarkness: false).IsLooking)
				{
					Scp049UsingSenseEventArgs e = new Scp049UsingSenseEventArgs(base.Owner, Target);
					Scp049Events.OnUsingSense(e);
					if (e.IsAllowed)
					{
						Target = e.Target.ReferenceHub;
						Duration.Trigger(20.0);
						HasTarget = true;
						ServerSendRpc(toAll: true);
						Scp049Events.OnUsedSense(new Scp049UsedSenseEventArgs(base.Owner, Target));
					}
				}
			}
		}

		public override void ServerWriteRpc(NetworkWriter writer)
		{
			writer.WriteReferenceHub(HasTarget ? Target : null);
			Cooldown.WriteCooldown(writer);
			Duration.WriteCooldown(writer);
		}

		public override void ClientWriteCmd(NetworkWriter writer)
		{
			writer.WriteReferenceHub(Target);
		}

		public override void ClientProcessRpc(NetworkReader reader)
		{
			Target = reader.ReadReferenceHub();
			HasTarget = Target != null;
			if (_hasPulseUnsafe && _pulseEffect != null)
			{
				UnityEngine.Object.Destroy(_pulseEffect.gameObject);
				_hasPulseUnsafe = false;
			}
			if (HasTarget && CanSeeIndicator)
			{
				_pulseEffect = UnityEngine.Object.Instantiate(_effectPrefab, Target.transform).transform;
				_hasPulseUnsafe = true;
				UnityEngine.Object.Destroy(_pulseEffect.gameObject, 3.5f);
			}
			Cooldown.ReadCooldown(reader);
			Duration.ReadCooldown(reader);
		}

		private bool CanFindTarget(out ReferenceHub bestTarget)
		{
			Transform playerCameraReference = base.Owner.PlayerCameraReference;
			float num = _distanceThreshold * _distanceThreshold;
			float num2 = _dotThreshold;
			bool result = false;
			bestTarget = null;
			Vector3 position = base.CastRole.FpcModule.Position;
			foreach (ReferenceHub allHub in ReferenceHub.AllHubs)
			{
				if (!HitboxIdentity.IsEnemy(base.Owner, allHub) || !(allHub.roleManager.CurrentRole is FpcStandardRoleBase fpcStandardRoleBase))
				{
					continue;
				}
				Vector3 position2 = fpcStandardRoleBase.FpcModule.Position;
				Vector3 vector = position2 - playerCameraReference.position;
				Vector3 forward = playerCameraReference.forward;
				if (Mathf.Abs((position2 - position).y) < 0.1f && vector.sqrMagnitude < 4.5f)
				{
					forward.y = 0f;
					forward.Normalize();
					vector.y = 0f;
				}
				float num3 = Vector3.Dot(forward, vector.normalized);
				if (num3 < num2)
				{
					continue;
				}
				float sqrMagnitude = (position2 - position).sqrMagnitude;
				if (!(sqrMagnitude > num))
				{
					float radius = fpcStandardRoleBase.FpcModule.CharacterControllerSettings.Radius;
					if (VisionInformation.GetVisionInformation(base.Owner, playerCameraReference, fpcStandardRoleBase.CameraPosition, radius, _distanceThreshold, checkFog: true, checkLineOfSight: true, 0, checkInDarkness: false).IsLooking)
					{
						num = sqrMagnitude;
						bestTarget = allHub;
						num2 = num3;
						result = true;
					}
				}
			}
			return result;
		}
	}
}
