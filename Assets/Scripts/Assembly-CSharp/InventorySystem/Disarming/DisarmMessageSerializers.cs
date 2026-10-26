using Mirror;

namespace InventorySystem.Disarming
{
	public static class DisarmMessageSerializers
	{
		public static void Serialize(this NetworkWriter writer, DisarmMessage value)
		{
			writer.WriteUInt((!value.PlayerIsNull) ? value.PlayerToDisarm.networkIdentity.netId : 0u);
			writer.WriteBool(value.Disarm);
		}

		public static DisarmMessage Deserialize(this NetworkReader reader)
		{
			uint netId = reader.ReadUInt();
			bool disarm = reader.ReadBool();
			bool isNull = !ReferenceHub.TryGetHubNetID(netId, out var hub);
			return new DisarmMessage(hub, disarm, isNull);
		}
	}
}
