using Mirror;
using PlayerRoles.SpawnData;

namespace PlayerRoles
{
	public struct RoleSyncInfo : NetworkMessage
	{
		private readonly uint _targetNetId;

		private readonly uint _receiverNetId;

		private readonly PlayerRoleBase _role;

		private readonly RoleTypeId _targetRole;

		private readonly NetworkWriter _prependedSpoofedData;

		public RoleSyncInfo(ReferenceHub target, RoleTypeId role, ReferenceHub receiver, NetworkWriter spoofedData)
		{
			_targetNetId = target.netId;
			_targetRole = role;
			_receiverNetId = receiver.netId;
			_role = target.roleManager.CurrentRole;
			_prependedSpoofedData = spoofedData;
		}

		public RoleSyncInfo(NetworkReader reader)
		{
			_prependedSpoofedData = null;
			_receiverNetId = 0u;
			_targetNetId = reader.ReadUInt();
			if (!ReferenceHub.TryGetHubNetID(_targetNetId, out var hub))
			{
				PlayerRolesNetUtils.QueuedRoles[_targetNetId] = reader;
				_role = null;
				_targetRole = RoleTypeId.None;
				return;
			}
			_targetRole = reader.ReadRoleType();
			if (!NetworkServer.active)
			{
				hub.roleManager.InitializeNewRole(_targetRole, RoleChangeReason.None, RoleSpawnFlags.All, reader);
			}
			_role = hub.roleManager.CurrentRole;
		}

		public void Write(NetworkWriter writer)
		{
			writer.WriteUInt(_targetNetId);
			writer.WriteRoleType(_targetRole);
			if (_prependedSpoofedData != null)
			{
				foreach (byte item in _prependedSpoofedData.ToArraySegment())
				{
					writer.WriteByte(item);
				}
			}
			if (_role is IPublicSpawnDataWriter publicSpawnDataWriter)
			{
				publicSpawnDataWriter.WritePublicSpawnData(writer);
			}
			if (_receiverNetId == _targetNetId && _role is IPrivateSpawnDataWriter privateSpawnDataWriter)
			{
				privateSpawnDataWriter.WritePrivateSpawnData(writer);
			}
		}

		public override string ToString()
		{
			return string.Format("{0} (TargetNetId = '{1}' Role = '{2}')", "RoleSyncInfo", _targetNetId, _role);
		}
	}
}
