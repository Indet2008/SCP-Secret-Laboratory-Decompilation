using System.Diagnostics;
using Interactables;
using InventorySystem.Items;
using Mirror;
using UnityEngine;

namespace InventorySystem.Disarming
{
	// Restored from the 14.2.8 client disassembly.
	public static class DisarmingController
	{
		private const float DisarmingTime = 1.1f;

		private const float DisarmingDistanceSqrt = 10.2f;

		private static KeyCode _disarmKey;

		private static bool _hasTarget;

		private static bool _targetState;

		private static ReferenceHub _newTarget;

		private static readonly Stopwatch Progress = new Stopwatch();

		[RuntimeInitializeOnLoadMethod]
		private static void Init()
		{
			Inventory.OnLocalClientStarted += Start;
			StaticUnityMethods.OnUpdate += Update;
			NewInput.OnKeyModified += delegate(ActionName action, KeyCode key)
			{
				if (action == ActionName.Interact)
				{
					_disarmKey = key;
				}
			};
		}

		private static void Start()
		{
			_disarmKey = NewInput.GetKey(ActionName.Interact);
		}

		private static void Update()
		{
			if (!StaticUnityMethods.IsPlaying)
			{
				return;
			}
			if (Input.GetKeyDown(_disarmKey))
			{
				GetNewTarget();
			}
			float num = 0f;
			if (_hasTarget)
			{
				num = (float)Progress.Elapsed.TotalSeconds / 1.1f;
				if (num >= 1f)
				{
					ConfirmTarget();
					num = 0f;
				}
				else if (!Input.GetKey(_disarmKey) || !ValidateAll(_newTarget))
				{
					CancelTarget();
					num = 0f;
				}
			}
			DisarmingGUI singleton = DisarmingGUI.Singleton;
			if (!(singleton == null))
			{
				singleton.Circle.fillAmount = num;
				singleton.Circle.enabled = _hasTarget;
			}
		}

		private static void GetNewTarget()
		{
			Transform transform = CenterScreenRaycast.LastRaycastHit.transform;
			if (transform == null || !transform.gameObject.TryGetComponent<HitboxIdentity>(out var component) || component.TargetHub == null)
			{
				return;
			}
			ReferenceHub targetHub = component.TargetHub;
			if (!ValidateAll(targetHub))
			{
				return;
			}
			bool flag = targetHub.inventory.IsDisarmed();
			if (flag)
			{
				ReferenceHub localHub = ReferenceHub.LocalHub;
				if (targetHub.roleManager.CurrentRole is IInventoryRole inventoryRole && !inventoryRole.AllowUndisarming(localHub))
				{
					return;
				}
			}
			else if (!ReferenceHub.LocalHub.CanStartDisarming(targetHub))
			{
				return;
			}
			_newTarget = targetHub;
			_hasTarget = true;
			_targetState = !flag;
			Progress.Restart();
		}

		private static void CancelTarget()
		{
			_newTarget = null;
			_hasTarget = false;
			Progress.Stop();
		}

		private static void ConfirmTarget()
		{
			Progress.Stop();
			if (_newTarget != null && _targetState != _newTarget.inventory.IsDisarmed())
			{
				NetworkClient.Send(new DisarmMessage(_newTarget, _targetState, isNull: false));
			}
			CancelTarget();
		}

		private static bool ValidateAll(ReferenceHub hub)
		{
			if (!ValidateDistance(hub))
			{
				return false;
			}
			if (!ValidateHeldItem(hub.inventory))
			{
				return false;
			}
			return !ReferenceHub.LocalHub.inventory.IsDisarmed();
		}

		private static bool ValidateDistance(ReferenceHub hub)
		{
			if (hub == null)
			{
				return false;
			}
			return (hub.transform.position - ReferenceHub.LocalHub.transform.position).sqrMagnitude <= 10.2f;
		}

		private static bool ValidateHeldItem(Inventory inv)
		{
			if (inv.CurItem.TypeId == ItemType.None)
			{
				return true;
			}
			if (!InventoryItemLoader.AvailableItems.TryGetValue(inv.CurItem.TypeId, out var value))
			{
				return true;
			}
			return value.TierFlags == ItemTierFlags.Common;
		}
	}
}
