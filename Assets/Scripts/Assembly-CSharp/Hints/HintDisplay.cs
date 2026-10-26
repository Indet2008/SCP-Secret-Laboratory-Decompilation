using System;
using System.Collections.Generic;
using InventorySystem.Searching;
using Mirror;
using UnityEngine;

namespace Hints
{
	[RequireComponent(typeof(SearchCoordinator))]
	public class HintDisplay : NetworkBehaviour
	{
		public static readonly HashSet<NetworkConnection> SuppressedReceivers = new HashSet<NetworkConnection>();

		public void Show(Hint hint)
		{
			if (hint == null)
			{
				throw new ArgumentNullException("hint");
			}
			if (base.isLocalPlayer)
			{
				throw new InvalidOperationException("Cannot display a hint to the local player (headless server).");
			}
			if (NetworkServer.active)
			{
				NetworkConnection networkConnection = base.netIdentity.connectionToClient;
				if (!SuppressedReceivers.Contains(networkConnection))
				{
					networkConnection.Send(new HintMessage(hint));
				}
			}
		}

		public override bool Weaved()
		{
			return true;
		}
	}
}
