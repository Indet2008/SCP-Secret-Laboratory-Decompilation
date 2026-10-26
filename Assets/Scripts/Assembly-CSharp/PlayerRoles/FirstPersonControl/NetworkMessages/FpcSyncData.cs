using System;
using LabApi.Events.Arguments.PlayerEvents;
using LabApi.Events.Handlers;
using Mirror;
using RelativePositioning;

namespace PlayerRoles.FirstPersonControl.NetworkMessages
{
	public readonly struct FpcSyncData : IEquatable<FpcSyncData>
	{
		private readonly PlayerMovementState _state;

		private readonly RelativePosition _position;

		private readonly ushort _rotH;

		private readonly ushort _rotV;

		private readonly bool _bitMouseLook;

		private readonly bool _bitPosition;

		private readonly bool _bitCustom;

		public FpcSyncData(NetworkReader reader)
		{
			Misc.ByteToBools(reader.ReadByte(), out var @bool, out var bool2, out var bool3, out var bool4, out var bool5, out _bitMouseLook, out _bitPosition, out _bitCustom);
			_state = (PlayerMovementState)Misc.BoolsToByte(@bool, bool2, bool3, bool4, bool5);
			_position = (_bitPosition ? reader.ReadRelativePosition() : new RelativePosition(0, 0, 0, 0, outOfRange: true));
			if (_bitMouseLook)
			{
				_rotH = reader.ReadUShort();
				_rotV = reader.ReadUShort();
			}
			else
			{
				_rotH = 0;
				_rotV = 0;
			}
		}

		public FpcSyncData(FpcSyncData prev, PlayerMovementState state, bool bit, RelativePosition pos, FpcMouseLook mLook)
		{
			_state = state;
			_bitCustom = bit;
			_position = pos;
			mLook.GetSyncValues(pos.WaypointId, out _rotH, out _rotV);
			_bitPosition = prev._position != _position;
			_bitMouseLook = _rotH != prev._rotH || _rotV != prev._rotV;
		}

		public void Write(NetworkWriter writer)
		{
			Misc.ByteToBools((byte)_state, out var @bool, out var bool2, out var bool3, out var bool4, out var bool5, out var _, out var _, out var _);
			writer.WriteByte(Misc.BoolsToByte(@bool, bool2, bool3, bool4, bool5, _bitMouseLook, _bitPosition, _bitCustom));
			if (_bitPosition)
			{
				writer.WriteRelativePosition(_position);
			}
			if (_bitMouseLook)
			{
				writer.WriteUShort(_rotH);
				writer.WriteUShort(_rotV);
			}
		}

		public bool TryApply(ReferenceHub hub, out FirstPersonMovementModule module, out bool bit)
		{
			bit = _bitCustom;
			if (!(hub.roleManager.CurrentRole is IFpcRole fpcRole) || !fpcRole.FpcModule.ModuleReady)
			{
				module = null;
				return false;
			}
			module = fpcRole.FpcModule;
			PlayerMovementState currentMovementState = module.CurrentMovementState;
			module.CurrentMovementState = _state;
			if (module.CurrentMovementState != currentMovementState)
			{
				PlayerEvents.OnMovementStateChanged(new PlayerMovementStateChangedEventArgs(hub, currentMovementState, module.CurrentMovementState));
			}
			FpcMotor motor = module.Motor;
			motor.MovementDetected = _bitPosition;
			if (_bitPosition)
			{
				motor.ReceivedPosition = _position;
			}
			if (_bitMouseLook)
			{
				module.MouseLook.ApplySyncValues(_rotH, _rotV);
			}
			return true;
		}

		public bool Equals(FpcSyncData other)
		{
			if (_state == other._state && _position == other._position && _rotH == other._rotH)
			{
				return _rotV == other._rotV;
			}
			return false;
		}

		public override bool Equals(object obj)
		{
			if (obj is FpcSyncData fpcSyncData)
			{
				return fpcSyncData.Equals(this);
			}
			return false;
		}

		public static bool operator ==(FpcSyncData left, FpcSyncData right)
		{
			return left.Equals(right);
		}

		public static bool operator !=(FpcSyncData left, FpcSyncData right)
		{
			return !left.Equals(right);
		}

		public override int GetHashCode()
		{
			return (int)((((((uint)(_position.GetHashCode() * 397) ^ (uint)_state) * 397) ^ _rotH) * 397) ^ _rotV);
		}
	}
}
