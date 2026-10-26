using Mirror;
using UnityEngine;

namespace InventorySystem.Items.Firearms.BasicMessages
{
	public static class DamageIndicatorMessageProcessor
	{
		[RuntimeInitializeOnLoadMethod]
		private static void Init()
		{
			CustomNetworkManager.OnClientReady += RegisterHandlers;
		}

		private static void RegisterHandlers()
		{
			NetworkClient.ReplaceHandler((DamageIndicatorMessage msg) =>
			{
				DamageIndicator.ReceiveDamageFromPosition(msg.DamagePosition.Position, (int)msg.ReceivedDamage);
			});
		}
	}
}
