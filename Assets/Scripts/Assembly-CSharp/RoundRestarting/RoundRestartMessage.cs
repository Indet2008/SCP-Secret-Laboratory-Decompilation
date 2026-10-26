using Mirror;

namespace RoundRestarting
{
	public readonly struct RoundRestartMessage : NetworkMessage
	{
		public readonly RoundRestartType Type;

		public readonly float TimeOffset;

		public readonly ushort NewPort;

		public readonly bool Reconnect;

		public readonly bool ExtendedReconnectionPeriod;

		public RoundRestartMessage(RoundRestartType type, float offset, ushort newport, bool reconnect, bool extendedReconnectionPeriod)
		{
			Type = type;
			TimeOffset = offset;
			NewPort = newport;
			Reconnect = reconnect;
			ExtendedReconnectionPeriod = extendedReconnectionPeriod;
		}
	}
}
