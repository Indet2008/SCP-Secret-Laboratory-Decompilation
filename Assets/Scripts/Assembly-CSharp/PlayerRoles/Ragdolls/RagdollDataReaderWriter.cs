using Mirror;
using PlayerStatsSystem;
using RelativePositioning;
using UnityEngine;
using Utils.Networking;

namespace PlayerRoles.Ragdolls
{
	public static class RagdollDataReaderWriter
	{
		public static void WriteRagdollData(this NetworkWriter writer, RagdollData info)
		{
			writer.WriteByte((byte)info.RoleType);
			writer.WriteString(info.Nickname);
			writer.WriteDamageHandler(info.Handler);
			writer.WriteRelativePosition(info.StartRelativePosition);
			writer.WriteLowPrecisionQuaternion(new LowPrecisionQuaternion(info.StartRelativeRotation));
			writer.WriteVector3(info.Scale);
			writer.WriteDouble(info.CreationTime);
			writer.WriteUShort(info.Serial);
			writer.WriteReferenceHub(info.OwnerHub);
		}

		public static RagdollData ReadRagdollData(this NetworkReader reader)
		{
			RoleTypeId roleType = (RoleTypeId)reader.ReadByte();
			string nick = reader.ReadString();
			DamageHandlerBase handler = reader.ReadDamageHandler();
			RelativePosition relPos = reader.ReadRelativePosition();
			Quaternion value = reader.ReadLowPrecisionQuaternion().Value;
			Vector3 scale = reader.ReadVector3();
			double creationTime = reader.ReadDouble();
			ushort value2 = reader.ReadUShort();
			return new RagdollData(reader.ReadReferenceHub(), handler, roleType, relPos, value, scale, nick, creationTime, value2);
		}
	}
}
