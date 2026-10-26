using Mirror;

namespace Utils.Networking
{
	public static class MessageStrategies<TSelf>
	{
		public delegate NetworkIdentity SelfToIdentity(TSelf self);

		public delegate bool ConnectionToSelf(NetworkConnection source, out TSelf self);

		public delegate void MessageHandler<in TMessage>(TSelf self, TMessage message);

		public static MessageHandler<TMessage> ToClient<TMessage>(MessageHandler<TMessage> handler, SelfToIdentity converter) where TMessage : struct, NetworkMessage
		{
			return (TSelf self, TMessage message) =>
			{
				NetworkIdentity networkIdentity = converter(self);
				if (networkIdentity.isLocalPlayer)
				{
					handler(self, message);
				}
				else
				{
					networkIdentity.connectionToClient.Send(message);
				}
			};
		}

		public static void RegisterFromClient<TMessage>(MessageHandler<TMessage> handler, ConnectionToSelf converter) where TMessage : struct, NetworkMessage
		{
			NetworkServer.ReplaceHandler((NetworkConnectionToClient connection, TMessage message) =>
			{
				if (converter(connection, out var self))
				{
					handler(self, message);
				}
			});
		}

		public static MessageHandler<TMessage> ToServer<TMessage>(MessageHandler<TMessage> handler, SelfToIdentity converter) where TMessage : struct, NetworkMessage
		{
			return (TSelf self, TMessage message) =>
			{
				if (converter(self).isLocalPlayer)
				{
					handler(self, message);
				}
				else
				{
					NetworkClient.Send(message);
				}
			};
		}

		public static void RegisterFromServer<TMessage>(MessageHandler<TMessage> handler, TSelf self) where TMessage : struct, NetworkMessage
		{
			NetworkClient.ReplaceHandler((NetworkConnection connection, TMessage message) =>
			{
				handler(self, message);
			});
		}
	}
}
