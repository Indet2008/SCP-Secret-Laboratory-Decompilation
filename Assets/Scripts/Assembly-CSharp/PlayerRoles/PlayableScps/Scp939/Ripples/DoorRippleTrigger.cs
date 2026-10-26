using Interactables.Interobjects;
using Interactables.Interobjects.DoorUtils;
using Mirror;
using PlayerRoles.FirstPersonControl;
using UnityEngine;

namespace PlayerRoles.PlayableScps.Scp939.Ripples
{
	public class DoorRippleTrigger : RippleTriggerBase
	{
		private static readonly Vector3 PosOffset = Vector3.up * 1.25f;

		private SurfaceRippleTrigger _surfaceRippleTrigger;

		private bool _rippleAssigned;

		public override void SpawnObject()
		{
			base.SpawnObject();
			DoorEvents.OnDoorAction += OnDoorAction;
			if (NetworkServer.active)
			{
				_rippleAssigned = base.CastRole.SubroutineModule.TryGetSubroutine<SurfaceRippleTrigger>(out _surfaceRippleTrigger);
			}
		}

		public override void ResetObject()
		{
			base.ResetObject();
			DoorEvents.OnDoorAction -= OnDoorAction;
			if (NetworkServer.active)
			{
				_rippleAssigned = false;
				_surfaceRippleTrigger = null;
			}
		}

		private void OnDoorAction(DoorVariant dv, DoorAction da, ReferenceHub hub)
		{
			if ((da != DoorAction.Closed && da != DoorAction.Opened) || !(dv is BasicDoor basicDoor))
			{
				return;
			}
			float maxDistance = basicDoor.MainSource.maxDistance;
			Vector3 position = dv.transform.position;
			TrySelfReport(position, maxDistance);
			if ((base.IsLocalOrSpectated || NetworkServer.active) && !((position + PosOffset - base.CastRole.FpcModule.Position).sqrMagnitude > maxDistance * maxDistance))
			{
				if (NetworkServer.active && _rippleAssigned && hub != null && HitboxIdentity.IsEnemy(base.Owner, hub))
				{
					_surfaceRippleTrigger.ProcessRipple(hub);
				}
				else
				{
					base.Player.Play(dv.transform.position + PosOffset, Color.red);
				}
			}
		}

		private static void TrySelfReport(Vector3 doorPos, float range)
		{
			if (ReferenceHub.TryGetLocalHub(out var hub) && hub.IsHuman() && (doorPos - hub.GetPosition()).sqrMagnitude < 9f)
			{
				RippleTriggerBase.SelfReport(range);
			}
		}
	}
}
