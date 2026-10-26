namespace LiteNetLib
{
	public enum DeliveryMethod : byte
	{
		Unreliable = 4,
		ReliableUnordered = 0,
		Sequenced = 1,
		ReliableOrdered = 2,
		ReliableSequenced = 3
	}
}
