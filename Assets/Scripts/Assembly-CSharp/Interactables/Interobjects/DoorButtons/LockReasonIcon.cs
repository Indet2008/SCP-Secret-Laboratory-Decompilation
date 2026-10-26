using System;
using Interactables.Interobjects.DoorUtils;
using UnityEngine;

namespace Interactables.Interobjects.DoorButtons
{
	public class LockReasonIcon : MonoBehaviour
	{
		[Serializable]
		private struct IconPair
		{
			public DoorLockReason Flags;

			public GameObject TargetObject;
		}

		[SerializeField]
		private IconPair[] _icons;

		[SerializeField]
		private GameObject _fallback;

		[SerializeField]
		private GameObject _anyLocked;

		[SerializeField]
		private GameObject _unlocked;

		public void UpdateIcon(DoorVariant dv)
		{
			DoorLockReason activeLocks = (DoorLockReason)dv.ActiveLocks;
			bool flag = activeLocks == DoorLockReason.None;
			bool flag2 = false;
			IconPair[] icons = _icons;
			for (int i = 0; i < icons.Length; i++)
			{
				IconPair iconPair = icons[i];
				bool flag3 = (iconPair.Flags & activeLocks) != 0;
				iconPair.TargetObject.SetActive(flag3 && !flag2);
				flag2 |= flag3;
			}
			SetActiveSafe(_anyLocked, !flag);
			SetActiveSafe(_unlocked, flag);
			SetActiveSafe(_fallback, !flag && !flag2);
		}

		private void SetActiveSafe(GameObject target, bool val)
		{
			target?.SetActive(val);
		}
	}
}
