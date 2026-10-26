using System;
using GameObjectPools;
using UnityEngine;

namespace PlayerRoles.Visibility
{
	public class VisibilityController : MonoBehaviour, IPoolSpawnable
	{
		public virtual InvisibilityFlags IgnoredFlags => InvisibilityFlags.None;

		protected ReferenceHub Owner { get; private set; }

		protected PlayerRoleBase Role { get; private set; }

		public virtual InvisibilityFlags GetActiveFlags(ReferenceHub observer)
		{
			return InvisibilityFlags.None;
		}

		public virtual bool ValidateVisibility(ReferenceHub hub)
		{
			if (!(hub.roleManager.CurrentRole is ICustomVisibilityRole customVisibilityRole))
			{
				return true;
			}
			return (customVisibilityRole.VisibilityController.GetActiveFlags(Owner) & ~IgnoredFlags) == 0;
		}

		public virtual void SpawnObject()
		{
			Role = GetComponentInParent<PlayerRoleBase>();
			if (Role == null)
			{
				throw new InvalidOperationException("VisibilityController " + base.name + " does not have a parent role set!");
			}
			if (!Role.TryGetOwner(out var hub))
			{
				throw new InvalidOperationException("VisibilityController " + base.name + " does not have an owner assigned!");
			}
			Owner = hub;
		}
	}
}
