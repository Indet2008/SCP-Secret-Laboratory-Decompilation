using System;
using GameObjectPools;

namespace PlayerRoles.Subroutines
{
	public abstract class StandardSubroutine<T> : SubroutineBase, IPoolSpawnable, IPoolResettable where T : PlayerRoleBase
	{
		public ReferenceHub Owner { get; private set; }

		public T CastRole { get; private set; }

		protected override void Awake()
		{
			base.Awake();
			CastRole = base.Role as T;
		}

		protected void GetSubroutine<TSubroutine>(out TSubroutine sr) where TSubroutine : SubroutineBase
		{
			(base.Role as ISubroutinedRole).SubroutineModule.TryGetSubroutine<TSubroutine>(out sr);
		}

		public virtual void SpawnObject()
		{
			if (!base.Role.TryGetOwner(out var hub))
			{
				throw new InvalidOperationException("Subroutine " + base.name + " of type " + GetType().FullName + " spawned with no valid owner!");
			}
			Owner = hub;
		}

		public virtual void ResetObject()
		{
		}
	}
}
