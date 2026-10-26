using Mirror;

namespace InventorySystem.Items.Radio
{
	public struct RadioStatusMessage : NetworkMessage
	{
		public readonly RadioMessages.RadioRangeLevel Range;

		public readonly byte Battery;

		public readonly uint Owner;

		public void Serialize(NetworkWriter writer)
		{
			writer.WriteSByte((sbyte)Range);
			writer.WriteByte(Battery);
			writer.WriteUInt(Owner);
		}

		public RadioStatusMessage(NetworkReader reader)
		{
			Range = (RadioMessages.RadioRangeLevel)reader.ReadSByte();
			Battery = reader.ReadByte();
			Owner = reader.ReadUInt();
		}

		public RadioStatusMessage(RadioItem radio)
		{
			Range = radio.RangeLevel;
			Battery = radio.BatteryPercent;
			Owner = radio.Owner.netId;
		}
	}
}
