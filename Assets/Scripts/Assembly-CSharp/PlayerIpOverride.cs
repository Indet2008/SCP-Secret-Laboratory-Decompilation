using System;
using Mirror;
using Mirror.LiteNetLib4Mirror;

public class PlayerIpOverride : NetworkBehaviour
{
	private void Start()
	{
		if (!CustomLiteNetLib4MirrorTransport.IpPassthroughEnabled || !NetworkServer.active || base.isLocalPlayer)
		{
			return;
		}
		NetworkConnectionToClient networkConnectionToClient = base.connectionToClient;
		if (networkConnectionToClient == null)
		{
			return;
		}
		try
		{
			int id = LiteNetLib4MirrorServer.Peers[networkConnectionToClient.connectionId].Id;
			if (CustomLiteNetLib4MirrorTransport.RealIpAddresses.ContainsKey(id))
			{
				networkConnectionToClient.IpOverride = CustomLiteNetLib4MirrorTransport.RealIpAddresses[id];
			}
		}
		catch (Exception ex)
		{
			ServerConsole.AddLog("Error during IP passthrough processing: " + ex.Message);
		}
	}

	public override bool Weaved()
	{
		return true;
	}
}
