using Mirror;

public static class TeslaHitMsgSerializers
{
	public static void Serialize(this NetworkWriter writer, TeslaHitMsg value)
	{
		writer.WriteNetworkBehaviour(value.Gate);
	}

	public static TeslaHitMsg Deserialize(this NetworkReader reader)
	{
		return new TeslaHitMsg(reader.ReadNetworkBehaviour<TeslaGate>());
	}
}
