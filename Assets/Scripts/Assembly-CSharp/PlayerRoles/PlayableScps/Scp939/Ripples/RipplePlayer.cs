using System.Collections.Generic;
using CustomPlayerEffects;
using GameObjectPools;
using PlayerRoles.Subroutines;
using UnityEngine;

namespace PlayerRoles.PlayableScps.Scp939.Ripples
{
	public class RipplePlayer : SubroutineBase, IPoolSpawnable
	{
		[SerializeField]
		private RippleInstance _rippleTemplate;

		private Scp939FocusAbility _focus;

		private Deafened _deafened;

		private int _poolCount;

		private readonly Queue<RippleInstance> _pool = new Queue<RippleInstance>();

		private bool CanHear => !_deafened.IsEnabled;

		public void Play(Vector3 position, Color color)
		{
			if (CanHear && base.Role.IsPOV)
			{
				bool flag = false;
				RippleInstance rippleInstance = null;
				while (_poolCount != 0 && !(flag = (rippleInstance = _pool.Peek()) != null))
				{
					_pool.Dequeue();
					_poolCount--;
				}
				if (flag && !rippleInstance.InUse)
				{
					_pool.Dequeue();
					_poolCount--;
				}
				else
				{
					rippleInstance = Object.Instantiate(_rippleTemplate);
				}
				rippleInstance.Set(position, (!_focus.IsVisuallyFocused) ? Color.red : color);
				_pool.Enqueue(rippleInstance);
				_poolCount++;
			}
		}

		public void Play(HumanRole human)
		{
			Play(human.FpcModule.Position, human.RoleColor);
		}

		public void SpawnObject()
		{
			base.Role.TryGetOwner(out var hub);
			_deafened = hub.playerEffectsController.GetEffect<Deafened>();
		}

		protected override void Awake()
		{
			base.Awake();
			(base.Role as ISubroutinedRole).SubroutineModule.TryGetSubroutine<Scp939FocusAbility>(out _focus);
		}
	}
}
