using Mirror;
using UnityEngine;

namespace DrawableLine
{
	public static class DrawableLineMessageHandler
	{
		public static void Serialize(this NetworkWriter writer, DrawableLineMessage value)
		{
			value.WriteMessage(writer);
		}

		public static DrawableLineMessage Deserialize(this NetworkReader reader)
		{
			return new DrawableLineMessage(reader);
		}

		[RuntimeInitializeOnLoadMethod]
		private static void Init()
		{
			CustomNetworkManager.OnClientReady += () =>
			{
				NetworkClient.ReplaceHandler<DrawableLineMessage>(OnMessageReceived);
			};
		}

		private static void OnMessageReceived(DrawableLineMessage msg)
		{
			msg.GenerateLine();
		}
	}
}
