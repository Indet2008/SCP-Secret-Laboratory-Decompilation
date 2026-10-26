using System;
using System.Collections.Generic;
using System.Diagnostics;
using AudioPooling;
using Mirror;
using PlayerRoles.FirstPersonControl;
using PlayerRoles.Spectating;
using PlayerRoles.Subroutines;
using PlayerStatsSystem;
using RelativePositioning;
using UnityEngine;
using Utils.Networking;
using Utils.NonAllocLINQ;

namespace PlayerRoles.PlayableScps.Subroutines
{
	public abstract class ScpAttackAbilityBase<T> : KeySubroutine<T> where T : PlayerRoleBase, IFpcRole
	{
		[SerializeField]
		private float _detectionRadius;

		[SerializeField]
		private float _detectionOffset;

		[SerializeField]
		private AudioClip _killSound;

		[SerializeField]
		private AudioClip[] _hitClipsHuman;

		[SerializeField]
		private AudioClip[] _hitClipsObjects;

		private readonly Stopwatch _delaySw = new Stopwatch();

		private readonly TolerantAbilityCooldown _clientCooldown = new TolerantAbilityCooldown();

		private readonly TolerantAbilityCooldown _serverCooldown = new TolerantAbilityCooldown();

		private static readonly HashSet<FpcBacktracker> BacktrackedPlayers = new HashSet<FpcBacktracker>();

		private static readonly IDestructible[] DestDetectionsNonAlloc = new IDestructible[128];

		private static readonly Collider[] DetectionsNonAlloc = new Collider[128];

		private static readonly CachedLayerMask DetectionMask = new CachedLayerMask("Hitbox", "Glass");

		private const int DetectionsNumber = 128;

		protected readonly HashSet<ReferenceHub> DetectedPlayers = new HashSet<ReferenceHub>();

		public TolerantAbilityCooldown Cooldown
		{
			get
			{
				if (!base.Owner.isLocalPlayer && NetworkServer.active)
				{
					return _serverCooldown;
				}
				return _clientCooldown;
			}
		}

		public bool AttackTriggered { get; private set; }

		public AttackResult LastAttackResult { get; protected set; }

		public abstract float DamageAmount { get; }

		protected virtual float SoundRange => 13f;

		protected virtual float AttackDelay => 0f;

		protected virtual float BaseCooldown => 1f;

		protected virtual bool SelfRepeating => true;

		protected virtual bool CanTriggerAbility => _clientCooldown.IsReady;

		protected override ActionName TargetKey => ActionName.Shoot;

		private Transform PlyCam => base.Owner.PlayerCameraReference;

		private Vector3 OverlapSphereOrigin => PlyCam.position + PlyCam.forward * _detectionOffset;

		public event Action<AttackResult> OnAttacked;

		public event Action OnTriggered;

		protected abstract DamageHandlerBase DamageHandler(float damage);

		public static ArraySegment<IDestructible> DetectDestructibles(ReferenceHub detector, float offset, float radius, bool losTest = true)
		{
			Vector3 cameraPos = detector.PlayerCameraReference.position;
			int num = Physics.OverlapSphereNonAlloc(detector.PlayerCameraReference.TransformPoint(Vector3.forward * offset), radius, DetectionsNonAlloc, DetectionMask);
			int count = 0;
			for (int i = 0; i < num; i++)
			{
				Collider collider = DetectionsNonAlloc[i];
				if (collider.TryGetComponent<IDestructible>(out var component) && component.NetworkId != detector.netId && (!losTest || CheckLineOfSight(collider, component.CenterOfMass)))
				{
					DestDetectionsNonAlloc[count++] = component;
				}
			}
			return new ArraySegment<IDestructible>(DestDetectionsNonAlloc, 0, count);
			bool CheckLineOfSight(Collider hitColldier, Vector3 hitCenterOfMass)
			{
				if (!Physics.Linecast(cameraPos, hitCenterOfMass, out var hitInfo, PlayerRolesUtils.AttackMask))
				{
					return true;
				}
				if (hitInfo.colliderInstanceID == hitColldier.GetInstanceID())
				{
					return true;
				}
				return false;
			}
		}

		private void ServerPerformAttack()
		{
			LastAttackResult = AttackResult.None;
			foreach (IDestructible item in DetectDestructibles(base.Owner, _detectionOffset, _detectionRadius))
			{
				if (!(item is HitboxIdentity hitboxIdentity))
				{
					DamageDestructible(item);
					LastAttackResult |= AttackResult.AttackedObject;
				}
				else if (HitboxIdentity.IsEnemy(base.Owner, hitboxIdentity.TargetHub))
				{
					DetectedPlayers.Add(hitboxIdentity.TargetHub);
				}
			}
			DamagePlayers();
			ServerSendRpc(toAll: true);
		}

		protected virtual void DamagePlayers()
		{
			foreach (ReferenceHub detectedPlayer in DetectedPlayers)
			{
				DamagePlayer(detectedPlayer, DamageAmount);
			}
		}

		protected virtual void DamagePlayer(ReferenceHub hub, float damage)
		{
			PlayerStats playerStats = hub.playerStats;
			if (playerStats.DealDamage(DamageHandler(damage)))
			{
				LastAttackResult |= AttackResult.AttackedPlayer;
				if (!(playerStats.GetModule<HealthStat>().CurValue > 0f))
				{
					LastAttackResult |= AttackResult.KilledPlayer;
				}
			}
		}

		protected virtual void DamageDestructible(IDestructible dest)
		{
			dest.Damage(DamageAmount, DamageHandler(DamageAmount), dest.CenterOfMass);
		}

		protected bool HasAttackResultFlag(AttackResult flag)
		{
			return (LastAttackResult & flag) == flag;
		}

