using Mirror;
using UnityEngine;

namespace PlayerRoles.FirstPersonControl.NetworkMessages
{
	public static class FpcMessagesReadersWriters
	{
		[RuntimeInitializeOnLoadMethod]
		private static void Init()
		{
			CustomNetworkManager.OnClientReady += () =>
			{
				NetworkClient.ReplaceHandler((FpcPositionMessage msg) =>
				{
				});
				NetworkClient.ReplaceHandler((FpcPositionOverrideMessage msg) =>
				{
					msg.ProcessMessage();
				});
				NetworkClient.ReplaceHandler((FpcRotationOverrideMessage msg) =>
				{
					msg.ProcessMessage();
				});
				NetworkClient.ReplaceHandler((FpcFallDamageMessage msg) =>
				{
					msg.ProcessMessage();
				});
				NetworkServer.ReplaceHandler((NetworkConnectionToClient conn, FpcFromClientMessage msg) =>
				{
					msg.ProcessMessage(conn);
				});
				NetworkServer.ReplaceHandler((NetworkConnectionToClient conn, FpcNoclipToggleMessage msg) =>
				{
					msg.ProcessMessage(conn);
				});
			};
		}

		public static void WriteFpcFromClientMessage(this NetworkWriter writer, FpcFromClientMessage msg)
		{
			msg.Write(writer);
		}

		public static FpcFromClientMessage ReadFpcFromClientMessage(this NetworkReader reader)
		{
			return new FpcFromClientMessage(reader);
		}

		public static void WriteFpcPositionMessage(this NetworkWriter writer, FpcPositionMessage msg)
		{
			msg.Write(writer);
		}

		public static FpcPositionMessage ReadFpcPositionMessage(this NetworkReader reader)
		{
			return new FpcPositionMessage(reader);
		}

		public static void WriteFpcPositionOverrideMessage(this NetworkWriter writer, FpcPositionOverrideMessage msg)
		{
			msg.Write(writer);
		}

		public static FpcPositionOverrideMessage ReadFpcPositionOverrideMessage(this NetworkReader reader)
		{
			return new FpcPositionOverrideMessage(reader);
		}

		public static void WriteFpcRotationOverrideMessage(this NetworkWriter writer, FpcPositionOverrideMessage msg)
		{
			msg.Write(writer);
		}

		public static FpcPositionOverrideMessage ReadFpcRotationOverrideMessage(this NetworkReader reader)
		{
			return new FpcPositionOverrideMessage(reader);
		}

		public static void WriteFpcFallDamageMessage(this NetworkWriter writer, FpcFallDamageMessage msg)
		{
			msg.Write(writer);
		}

		public static FpcFallDamageMessage ReadFpcFallDamageMessage(this NetworkReader reader)
		{
			return new FpcFallDamageMessage(reader);
		}
	}
}
