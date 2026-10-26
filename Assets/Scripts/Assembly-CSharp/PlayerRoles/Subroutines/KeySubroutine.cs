using UnityEngine;

namespace PlayerRoles.Subroutines
{
	public abstract class KeySubroutine<T> : StandardSubroutine<T> where T : PlayerRoleBase
	{
		private bool _held;

		protected abstract ActionName TargetKey { get; }

		protected virtual bool IsKeyHeld
		{
			get
			{
				return _held;
			}
			set
			{
				if (value != _held)
				{
					_held = value;
					if (value)
					{
						OnKeyDown();
					}
					else
					{
						OnKeyUp();
					}
				}
			}
		}

		protected virtual bool KeyPressable
		{
			get
			{
				if (!base.Role.IsEmulatedDummy)
				{
					if (base.Role.IsLocalPlayer)
					{
						return !Cursor.visible;
					}
					return false;
				}
				return true;
			}
		}

		protected virtual bool KeyReleasable => true;

		protected virtual void Update()
		{
			if (KeyPressable && GetAction(TargetKey))
			{
				IsKeyHeld = true;
			}
			else if (IsKeyHeld && KeyReleasable)
			{
				IsKeyHeld = false;
			}
		}

		protected virtual void OnKeyDown()
		{
		}

		protected virtual void OnKeyUp()
		{
		}

		public override void ResetObject()
		{
			base.ResetObject();
			_held = false;
		}
	}
}
