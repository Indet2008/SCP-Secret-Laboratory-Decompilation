using System;
using System.Collections.Generic;
using Interactables.Interobjects.DoorUtils;
using UnityEngine;

namespace LightContainmentZoneDecontamination
{
	[Obsolete("Replaced by the new door system", true)]
	public class DecontaminationEvacuationDoor : MonoBehaviour
	{
		public static List<DecontaminationEvacuationDoor> Instances = new List<DecontaminationEvacuationDoor>();

		public bool ShouldBeOpened = true;

		public bool ShouldBeClosed = true;

		[SerializeField]
		private DoorVariant _door;

		private void Awake()
		{
			Instances.Add(this);
		}

		private void OnDestroy()
		{
			Instances.Remove(this);
		}

		public void Open()
		{
			if (ShouldBeOpened)
			{
				_door.NetworkTargetState = true;
				_door.ServerChangeLock(DoorLockReason.DecontEvacuate, newState: true);
			}
		}

		public void Close()
		{
			if (ShouldBeClosed)
			{
				_door.NetworkTargetState = false;
				_door.ServerChangeLock(DoorLockReason.DecontEvacuate, newState: false);
				_door.ServerChangeLock(DoorLockReason.DecontLockdown, newState: true);
			}
		}
	}
}
