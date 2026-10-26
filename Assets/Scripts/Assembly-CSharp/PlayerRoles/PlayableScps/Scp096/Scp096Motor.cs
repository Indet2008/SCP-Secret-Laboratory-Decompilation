using PlayerRoles.FirstPersonControl;
using UnityEngine;

namespace PlayerRoles.PlayableScps.Scp096
{
	public class Scp096Motor : FpcMotor
	{
		private readonly Scp096Role _role;

		private bool _hasOverride;

		private Vector3 _overrideDir;

		protected override Vector3 DesiredMove
		{
			get
			{
				if (!_role.IsLocalPlayer || !_hasOverride)
				{
					return base.DesiredMove;
				}
				_hasOverride = false;
				return _overrideDir;
			}
		}

		public void SetOverride(Vector3 desiredMove)
		{
			_hasOverride = true;
			_overrideDir = desiredMove;
		}

		public Scp096Motor(ReferenceHub hub, Scp096Role role, FallDamageSettings fallDamageSettings)
			: base(hub, role.FpcModule, fallDamageSettings)
		{
			_role = role;
		}
	}
}
