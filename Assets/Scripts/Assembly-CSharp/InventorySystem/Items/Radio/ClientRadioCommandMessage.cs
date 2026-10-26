using Mirror;

namespace InventorySystem.Items.Radio
{
	public struct ClientRadioCommandMessage : NetworkMessage
	{
		public RadioMessages.RadioCommand Command;

		public ClientRadioCommandMessage(RadioMessages.RadioCommand cmd)
		{
			Command = cmd;
		}

		public void Serialize(NetworkWriter writer)
		{
			writer.WriteByte((byte)Command);
		}

		public ClientRadioCommandMessage(NetworkReader reader)
		{
			Command = (RadioMessages.RadioCommand)reader.ReadByte();
		}
	}
}
