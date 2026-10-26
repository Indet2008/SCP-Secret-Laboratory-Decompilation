using Decals;
using Mirror;

namespace CommandSystem.Commands.RemoteAdmin.Cleanup
{
	public readonly struct DecalCleanupMessage : NetworkMessage
	{
		public readonly DecalPoolType DecalPoolType;

		public readonly int Amount;

		public void Serialize(NetworkWriter writer)
		{
			writer.WriteByte((byte)DecalPoolType);
			writer.WriteInt(Amount);
		}

		public DecalCleanupMessage(NetworkReader reader)
		{
			DecalPoolType = (DecalPoolType)reader.ReadByte();
			Amount = reader.ReadInt();
		}

		public DecalCleanupMessage(DecalPoolType decalPoolType, int amount)
		{
			DecalPoolType = decalPoolType;
			Amount = amount;
		}
	}
}
