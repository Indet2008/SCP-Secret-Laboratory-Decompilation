using System.Collections.Generic;
using UnityEngine;

namespace CursorManagement
{
	public static class CursorManager
	{
		private static readonly HashSet<ICursorOverride> Overrides = new HashSet<ICursorOverride>();

		public static bool MovementLocked { get; private set; }

		[RuntimeInitializeOnLoadMethod]
		private static void Init()
		{
			StaticUnityMethods.OnLateUpdate += LateUpdate;
		}

		private static void LateUpdate()
		{
			ProcessOverrides(out var bestOverride, out var anyMovementLocked);
			switch (bestOverride)
			{
			case CursorOverrideMode.Confined:
				SetLockMode(CursorLockMode.Confined);
				break;
			case CursorOverrideMode.Centered:
				SetLockMode(CursorLockMode.Locked);
				break;
			default:
				SetLockMode(CursorLockMode.None);
				break;
			}
			MovementLocked = anyMovementLocked;
		}

		private static void ProcessOverrides(out CursorOverrideMode bestOverride, out bool anyMovementLocked)
		{
			bestOverride = CursorOverrideMode.NoOverride;
			anyMovementLocked = false;
			if (!StaticUnityMethods.IsPlaying)
			{
				return;
			}
			int num = 0;
			Overrides.RemoveWhere((ICursorOverride x) => x == null || (x is Object obj && obj == null));
			foreach (ICursorOverride @override in Overrides)
			{
				num = Mathf.Max(num, (int)@override.CursorOverride);
				anyMovementLocked |= @override.LockMovement;
			}
			bestOverride = (CursorOverrideMode)num;
		}

		public static void SetLockMode(CursorLockMode lockMode)
		{
			Cursor.lockState = lockMode;
			Cursor.visible = lockMode != CursorLockMode.Locked;
		}

		public static bool Register(ICursorOverride target)
		{
			return Overrides.Add(target);
		}

		public static bool Unregister(ICursorOverride target)
		{
			return Overrides.Remove(target);
		}
	}
}
