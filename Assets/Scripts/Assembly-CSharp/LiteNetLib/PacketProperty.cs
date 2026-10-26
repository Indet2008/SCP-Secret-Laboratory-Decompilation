namespace LiteNetLib
{
	internal enum PacketProperty : byte
	{
		Unreliable = 0,
		Channeled = 1,
		Ack = 2,
		Ping = 3,
		Pong = 4,
		ConnectRequest = 5,
		ConnectAccept = 6,
		Disconnect = 7,
		UnconnectedMessage = 8,
		MtuCheck = 9,
		MtuOk = 10,
		Broadcast = 11,
		Merged = 12,
		ShutdownOk = 13,
		PeerNotFound = 14,
		InvalidProtocol = 15,
		NatMessage = 16,
		Empty = 17,
		ReliableMerged = 18,
		Total = 19
	}
}
