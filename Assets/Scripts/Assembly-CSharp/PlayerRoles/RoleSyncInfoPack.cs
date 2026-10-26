using Mirror;

namespace PlayerRoles
{
	public struct RoleSyncInfoPack : NetworkMessage
	{
		private readonly ReferenceHub _receiverHub;

		public RoleSyncInfoPack(ReferenceHub receiver)
		{
			_receiverHub = receiver;
		}

		public RoleSyncInfoPack(NetworkReader reader)
		{
			_receiverHub = null;
			int num = reader.ReadUShort();
			for (int i = 0; i < num; i++)
			{
				reader.ReadRoleSyncInfo();
			}
		}

		public void WritePlayers(NetworkWriter writer)
		{
			writer.WriteUShort((ushort)ReferenceHub.AllHubs.Count);
			foreach (ReferenceHub allHub in ReferenceHub.AllHubs)
			{
				RoleTypeId roleTypeId = ((allHub.roleManager.CurrentRole is IObfuscatedRole obfuscatedRole) ? obfuscatedRole.GetRoleForUser(_receiverHub) : allHub.roleManager.CurrentRole.RoleTypeId);
				new RoleSyncInfo(allHub, roleTypeId, _receiverHub, null).Write(writer);
				allHub.roleManager.PreviouslySentRole[_receiverHub.netId] = roleTypeId;
			}
		}
	}
}
