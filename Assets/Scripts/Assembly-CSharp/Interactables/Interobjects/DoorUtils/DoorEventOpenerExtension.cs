using System;
using GameCore;
using MapGeneration;
using Mirror;

namespace Interactables.Interobjects.DoorUtils
{
	public class DoorEventOpenerExtension : DoorVariantExtension
	{
		public enum OpenerEventType
		{
			WarheadStart = 0,
			WarheadCancel = 1,
			DeconEvac = 2,
			DeconFinish = 3,
			DeconReset = 4
		}

		private static bool _isolateCheckpoints;

		private static bool _configLoaded;

		public static event Action<OpenerEventType> OnDoorsTriggerred = (OpenerEventType eventType) =>
		{
		};

		public static void TriggerAction(OpenerEventType eventType)
		{
			OnDoorsTriggerred(eventType);
		}

		private void Start()
		{
			OnDoorsTriggerred += Trigger;
			_configLoaded = false;
		}

		private void OnDestroy()
		{
			OnDoorsTriggerred -= Trigger;
		}

		private void Trigger(OpenerEventType eventType)
		{
			if (!NetworkServer.active || ((DoorLockReason)TargetDoor.ActiveLocks).HasFlagFast(DoorLockReason.SpecialDoorFeature))
			{
				return;
			}
			if (!_configLoaded)
			{
				_configLoaded = true;
				_isolateCheckpoints = ConfigFile.ServerConfig.GetBool("isolate_zones_on_countdown");
			}
			bool flag = base.transform.position.GetZone() == FacilityZone.LightContainment;
			switch (eventType)
			{
			case OpenerEventType.WarheadStart:
			{
				DoorNametagExtension component;
				if (_isolateCheckpoints && TargetDoor is CheckpointDoor checkpointDoor)
				{
					checkpointDoor.ServerChangeLock(DoorLockReason.Isolation, newState: true);
				}
				else if (AlphaWarheadController.LockGatesOnCountdown || !(TargetDoor is PryableDoor) || !TryGetComponent<DoorNametagExtension>(out component) || !component.GetName.Contains("GATE"))
				{
					TargetDoor.NetworkTargetState = true;
					TargetDoor.ServerChangeLock(DoorLockReason.Warhead, newState: true);
				}
				break;
			}
			case OpenerEventType.WarheadCancel:
				TargetDoor.ServerChangeLock(DoorLockReason.Warhead, newState: false);
				TargetDoor.ServerChangeLock(DoorLockReason.Isolation, newState: false);
				break;
			case OpenerEventType.DeconEvac:
				if (flag)
				{
					TargetDoor.NetworkTargetState = true;
					if (TargetDoor is CheckpointDoor)
					{
						TargetDoor.ServerChangeLock(DoorLockReason.DecontEvacuate, newState: true);
					}
				}
				break;
			case OpenerEventType.DeconFinish:
				if (flag)
				{
					TargetDoor.NetworkTargetState = false;
					TargetDoor.ServerChangeLock(DoorLockReason.DecontEvacuate, newState: false);
					TargetDoor.ServerChangeLock(DoorLockReason.DecontLockdown, newState: true);
				}
				break;
			case OpenerEventType.DeconReset:
				if (flag)
				{
					TargetDoor.ServerChangeLock(DoorLockReason.DecontEvacuate, newState: false);
					TargetDoor.ServerChangeLock(DoorLockReason.DecontLockdown, newState: false);
				}
				break;
			}
		}
	}
}
