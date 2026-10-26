using System;
using Footprinting;
using Interactables.Interobjects.DoorUtils;
using UnityEngine;

namespace Interactables.Interobjects
{
	public class DummyDoor : DoorVariant, IDamageableDoor, INonInteractableDoor
	{
		public bool IsDestroyed
		{
			get
			{
				return true;
			}
			set
			{
			}
		}

		public float MaxHealth => 0f;

		public float RemainingHealth => 0f;

		[field: SerializeField]
		public bool IgnoreLockdowns { get; private set; }

		[field: SerializeField]
		public bool IgnoreRemoteAdmin { get; private set; }

		public event Action OnDestroyedChanged;

		public override void LockBypassDenied(ReferenceHub ply, byte colliderId)
		{
		}

		public override void PermissionsDenied(ReferenceHub ply, byte colliderId)
		{
		}

		public override bool AllowInteracting(ReferenceHub ply, byte colliderId)
		{
			return false;
		}

		public override bool AnticheatPassageApproved()
		{
			return false;
		}

		public override float GetExactState()
		{
			return TargetState ? 1 : 0;
		}

		public float GetHealthPercent()
		{
			return 0f;
		}

		public override bool IsConsideredOpen()
		{
			return TargetState;
		}

		public bool ServerDamage(float hp, DoorDamageType type, Footprint attacker = default(Footprint))
		{
			return false;
		}

		public bool ServerRepair()
		{
			return false;
		}

		public void ClientDestroyEffects()
		{
		}

		public void ClientRepairEffects()
		{
		}

		public override bool Weaved()
		{
			return true;
		}
	}
}
