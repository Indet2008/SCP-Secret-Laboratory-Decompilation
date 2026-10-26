using System;
using CustomPlayerEffects;
using LabApi.Events.Arguments.Scp049Events;
using LabApi.Events.Handlers;
using Mirror;
using PlayerRoles.FirstPersonControl;
using PlayerRoles.PlayableScps.HUDs;
using PlayerRoles.Subroutines;
using PlayerStatsSystem;
using UnityEngine;
using Utils.Networking;

namespace PlayerRoles.PlayableScps.Scp049
{
	public class Scp049AttackAbility : KeySubroutine<Scp049Role>
	{
		// Client-only serialized fields restored from the v14 client layout (server build stripped them).
		[global::UnityEngine.SerializeField]
		private global::UnityEngine.AudioClip _attackSound;

		[global::UnityEngine.SerializeField]
		private global::UnityEngine.AudioClip _secondAttackSound;

		[global::UnityEngine.SerializeField]
		private global::UnityEngine.AudioClip _afflictedAttackSound;

		[global::UnityEngine.SerializeField]
		private global::PlayerRoles.PlayableScps.CooldownAudio _cooldownAudio;


		private const float CooldownTime = 1.5f;

		private const float LagBacktrackingCompensation = 0.4f;

		private static int _attackLayerMask;

		private const float AttackDistance = 1.728f;

		[SerializeField]
		private float _statusEffectDuration = 20f;

		private bool _isInstaKillAttack;

		private bool _isTarget;

		private ReferenceHub _target;

		private Scp049ResurrectAbility _resurrect;

		private Scp049SenseAbility _sense;

		public readonly AbilityCooldown Cooldown = new AbilityCooldown();

		public AbilityHud AttackAbilityHUD;

		internal static LayerMask AttackMask
		{
			get
			{
				if (_attackLayerMask == 0)
				{
					_attackLayerMask = LayerMask.GetMask("Hitbox") | (int)FpcStateProcessor.Mask;
				}
				return _attackLayerMask;
			}
		}

		protected override ActionName TargetKey => ActionName.Shoot;

		public event Action<ReferenceHub> OnServerHit;

		public override void ServerProcessCmd(NetworkReader reader)
		{
			if (!Cooldown.IsReady || _resurrect.IsInProgress)
			{
				return;
			}
			_target = reader.ReadReferenceHub();
			if (_target == null || !IsTargetValid(_target))
			{
				return;
			}
			CardiacArrest effect = _target.playerEffectsController.GetEffect<CardiacArrest>();
			_isInstaKillAttack = effect.IsEnabled;
			_isTarget = _sense.IsTarget(_target);
			float cooldownTime = 1.5f;
			Scp049AttackingEventArgs e = new Scp049AttackingEventArgs(base.Owner, _target, _isInstaKillAttack, _isTarget, cooldownTime);
			Scp049Events.OnAttacking(e);
			if (e.IsAllowed)
			{
				_isInstaKillAttack = e.InstantKill;
				_isTarget = e.IsSenseTarget;
				cooldownTime = e.CooldownTime;
				Cooldown.Trigger(cooldownTime);
				if (_isInstaKillAttack)
				{
					_target.playerStats.DealDamage(new Scp049DamageHandler(base.Owner, -1f, Scp049DamageHandler.AttackType.Instakill));
				}
				else
				{
					effect.SetAttacker(base.Owner);
					effect.Intensity = 1;
					effect.ServerChangeDuration(_statusEffectDuration);
				}
				OnServerHit?.Invoke(_target);
				ServerSendRpc(toAll: true);
				Hitmarker.SendHitmarkerDirectly(base.Owner, 1f, playAudio: false);
				Scp049Events.OnAttacked(new Scp049AttackedEventArgs(base.Owner, _target, _isInstaKillAttack, _isTarget));
			}
		}

		public override void ServerWriteRpc(NetworkWriter writer)
		{
			Cooldown.WriteCooldown(writer);
			writer.WriteBool(_isInstaKillAttack);
			writer.WriteBool(_isTarget);
		}

		public override void ClientProcessRpc(NetworkReader reader)
		{
			Cooldown.ReadCooldown(reader);
		}

		public override void ClientWriteCmd(NetworkWriter writer)
		{
			writer.WriteReferenceHub(_target);
		}

		public override void ResetObject()
		{
			base.ResetObject();
			Cooldown.Clear();
		}

		protected override void Awake()
		{
			base.Awake();
			GetSubroutine<Scp049ResurrectAbility>(out _resurrect);
			GetSubroutine<Scp049SenseAbility>(out _sense);
		}

		protected override void OnKeyDown()
		{
			base.OnKeyDown();
			if (Cooldown.IsReady && CanFindTarget(base.Owner.PlayerCameraReference, out _target))
			{
				ClientSendCmd();
			}
		}

		private bool IsTargetValid(ReferenceHub target)
		{
			if (!(target.roleManager.CurrentRole is IFpcRole fpcRole))
			{
				return false;
			}
			if (!HitboxIdentity.IsEnemy(base.Owner, target))
			{
				return false;
			}
			if (base.Owner.isLocalPlayer)
			{
				return true;
			}
			Bounds bounds = fpcRole.FpcModule.Tracer.GenerateBounds(0.4f, ignoreTeleports: true);
			Vector3 position = base.CastRole.FpcModule.Position;
			Vector3 vector = bounds.ClosestPoint(position);
			if (Vector3.Distance(position, vector) >= 1.728f)
			{
				return false;
			}
			return !Physics.Linecast(position, vector, FpcStateProcessor.Mask);
		}

		private bool CanFindTarget(Transform camera, out ReferenceHub target)
		{
			target = null;
			if (!Physics.Raycast(camera.position, camera.forward, out var hitInfo, 1.728f, AttackMask))
			{
				return false;
			}
			if (!hitInfo.collider.TryGetComponent<HitboxIdentity>(out var component))
			{
				return false;
			}
			target = component.TargetHub;
			return true;
		}
	}
}
