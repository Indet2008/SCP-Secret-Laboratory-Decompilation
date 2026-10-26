using Interactables.Interobjects.DoorUtils;
using UnityEngine;

namespace Interactables.Interobjects.DoorButtons
{
	public abstract class BasicDoorButton : ButtonVariant
	{
		[SerializeField]
		private LockReasonIcon _lockIcons;

		private bool _isDestroyed;

		private bool _initialized;

		public override void Init(DoorVariant door)
		{
			base.Init(door);
			_initialized = true;
			door.OnStateChanged += OnStateChanged;
			door.OnLockChanged += OnLockChanged;
			if (door is IDamageableDoor damageableDoor)
			{
				damageableDoor.OnDestroyedChanged += OnDestroyedChanged;
			}
			UpdateMaterials();
		}

		public void TriggerDoorDenied(DoorPermissionFlags flags)
		{
			if (!base.enabled)
			{
				OnDenied(flags);
			}
		}

		private void OnDestroyedChanged()
		{
			_isDestroyed = (base.ParentDoor as IDamageableDoor).IsDestroyed;
			if (_isDestroyed)
			{
				SetAsDestroyed();
			}
			else
			{
				RestoreNonDestroyed();
			}
			UpdateMaterials();
		}

		private void OnStateChanged()
		{
			if (!_isDestroyed && base.ParentDoor.ActiveLocks == 0)
			{
				SetMoving();
				base.enabled = true;
			}
		}

		private void OnLockChanged()
		{
			if (!_isDestroyed)
			{
				if (_lockIcons != null)
				{
					_lockIcons.UpdateIcon(base.ParentDoor);
				}
				if (base.ParentDoor.IsMoving)
				{
					SetMoving();
					base.enabled = true;
				}
				UpdateMaterials();
			}
		}

		private void OnEnable()
		{
			if (_initialized)
			{
				UpdateMaterials();
			}
		}

		private void Update()
		{
			UpdateMaterials();
		}

		private void UpdateMaterials()
		{
			if (_isDestroyed)
			{
				base.enabled = false;
			}
			else if (base.ParentDoor.ActiveLocks != 0)
			{
				SetLocked();
				base.enabled = false;
			}
			else if (!base.ParentDoor.IsMoving)
			{
				SetIdle();
				base.enabled = false;
			}
			else
			{
				UpdateMoving();
			}
		}

		protected abstract void SetLocked();

		protected abstract void SetIdle();

		protected abstract void SetMoving();

		protected virtual void UpdateMoving()
		{
		}

		protected virtual void OnDenied(DoorPermissionFlags flags)
		{
		}

		protected virtual void SetAsDestroyed()
		{
		}

		protected virtual void RestoreNonDestroyed()
		{
		}
	}
}
