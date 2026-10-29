using PlayerRoles.FirstPersonControl;
using UnityEngine;

namespace PlayerRoles.PlayableScps.Scp939
{
	// Client logic restored from the client build (IL2CPP): while focusing, SCP-939 turns slower the further it looks
	// away from the frozen focus direction and cannot turn past 90 degrees from it; turning speed is budgeted.
	public class Scp939MouseLook : FpcMouseLook
	{
		private const float SlowdownStartAngle = 30f;

		private const float SlowdownRange = 60f;

		private const float MaxFocusAngle = 90f;

		private const float BankRegeneration = 85f;

		private const float MaxBank = 70f;

		private readonly ReferenceHub _hub;

		private float _angleBank;

		private Scp939FocusAbility _focus;

		private Scp939LungeAbility _lunge;

		private bool _isSet;

		public Scp939MouseLook(ReferenceHub hub, Scp939MovementModule mm)
			: base(hub, mm)
		{
			_hub = hub;
		}

		private bool TrySetup()
		{
			if (_isSet)
			{
				return true;
			}
			if (!(_hub.roleManager.CurrentRole is Scp939Role role))
			{
				return false;
			}
			role.SubroutineModule.TryGetSubroutine(out _focus);
			role.SubroutineModule.TryGetSubroutine(out _lunge);
			_isSet = _focus != null && _lunge != null;
			return _isSet;
		}

		private bool Focusing => TrySetup() && _focus.TargetState;

		protected override float ProcessHorizontalInput(float f)
		{
			if (!Focusing)
			{
				return f;
			}
			float delta = Mathf.DeltaAngle(CurrentHorizontal, _focus.FrozenRotation);
			float excess = Mathf.Abs(delta) - SlowdownStartAngle;
			float deltaSign = delta >= 0f ? 1f : -1f;
			float inputSign = f >= 0f ? 1f : -1f;
			if (deltaSign != inputSign)
			{
				f *= 1f - Mathf.Max(0f, excess) / SlowdownRange;
			}
			_angleBank = Mathf.Min(MaxBank, _angleBank + Time.deltaTime * BankRegeneration);
			float amount = Mathf.Min(Mathf.Abs(f), _angleBank);
			_angleBank -= amount;
			return amount * inputSign;
		}

		protected override float ClampHorizontal(float f)
		{
			f = base.ClampHorizontal(f);
			if (!Focusing)
			{
				return f;
			}
			float delta = Mathf.DeltaAngle(f, _focus.FrozenRotation);
			float sign = delta >= 0f ? 1f : -1f;
			float over = sign * delta - MaxFocusAngle;
			if (over > 0f)
			{
				f += over * sign;
			}
			return f;
		}
	}
}
