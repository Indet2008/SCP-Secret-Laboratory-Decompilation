using Mirror;

public struct TeslaHitMsg : NetworkMessage
{
	public readonly TeslaGate Gate;

	public TeslaHitMsg(TeslaGate gate)
	{
		Gate = gate;
	}
}
