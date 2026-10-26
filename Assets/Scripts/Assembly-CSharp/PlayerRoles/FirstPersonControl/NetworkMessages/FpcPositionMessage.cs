using System.Collections.Generic;
using Mirror;

namespace PlayerRoles.FirstPersonControl.NetworkMessages
{
	public readonly struct FpcPositionMessage : NetworkMessage
	{
		private readonly ReferenceHub _receiver;

		private static readonly HashSet<uint> AssignedNetIds = new HashSet<uint>();

		public FpcPositionMessage(ReferenceHub receiver)
		{
			_receiver = receiver;
		}

		public FpcPositionMessage(NetworkReader reader)
		{
			_receiver = null;
			ushort num = reader.ReadUShort();
			AssignedNetIds.Clear();
			for (int i = 0; i < num; i++)
			{
				int value = reader.ReadRecyclablePlayerId().Value;
				FpcSyncData fpcSyncData = new FpcSyncData(reader);
				if (value != 0 && ReferenceHub.TryGetHub(value, out var hub))
				{
					AssignedNetIds.Add(hub.netId);
					if (fpcSyncData.TryApply(hub, out var module, out var bit))
					{
						module.IsGrounded = bit;
					}
				}
			}
			foreach (ReferenceHub allHub in ReferenceHub.AllHubs)
			{
				if (allHub.roleManager.CurrentRole is IFpcRole fpcRole)
				{
					fpcRole.FpcModule.Motor.IsInvisible = !AssignedNetIds.Contains(allHub.netId);
				}
			}
		}

		public void Write(NetworkWriter writer)
		{
			FpcServerPositionDistributor.WriteAll(_receiver, writer);
		}
	}
}
