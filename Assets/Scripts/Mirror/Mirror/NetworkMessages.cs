namespace Mirror
{
	public static class NetworkMessages
	{
		public const int IdSize = 2;

		public static readonly global::System.Collections.Generic.Dictionary<ushort, global::System.Type> Lookup = new global::System.Collections.Generic.Dictionary<ushort, global::System.Type>();

		public static void LogTypes()
		{
			global::System.Text.StringBuilder stringBuilder = new global::System.Text.StringBuilder();
			stringBuilder.AppendLine("NetworkMessageIds:");
			foreach (global::System.Collections.Generic.KeyValuePair<ushort, global::System.Type> item in Lookup)
			{
				stringBuilder.AppendLine($"  Id={item.Key} = {item.Value}");
			}
			global::UnityEngine.Debug.Log(stringBuilder.ToString());
		}

		public static int MaxContentSize(int channelId)
		{
			int maxPacketSize = global::Mirror.Transport.active.GetMaxPacketSize(channelId);
			return maxPacketSize - 2 - global::Mirror.Batcher.MaxMessageOverhead(maxPacketSize);
		}

		public static int MaxMessageSize(int channelId)
		{
			return MaxContentSize(channelId) + 2;
		}

		[global::System.Runtime.CompilerServices.MethodImpl(global::System.Runtime.CompilerServices.MethodImplOptions.AggressiveInlining)]
		public static ushort GetId<T>() where T : struct, global::Mirror.NetworkMessage
		{
			return global::Mirror.NetworkMessageId<T>.Id;
		}

		[global::System.Runtime.CompilerServices.MethodImpl(global::System.Runtime.CompilerServices.MethodImplOptions.AggressiveInlining)]
		public static void Pack<T>(T message, global::Mirror.NetworkWriter writer) where T : struct, global::Mirror.NetworkMessage
		{
			writer.WriteUShort(global::Mirror.NetworkMessageId<T>.Id);
			writer.Write(message);
		}

		public static bool UnpackId(global::Mirror.NetworkReader reader, out ushort messageId)
		{
			try
			{
				messageId = reader.ReadUShort();
				return true;
			}
			catch (global::System.IO.EndOfStreamException)
			{
				messageId = 0;
				return false;
			}
		}

		internal static global::Mirror.NetworkMessageDelegate WrapHandler<T, C>(global::System.Action<C, T, int> handler, bool requireAuthentication) where T : struct, global::Mirror.NetworkMessage where C : global::Mirror.NetworkConnection
		{
			return (global::Mirror.NetworkConnection conn, global::Mirror.NetworkReader reader, int channelId) =>
			{
				T val = default;
				int position = reader.Position;
				try
				{
					if (requireAuthentication && !conn.isAuthenticated)
					{
						global::UnityEngine.Debug.LogWarning($"Disconnecting connection: {conn}. Received message {typeof(T)} that required authentication, but the user has not authenticated yet");
						conn.Disconnect();
						return;
					}
					val = reader.Read<T>();
				}
				catch (global::System.Exception arg)
				{
					global::UnityEngine.Debug.LogError($"Disconnecting connection: {conn}. This can happen if the other side accidentally (or an attacker intentionally) sent invalid data. Reason: {arg}");
					conn.Disconnect();
					return;
				}
				finally
				{
					int position2 = reader.Position;
					global::Mirror.NetworkDiagnostics.OnReceive(val, channelId, position2 - position);
				}
				try
				{
					handler((C)conn, val, channelId);
				}
				catch (global::System.Exception ex)
				{
					global::UnityEngine.Debug.LogError($"Disconnecting connId={conn.connectionId} to prevent exploits from an Exception in MessageHandler: {ex.GetType().Name} {ex.Message}\n{ex.StackTrace}");
					conn.Disconnect();
				}
			};
		}

		[global::System.Runtime.CompilerServices.MethodImpl(global::System.Runtime.CompilerServices.MethodImplOptions.AggressiveInlining)]
		internal static global::Mirror.NetworkMessageDelegate WrapHandler<T, C>(global::System.Action<C, T> handler, bool requireAuthentication) where T : struct, global::Mirror.NetworkMessage where C : global::Mirror.NetworkConnection
		{
			return WrapHandler<T, C>(Wrapped, requireAuthentication);
			void Wrapped(C conn, T msg, int _)
			{
				handler(conn, msg);
			}
		}
	}
}
