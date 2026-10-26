using System;
using Mirror;
using UnityEngine;

namespace InventorySystem.Disarming
{
	// Client-only logic stripped from the server build: hold Interact while looking at a
	// player to cuff (or uncuff) them, then send a DisarmMessage the server validates.
	public static class DisarmingController
	{
		private const float MaxDistance = 3.5f;

		private const float DisarmTime = 3f;

		private static readonly RaycastHit[] HitBuffer = new RaycastHit[16];

		private static ReferenceHub _target;

		private static bool _targetDisarm;

		public static float Progress { get; private set; }

		public static bool IsTargetingDisarm => _targetDisarm;

		[RuntimeInitializeOnLoadMethod]
		private static void Init()
		{
			StaticUnityMethods.OnUpdate += Update;
		}

		private static void Update()
		{
			if (!NetworkClient.active || !ReferenceHub.TryGetLocalHub(out var hub) || Cursor.visible || !Input.GetKey(NewInput.GetKey(ActionName.Interact)) || !TryGetLookedAtPlayer(hub, out var target))
			{
				ResetProgress();
				return;
			}
			bool flag;
			if (target.inventory.IsDisarmed())
			{
				if (!hub.CanUndisarm(target))
				{
					ResetProgress();
					return;
				}
				flag = false;
			}
			else
			{
				if (!hub.CanStartDisarming(target))
				{
					ResetProgress();
					return;
				}
				flag = true;
			}
			if (target != _target || flag != _targetDisarm)
			{
				_target = target;
				_targetDisarm = flag;
				Progress = 0f;
			}
			Progress += Time.deltaTime / DisarmTime;
			if (!(Progress < 1f))
			{
				NetworkClient.Send(new DisarmMessage(target, flag, isNull: false));
				ResetProgress();
			}
		}

		private static void ResetProgress()
		{
			Progress = 0f;
			_target = null;
		}

		private static bool TryGetLookedAtPlayer(ReferenceHub hub, out ReferenceHub target)
		{
			target = null;
			Transform playerCameraReference = hub.PlayerCameraReference;
			if (playerCameraReference == null)
			{
				return false;
			}
			int num = Physics.RaycastNonAlloc(playerCameraReference.position, playerCameraReference.forward, HitBuffer, MaxDistance, -1, QueryTriggerInteraction.Ignore);
			Array.Sort(HitBuffer, 0, num, HitDistanceComparer.Instance);
			for (int i = 0; i < num; i++)
			{
				Collider collider = HitBuffer[i].collider;
				HitboxIdentity componentInParent = collider.GetComponentInParent<HitboxIdentity>();
				if (componentInParent != null)
				{
					ReferenceHub targetHub = componentInParent.TargetHub;
					if (targetHub == hub)
					{
						continue;
					}
					target = targetHub;
					return target != null;
				}
				if (collider.GetComponentInParent<ReferenceHub>() == hub)
				{
					continue;
				}
				return false;
			}
			return false;
		}

		private class HitDistanceComparer : System.Collections.Generic.IComparer<RaycastHit>
		{
			public static readonly HitDistanceComparer Instance = new HitDistanceComparer();

			public int Compare(RaycastHit x, RaycastHit y)
			{
				return x.distance.CompareTo(y.distance);
			}
		}
	}
}
