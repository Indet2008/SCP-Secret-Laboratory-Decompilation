using System;
using Interactables.Interobjects.DoorUtils;
using UnityEngine;

namespace Interactables.Interobjects
{
	[Serializable]
	public class CheckpointSequenceController
	{
		private CheckpointDoor _checkpoint;

		[field: SerializeField]
		public float OpenLoopTime { get; set; }

		[field: SerializeField]
		public float WarningTime { get; set; }

		public float RemainingTime { get; set; }

		private bool AnyOpen
		{
			get
			{
				DoorVariant[] subDoors = _checkpoint.SubDoors;
				for (int i = 0; i < subDoors.Length; i++)
				{
					if (subDoors[i].TargetState)
					{
						return true;
					}
				}
				return _checkpoint.TargetState;
			}
		}

		private bool AnyClosed
		{
			get
			{
				DoorVariant[] subDoors = _checkpoint.SubDoors;
				for (int i = 0; i < subDoors.Length; i++)
				{
					if (!subDoors[i].TargetState)
					{
						return true;
					}
				}
				return !_checkpoint.TargetState;
			}
		}

		private DoorLockReason LockReasons
		{
			get
			{
				ushort num = 0;
				DoorVariant[] subDoors = _checkpoint.SubDoors;
				foreach (DoorVariant doorVariant in subDoors)
				{
					num |= doorVariant.ActiveLocks;
				}
				return (DoorLockReason)(num | _checkpoint.ActiveLocks);
			}
		}

		private bool CanClose => DoorLockUtils.GetMode(LockReasons).HasFlagFast(DoorLockMode.CanClose);

		public void Init(CheckpointDoor checkpoint)
		{
			_checkpoint = checkpoint;
		}

		public CheckpointDoor.SequenceState UpdateSequence()
		{
			CheckpointDoor.SequenceState curSequence = _checkpoint.CurSequence;
			if (curSequence == CheckpointDoor.SequenceState.Idle)
			{
				return UpdateIdle();
			}
			if (AnyClosed)
			{
				SetStateAll(targetState: false);
				return CheckpointDoor.SequenceState.Idle;
			}
			return curSequence switch
			{
				CheckpointDoor.SequenceState.Granted => UpdateGranted(), 
				CheckpointDoor.SequenceState.OpenLoop => UpdateOpenLoop(), 
				CheckpointDoor.SequenceState.ClosingWarning => UpdateClosingWarning(), 
				_ => throw new InvalidOperationException("Unable to update checkpoint! Invalid sequence: " + curSequence), 
			};
		}

		private CheckpointDoor.SequenceState UpdateIdle()
		{
			if (!AnyOpen)
			{
				return CheckpointDoor.SequenceState.Idle;
			}
			SetStateAll(targetState: true);
			return CheckpointDoor.SequenceState.Granted;
		}

		private CheckpointDoor.SequenceState UpdateGranted()
		{
			DoorVariant[] subDoors = _checkpoint.SubDoors;
			for (int i = 0; i < subDoors.Length; i++)
			{
				if (!subDoors[i].IsConsideredOpen())
				{
					return CheckpointDoor.SequenceState.Granted;
				}
			}
			RemainingTime = OpenLoopTime;
			return CheckpointDoor.SequenceState.OpenLoop;
		}

		private CheckpointDoor.SequenceState UpdateOpenLoop()
		{
			RemainingTime -= Time.deltaTime;
			if (RemainingTime > 0f || !CanClose)
			{
				return CheckpointDoor.SequenceState.OpenLoop;
			}
			RemainingTime = WarningTime;
			return CheckpointDoor.SequenceState.ClosingWarning;
		}

		private CheckpointDoor.SequenceState UpdateClosingWarning()
		{
			if (!CanClose)
			{
				return CheckpointDoor.SequenceState.OpenLoop;
			}
			RemainingTime -= Time.deltaTime;
			if (RemainingTime > 0f)
			{
				return CheckpointDoor.SequenceState.ClosingWarning;
			}
			SetStateAll(targetState: false);
			return CheckpointDoor.SequenceState.Idle;
		}

		private void SetStateAll(bool targetState)
		{
			DoorVariant[] subDoors = _checkpoint.SubDoors;
			for (int i = 0; i < subDoors.Length; i++)
			{
				subDoors[i].NetworkTargetState = targetState;
			}
			_checkpoint.NetworkTargetState = targetState;
		}
	}
}
