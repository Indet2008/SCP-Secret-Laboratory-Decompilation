using System.Collections.Generic;
using InventorySystem;
using UnityEngine;

namespace Interactables.Interobjects.DoorUtils
{
	public static class DoorScheduledUnlocker
	{
		private class ScheduledUnlock
		{
			public readonly DoorVariant Door;

			private float _targetTime;

			private readonly DoorLockReason _flagsToUnset;

			public ScheduledUnlock(DoorVariant targetDoor, float time, DoorLockReason flags)
			{
				Door = targetDoor;
				_targetTime = Time.timeSinceLevelLoad + time;
				_flagsToUnset = flags;
			}

			public bool Refresh()
			{
				if (Time.timeSinceLevelLoad < _targetTime)
				{
					return false;
				}
				if (Door != null)
				{
					Door.ServerChangeLock(_flagsToUnset, newState: false);
				}
				return true;
			}
		}

		private static readonly List<ScheduledUnlock> Entries = new List<ScheduledUnlock>();

		private static readonly List<int> EntriesToRemove = new List<int>();

		[RuntimeInitializeOnLoadMethod]
		private static void Init()
		{
			StaticUnityMethods.OnUpdate += UnityStaticUpdate;
			Inventory.OnServerStarted += Entries.Clear;
			Inventory.OnServerStarted += EntriesToRemove.Clear;
		}

		private static void UnityStaticUpdate()
		{
			if (!StaticUnityMethods.IsPlaying)
			{
				return;
			}
			bool flag = false;
			for (int i = 0; i < Entries.Count; i++)
			{
				if (Entries[i].Refresh())
				{
					flag = true;
					EntriesToRemove.Add(i);
				}
			}
			if (flag)
			{
				for (int j = 0; j < EntriesToRemove.Count; j++)
				{
					Entries.RemoveAt(EntriesToRemove[j] - j);
				}
				EntriesToRemove.Clear();
			}
		}

		public static void UnlockLater(this DoorVariant door, float time, DoorLockReason flagsToUnlock)
		{
			ScheduledUnlock scheduledUnlock = new ScheduledUnlock(door, time, flagsToUnlock);
			for (int i = 0; i < Entries.Count; i++)
			{
				if (!(Entries[i].Door != door))
				{
					Entries[i] = scheduledUnlock;
				}
			}
			Entries.Add(scheduledUnlock);
		}
	}
}
