using LabApi.Events.Arguments.Scp173Events;
using LabApi.Events.Handlers;
using Mirror;
using PlayerRoles.FirstPersonControl;
using PlayerRoles.Subroutines;
using RelativePositioning;
using UnityEngine;
using Utils.Networking;

namespace PlayerRoles.PlayableScps.Scp173
{
	public class Scp173SnapAbility : KeySubroutine<Scp173Role>
	{
		private const float SnapRayDistance = 1.5f;

		private const float TargetBacktrackingTime = 0.4f;

		private const float OwnerBacktrackingTime = 0.1f;

		private const float ForetrackingTime = 0.2f;

		private Scp173ObserversTracker _observersTracker;

		private ReferenceHub _targetHub;

		private static int _snapMask;

		private static int SnapMask
		{
			get
			{
				if (_snapMask == 0)
				{
					_snapMask = LayerMask.GetMask("Default", "Hitbox", "Glass", "Door");
				}
				return _snapMask;
			}
		}

		public bool IsSpeeding
		{
			get
			{
				if (base.CastRole.SubroutineModule.TryGetSubroutine<Scp173BreakneckSpeedsAbility>(out var subroutine))
				{
					return subroutine.IsActive;
				}
				return false;
			}
		}

		protected override ActionName TargetKey => ActionName.Shoot;

		protected override void OnKeyDown()
		{
			base.OnKeyDown();
			if (!IsSpeeding && TryHitTarget(base.Owner.PlayerCameraReference, out _targetHub))
			{
				ClientSendCmd();
			}
		}

		private static bool TryHitTarget(Transform origin, out ReferenceHub target)
		{
			target = null;
			if (!Physics.Raycast(origin.position, origin.forward, out var hitInfo, 1.5f, SnapMask))
			{
				return false;
			}
			if (!hitInfo.collider.TryGetComponent<IDestructible>(out var component) || !(component is HitboxIdentity hitboxIdentity))
			{
				return false;
			}
			target = hitboxIdentity.TargetHub;
			return HitboxIdentity.IsEnemy(Team.SCPs, target.GetTeam());
		}

		protected override void Awake()
		{
			base.Awake();
			GetSubroutine<Scp173ObserversTracker>(out _observersTracker);
		}

		public override void ClientWriteCmd(NetworkWriter writer)
		{
			base.ClientWriteCmd(writer);
			writer.WriteReferenceHub(_targetHub);
			writer.WriteRelativePosition(new RelativePosition(_targetHub.transform.position));
			writer.WriteRelativePosition(new RelativePosition(base.Owner.transform.position));
			writer.WriteLowPrecisionQuaternion(new LowPrecisionQuaternion(base.Owner.PlayerCameraReference.rotation));
		}

		public override void ServerProcessCmd(NetworkReader reader)
		{
			base.ServerProcessCmd(reader);
			_targetHub = reader.ReadReferenceHub();
			if (_observersTracker.IsObserved || _targetHub == null || !(_targetHub.roleManager.CurrentRole is IFpcRole fpcRole) || IsSpeeding)
			{
				return;
			}
			Scp173SnappingEventArgs e = new Scp173SnappingEventArgs(base.Owner, _targetHub);
			Scp173Events.OnSnapping(e);
			if (!e.IsAllowed)
			{
				return;
			}
			_targetHub = e.Target.ReferenceHub;
			FirstPersonMovementModule fpcModule = base.CastRole.FpcModule;
			FirstPersonMovementModule fpcModule2 = fpcRole.FpcModule;
			Transform playerCameraReference = base.Owner.PlayerCameraReference;
			Vector3 position = fpcModule2.Position;
			Vector3 position2 = fpcModule.Position;
			Quaternion rotation = playerCameraReference.rotation;
			fpcModule2.Position = fpcModule2.Tracer.GenerateBounds(0.4f, ignoreTeleports: true).ClosestPoint(reader.ReadRelativePosition().Position);
			Bounds bounds = fpcModule.Tracer.GenerateBounds(0.1f, ignoreTeleports: true);
			RelativePosition relativePosition = reader.ReadRelativePosition();
			if (!Physics.Linecast(playerCameraReference.position, relativePosition.Position, VisionInformation.VisionLayerMask))
			{
				bounds.Encapsulate(fpcModule.Position + fpcModule.Motor.Velocity * 0.2f);
			}
			fpcModule.Position = bounds.ClosestPoint(relativePosition.Position);
			playerCameraReference.rotation = reader.ReadLowPrecisionQuaternion().Value;
			if (TryHitTarget(playerCameraReference, out var target) && target.playerStats.DealDamage(base.CastRole.DamageHandler))
			{
				Hitmarker.SendHitmarkerDirectly(base.Owner, 1f);
				if (base.CastRole.SubroutineModule.TryGetSubroutine<Scp173AudioPlayer>(out var subroutine))
				{
					subroutine.ServerSendSound(Scp173AudioPlayer.Scp173SoundId.Snap);
				}
			}
			fpcModule2.Position = position;
			fpcModule.Position = position2;
			playerCameraReference.rotation = rotation;
			Scp173Events.OnSnapped(new Scp173SnappedEventArgs(base.Owner, _targetHub));
		}
	}
}
