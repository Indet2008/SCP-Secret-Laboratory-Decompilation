using System;
using Mirror;
using UnityEngine;
using Utils.Networking;

namespace PlayerRoles.Subroutines
{
	public readonly struct SubroutineMessage : NetworkMessage
	{
		private readonly int _subroutineIndex;

		private readonly bool? _isConfirmation;

		private readonly SubroutineBase _subroutine;

		private readonly ReferenceHub _target;

		private readonly RoleTypeId _role;

		private readonly NetworkReaderPooled _reader;

		public SubroutineMessage(SubroutineBase subroutine, bool isConfirmation)
		{
			_reader = null;
			_isConfirmation = isConfirmation;
			_subroutine = subroutine;
			_subroutineIndex = subroutine.SyncIndex;
			_role = subroutine.Role.RoleTypeId;
			subroutine.Role.TryGetOwner(out _target);
		}

		public SubroutineMessage(NetworkReader reader)
		{
			_subroutine = null;
			_isConfirmation = null;
			_subroutineIndex = reader.ReadByte();
			if (_subroutineIndex == 0)
			{
				_reader = null;
				_target = null;
				_role = RoleTypeId.None;
				return;
			}
			_target = reader.ReadReferenceHub();
			_role = reader.ReadRoleType();
			int num = reader.ReadByte();
			if (num == 255)
			{
				num += reader.ReadUShort();
			}
			_reader = NetworkReaderPool.Get(reader.ReadBytesSegment(num));
		}

		public void Write(NetworkWriter writer)
		{
			writer.WriteByte((byte)_subroutineIndex);
			if (_subroutineIndex != 0)
			{
				writer.WriteReferenceHub(_target);
				writer.WriteRoleType(_role);
				NetworkWriterPooled networkWriterPooled = NetworkWriterPool.Get();
				if (_isConfirmation == true)
				{
					_subroutine.ServerWriteRpc(networkWriterPooled);
				}
				else
				{
					_subroutine.ClientWriteCmd(networkWriterPooled);
				}
				int num = networkWriterPooled.Position;
				if (num > 65790)
				{
					num = 0;
				}
				writer.WriteByte((byte)Math.Min(num, 255));
				if (num >= 255)
				{
					writer.WriteUShort((ushort)(num - 255));
				}
				writer.WriteBytes(networkWriterPooled.buffer, 0, num);
				networkWriterPooled.Dispose();
			}
		}

		public void ServerApplyTrigger(NetworkConnection conn)
		{
			if (_subroutineIndex == 0)
			{
				return;
			}
			if (ReferenceHub.TryGetHub(conn, out var hub))
			{
				if (hub.isLocalPlayer)
				{
					hub = _target;
				}
				Apply(hub, server: true);
			}
			_reader.Dispose();
		}

		public void ClientApplyConfirmation()
		{
			if (_subroutineIndex != 0)
			{
				if (_target != null)
				{
					Apply(_target, server: false);
				}
				_reader.Dispose();
			}
		}

		private void Apply(ReferenceHub hub, bool server)
		{
			if (!(hub.roleManager.CurrentRole is ISubroutinedRole subroutinedRole) || hub.GetRoleId() != _role)
			{
				return;
			}
			int num = _subroutineIndex - 1;
			if (num < 0 || num >= subroutinedRole.SubroutineModule.AllSubroutines.Length)
			{
				return;
			}
			SubroutineBase subroutineBase = subroutinedRole.SubroutineModule.AllSubroutines[num];
			if (server)
			{
				subroutineBase.ServerProcessCmd(_reader);
				return;
			}
			try
			{
				subroutineBase.ClientProcessRpc(_reader);
			}
			catch (Exception exception)
			{
				Debug.LogException(exception);
			}
		}
	}
}
