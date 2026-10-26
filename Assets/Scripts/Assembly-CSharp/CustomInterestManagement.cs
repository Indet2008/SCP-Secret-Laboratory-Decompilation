using System.Collections.Generic;
using Mirror;

public class CustomInterestManagement : InterestManagement
{
	public override bool OnCheckObserver(NetworkIdentity identity, NetworkConnectionToClient newObserver)
	{
		return true;
	}

	public override void OnRebuildObservers(NetworkIdentity identity, HashSet<NetworkConnectionToClient> newObservers)
	{
		if (identity.visible == Visibility.ForceHidden)
		{
			return;
		}
		foreach (NetworkConnectionToClient value in NetworkServer.connections.Values)
		{
			if (value.isReady)
			{
				newObservers.Add(value);
			}
		}
		if (NetworkServer.localConnection != null && NetworkServer.localConnection.isReady)
		{
			newObservers.Add(NetworkServer.localConnection);
		}
	}
}
