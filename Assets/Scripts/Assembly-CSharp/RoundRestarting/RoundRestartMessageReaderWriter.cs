using Mirror;

namespace RoundRestarting
{
	public static class RoundRestartMessageReaderWriter
	{
		public static RoundRestartMessage ReadRoundRestartMessage(this NetworkReader reader)
		{
			RoundRestartType roundRestartType = (RoundRestartType)reader.ReadByte();
			bool flag = false;
			bool extendedReconnectionPeriod = false;
			ushort newport = 0;
			switch (roundRestartType)
			{
			case RoundRestartType.FastRestart:
				return new RoundRestartMessage(roundRestartType, 0f, newport, reconnect: false, extendedReconnectionPeriod: false);
			case RoundRestartType.FullRestart:
				flag = reader.ReadBool();
				if (flag)
				{
					extendedReconnectionPeriod = reader.ReadBool();
				}
				break;
			case RoundRestartType.RedirectRestart:
				newport = reader.ReadUShort();
				extendedReconnectionPeriod = reader.ReadBool();
				break;
			}
			return new RoundRestartMessage(roundRestartType, reader.ReadFloat(), newport, flag, extendedReconnectionPeriod);
		}

		public static void WriteRoundRestartMessage(this NetworkWriter writer, RoundRestartMessage msg)
		{
			writer.WriteByte((byte)msg.Type);
			switch (msg.Type)
			{
			case RoundRestartType.FastRestart:
				return;
			case RoundRestartType.FullRestart:
				writer.WriteBool(msg.Reconnect);
				if (msg.Reconnect)
				{
					writer.WriteBool(msg.ExtendedReconnectionPeriod);
				}
				break;
			case RoundRestartType.RedirectRestart:
				writer.WriteUShort(msg.NewPort);
				writer.WriteBool(msg.ExtendedReconnectionPeriod);
				break;
			}
			writer.WriteFloat(msg.TimeOffset);
		}
	}
}
