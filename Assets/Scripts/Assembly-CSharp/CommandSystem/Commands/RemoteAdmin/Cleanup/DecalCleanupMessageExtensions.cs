using Decals;
using Mirror;
using UnityEngine;

namespace CommandSystem.Commands.RemoteAdmin.Cleanup
{
	public static class DecalCleanupMessageExtensions
	{
		[RuntimeInitializeOnLoadMethod]
		private static void Init()
		{
			CustomNetworkManager.OnClientReady += () =>
			{
				NetworkClient.ReplaceHandler<DecalCleanupMessage>(ClientMessageReceived);
			};
		}

		private static void ClientMessageReceived(DecalCleanupMessage message)
		{
			DecalPoolManager.ClientClear(message.DecalPoolType, message.Amount);
		}

		public static void WriteDecalCleanupMessage(this NetworkWriter writer, DecalCleanupMessage msg)
		{
			msg.Serialize(writer);
		}

		public static DecalCleanupMessage ReadRadioStatusMessage(this NetworkReader reader)
		{
			return new DecalCleanupMessage(reader);
		}
	}
}