		public override void ClientWriteCmd(NetworkWriter writer)
		{
			base.ClientWriteCmd(writer);
			if (AttackTriggered)
			{
				writer.WriteRelativePosition(default);
				return;
			}
			Vector3 position = base.CastRole.FpcModule.Position;
			float num = _detectionOffset + _detectionRadius;
			float num2 = num * num;
			writer.WriteRelativePosition(new RelativePosition(position));
			writer.WriteLowPrecisionQuaternion(new LowPrecisionQuaternion(PlyCam.rotation));
			foreach (ReferenceHub allHub in ReferenceHub.AllHubs)
			{
				if (HitboxIdentity.IsEnemy(base.Owner, allHub) && allHub.roleManager.CurrentRole is IFpcRole fpcRole)
				{
					Vector3 position2 = fpcRole.FpcModule.Position;
					if (!((position2 - position).sqrMagnitude > num2))
					{
						writer.WriteReferenceHub(allHub);
						writer.WriteRelativePosition(new RelativePosition(position2));
					}
				}
			}
		}

		public override void ServerProcessCmd(NetworkReader reader)
		{
			base.ServerProcessCmd(reader);
			RelativePosition relativePosition = reader.ReadRelativePosition();
			if (relativePosition.WaypointId == 0)
			{
				AttackTriggered = true;
				ServerSendRpc(toAll: true);
			}
			else
			{
				if (!_serverCooldown.TolerantIsReady && !base.Owner.isLocalPlayer)
				{
					return;
				}
				AttackTriggered = false;
				Vector3 position = relativePosition.Position;
				Quaternion value = reader.ReadLowPrecisionQuaternion().Value;
				BacktrackedPlayers.Add(new FpcBacktracker(base.Owner, position, value));
				List<ReferenceHub> list = new List<ReferenceHub>();
				while (reader.Position < reader.Capacity)
				{
					ReferenceHub referenceHub = reader.ReadReferenceHub();
					list.Add(referenceHub);
					RelativePosition relativePosition2 = reader.ReadRelativePosition();
					if (!(referenceHub == null) && HitboxIdentity.IsEnemy(base.Owner, referenceHub))
					{
						BacktrackedPlayers.Add(new FpcBacktracker(referenceHub, relativePosition2.Position));
					}
				}
				ServerPerformAttack();
				BacktrackedPlayers.ForEach((FpcBacktracker x) =>
				{
					x.RestorePosition();
				});
				_serverCooldown.Trigger(BaseCooldown);
				DetectedPlayers.Clear();
				BacktrackedPlayers.Clear();
				ServerSendRpc(toAll: true);
			}
		}

		public override void ServerWriteRpc(NetworkWriter writer)
		{
			base.ServerWriteRpc(writer);
			if (!AttackTriggered)
			{
				writer.WriteByte((byte)LastAttackResult);
			}
		}

		public override void ClientProcessRpc(NetworkReader reader)
		{
			base.ClientProcessRpc(reader);
			if (reader.Position >= reader.Capacity)
			{
				if (!base.Role.IsControllable)
				{
					_clientCooldown.Trigger(BaseCooldown);
					OnTriggered?.Invoke();
				}
				return;
			}
			LastAttackResult = (AttackResult)reader.ReadByte();
			OnAttacked?.Invoke(LastAttackResult);
			if (LastAttackResult != AttackResult.None && (base.Owner.isLocalPlayer || base.Owner.IsLocallySpectated()))
			{
				Hitmarker.PlayHitmarker(1f);
			}
			if (HasAttackResultFlag(AttackResult.KilledPlayer) && _killSound != null)
			{
				AudioSourcePoolManager.PlayOnTransform(_killSound, base.transform, SoundRange);
			}
			else if (HasAttackResultFlag(AttackResult.AttackedPlayer) && _hitClipsHuman.Length != 0)
			{
				AudioSourcePoolManager.PlayOnTransform(_hitClipsHuman.RandomItem(), base.transform, SoundRange);
			}
			else if (HasAttackResultFlag(AttackResult.AttackedObject) && _hitClipsObjects.Length != 0)
			{
				AudioSourcePoolManager.PlayOnTransform(_hitClipsObjects.RandomItem(), base.transform, SoundRange);
			}
		}

		public override void ResetObject()
		{
			base.ResetObject();
			AttackTriggered = false;
			_delaySw.Reset();
			_clientCooldown.Clear();
			_serverCooldown.Clear();
			DetectedPlayers.Clear();
			BacktrackedPlayers.Clear();
		}

		protected override void Update()
		{
			base.Update();
			if (base.Role.IsControllable)
			{
				OnClientUpdate();
			}
		}

		protected virtual void OnClientUpdate()
		{
			if (AttackTriggered)
			{
				if (!(_delaySw.Elapsed.TotalSeconds < (double)AttackDelay))
				{
					AttackTriggered = false;
					ClientSendCmd();
				}
			}
			else if (CanTriggerAbility && SelfRepeating && IsKeyHeld)
			{
				ClientPerformAttack();
			}
		}

		protected override void OnKeyDown()
		{
			base.OnKeyDown();
			if (!AttackTriggered && !SelfRepeating && CanTriggerAbility)
			{
				ClientPerformAttack();
			}
		}

		protected virtual void ClientPerformAttack(bool attackTriggered = true)
		{
			_clientCooldown.Trigger(BaseCooldown);
			AttackTriggered = attackTriggered;
			_delaySw.Restart();
			AttackTriggered = true;
			ClientSendCmd();
			OnTriggered?.Invoke();
		}

		private void OnDrawGizmosSelected()
		{
			if (!(base.Owner == null))
			{
				Gizmos.color = Color.green;
				Gizmos.DrawWireSphere(OverlapSphereOrigin, _detectionRadius);
			}
		}
	}
}
