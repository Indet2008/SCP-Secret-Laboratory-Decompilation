using CustomPlayerEffects;
using LabApi.Events.Arguments.Scp106Events;
using LabApi.Events.Handlers;
using Mirror;
using PlayerRoles.FirstPersonControl;
using PlayerRoles.Spectating;
using PlayerStatsSystem;
using RelativePositioning;
using UnityEngine;
using Utils.Networking;

namespace PlayerRoles.PlayableScps.Scp106
{
	public class Scp106Attack : Scp106VigorAbilityBase
	{
		public delegate void PlayerTeleported(ReferenceHub scp106, ReferenceHub hub);

		private const float TargetTraceTime = 0.35f;

		private const float VigorCaptureReward = 0.3f;

		private const float CooldownReductionReward = 5f;

		private const float CorrodingTime = 20f;

		private ReferenceHub _targetHub;

		private Quaternion _claimedOwnerCamRotation;

		private Vector3 _claimedOwnerPosition;

		private Vector3 _claimedTargetPosition;

		private double _nextAttack;

		[SerializeField]
		private AnimationCurve _dotOverDistance;

		[SerializeField]
		private float _maxRangeSqr;

		[SerializeField]
		private float _hitCooldown;

		[SerializeField]
		private float _missCooldown;

		[SerializeField]
		private int _damage;

		private Transform OwnerCam => base.Owner.PlayerCameraReference;

		protected override ActionName TargetKey => ActionName.Shoot;

		public static event PlayerTeleported OnPlayerTeleported;

		protected override void OnKeyDown()
		{
			base.OnKeyDown();
			float num = -1f;
			_claimedOwnerPosition = base.CastRole.FpcModule.Position;
			_claimedOwnerCamRotation = OwnerCam.rotation;
			foreach (ReferenceHub allHub in ReferenceHub.AllHubs)
			{
				if (!HitboxIdentity.IsEnemy(base.Owner, allHub) || !(allHub.roleManager.CurrentRole is IFpcRole fpcRole))
				{
					continue;
				}
				Vector3 position = fpcRole.FpcModule.Position;
				Vector3 vector = position - _claimedOwnerPosition;
				if (!(vector.sqrMagnitude > _maxRangeSqr))
				{
					float num2 = Vector3.Dot(vector.normalized, OwnerCam.forward);
					if (!(num2 < num))
					{
						_claimedTargetPosition = position;
						_targetHub = allHub;
						num = num2;
					}
				}
			}
			if (num != -1f)
			{
				ClientSendCmd();
			}
		}

		private void SendCooldown(float cooldown)
		{
			if (!(cooldown <= 0f))
			{
				_nextAttack = NetworkTime.time + (double)cooldown;
				ServerSendRpc((ReferenceHub x) => x == base.Owner || base.Owner.IsSpectatedBy(x));
			}
		}

		private void ReduceSinkholeCooldown()
		{
			base.CastRole.Sinkhole.ModifyCooldown(-5.0);
		}

		private bool VerifyShot()
		{
			if (!(_targetHub.roleManager.CurrentRole is IFpcRole fpcRole))
			{
				return false;
			}
			using (new FpcBacktracker(_targetHub, _claimedTargetPosition, 0.35f))
			{
				Vector3 position = base.CastRole.FpcModule.Position;
				Vector3 position2 = fpcRole.FpcModule.Position;
				Vector3 vector = position2 - position;
				float sqrMagnitude = vector.sqrMagnitude;
				if (sqrMagnitude > _maxRangeSqr)
				{
					return false;
				}
				Vector3 forward = OwnerCam.forward;
				forward.y = 0f;
				vector.y = 0f;
				if (Physics.Linecast(position, position2, PlayerRolesUtils.AttackMask))
				{
					return false;
				}
				if (!(_dotOverDistance.Evaluate(sqrMagnitude) <= Vector3.Dot(vector.normalized, forward.normalized)))
				{
					SendCooldown(_missCooldown);
					return false;
				}
			}
			return true;
		}

		private void ServerShoot()
		{
			if (!VerifyShot())
			{
				return;
			}
			PlayerEffectsController playerEffectsController = _targetHub.playerEffectsController;
			Corroding effect = playerEffectsController.GetEffect<Corroding>();
			if (playerEffectsController.GetEffect<Traumatized>().IsEnabled)
			{
				DamageHandlerBase handler = new ScpDamageHandler(base.Owner, -1f, DeathTranslations.PocketDecay);
				if (_targetHub.playerStats.DealDamage(handler))
				{
					base.VigorAmount += 0.3f;
					SendCooldown(_hitCooldown);
					ReduceSinkholeCooldown();
					Hitmarker.SendHitmarkerDirectly(base.Owner, 1f);
				}
				return;
			}
			if (!effect.IsEnabled)
			{
				DamageHandlerBase handler2 = new ScpDamageHandler(base.Owner, _damage, DeathTranslations.PocketDecay);
				if (!_targetHub.playerStats.DealDamage(handler2))
				{
					return;
				}
				effect.AttackerHub = base.Owner;
				playerEffectsController.EnableEffect<Corroding>(20f);
			}
			else
			{
				Scp106TeleportingPlayerEvent scp106TeleportingPlayerEvent = new Scp106TeleportingPlayerEvent(base.Owner, _targetHub);
				Scp106Events.OnTeleportingPlayer(scp106TeleportingPlayerEvent);
				if (!scp106TeleportingPlayerEvent.IsAllowed || (_targetHub.IsLastScpTarget() && !_targetHub.playerStats.DealDamage(new ScpDamageHandler(base.Owner, -1f, DeathTranslations.PocketDecay))))
				{
					return;
				}
				OnPlayerTeleported?.Invoke(base.Owner, _targetHub);
				playerEffectsController.EnableEffect<PocketCorroding>();
				base.VigorAmount += 0.3f;
				Scp106Events.OnTeleportedPlayer(new Scp106TeleportedPlayerEvent(base.Owner, _targetHub));
			}
			SendCooldown(_hitCooldown);
			ReduceSinkholeCooldown();
			Hitmarker.SendHitmarkerDirectly(base.Owner, 1f);
		}

		public override void ClientWriteCmd(NetworkWriter writer)
		{
			base.ClientWriteCmd(writer);
			writer.WriteReferenceHub(_targetHub);
			writer.WriteRelativePosition(new RelativePosition(_claimedTargetPosition));
			writer.WriteQuaternion(_claimedOwnerCamRotation);
			writer.WriteRelativePosition(new RelativePosition(_claimedOwnerPosition));
		}

		public override void ServerProcessCmd(NetworkReader reader)
		{
			base.ServerProcessCmd(reader);
			if (_nextAttack > NetworkTime.time || base.CastRole.Sinkhole.SubmergeProgress > 0f)
			{
				return;
			}
			_targetHub = reader.ReadReferenceHub();
			_claimedTargetPosition = reader.ReadRelativePosition().Position;
			_claimedOwnerCamRotation = reader.ReadQuaternion();
			_claimedOwnerPosition = reader.ReadRelativePosition().Position;
			if (_targetHub == null || !HitboxIdentity.IsEnemy(base.Owner, _targetHub))
			{
				return;
			}
			using (new FpcBacktracker(base.Owner, _claimedOwnerPosition, _claimedOwnerCamRotation))
			{
				ServerShoot();
			}
		}

		public override void ServerWriteRpc(NetworkWriter writer)
		{
			base.ServerWriteRpc(writer);
			writer.WriteDouble(_nextAttack);
		}

		public override void ClientProcessRpc(NetworkReader reader)
		{
			base.ClientProcessRpc(reader);
			ReduceSinkholeCooldown();
			Scp106Hud.PlayCooldownAnimation(reader.ReadDouble());
		}
	}
}
