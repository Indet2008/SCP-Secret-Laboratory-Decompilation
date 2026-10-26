using System;
using UnityEngine;

namespace Steam
{
	public static class SteamServerInfo
	{
		private const byte DefaultProtocol = 17;

		public static string ServerName { get; set; } = "Default server name.";

		public static string Version { get; set; } = "0.0.0";

		public static int OnlinePlayers { get; set; }

		public static int MaxPlayers { get; set; } = 25;

		public static int Bots { get; set; }

		public static string Tags { get; set; } = null;

		internal static ushort ServerPort { get; set; } = 7777;

		internal static long AppId { get; private set; } = 700330L;

		internal static string GameDirectory { get; private set; } = "scp secret laboratory";

		internal static string GameName { get; private set; } = "SCP: Secret Laboratory";

		internal static string MapName { get; private set; } = "Facility";

		internal static ServerType Type { get; private set; } = ServerType.Dedicated;

		internal static ServerOperativeSystem OperativeSystem
		{
			get
			{
				if (Application.platform != RuntimePlatform.LinuxPlayer)
				{
					return ServerOperativeSystem.Windows;
				}
				return ServerOperativeSystem.Linux;
			}
		}

		internal static bool IsPasswordProtected { get; private set; }

		internal static bool IsSecure { get; private set; }

		internal static byte[] Serialize()
		{
			using CustomBinaryWriter customBinaryWriter = new CustomBinaryWriter();
			customBinaryWriter.WriteInt(-1);
			customBinaryWriter.WriteByte(((ReadOnlySpan<byte>)new byte[1] { 73 })[0]);
			customBinaryWriter.WriteByte(17);
			customBinaryWriter.WriteString(ServerName);
			customBinaryWriter.WriteString(MapName);
			customBinaryWriter.WriteString(GameDirectory);
			customBinaryWriter.WriteString(GameName);
			customBinaryWriter.WriteShort((short)AppId);
			byte b = byte.MaxValue;
			customBinaryWriter.WriteByte((OnlinePlayers > b) ? b : ((byte)OnlinePlayers));
			customBinaryWriter.WriteByte((MaxPlayers > b) ? b : ((byte)MaxPlayers));
			customBinaryWriter.WriteByte((Bots > b) ? b : ((byte)Bots));
			customBinaryWriter.WriteByte((byte)Type);
			customBinaryWriter.WriteByte((byte)OperativeSystem);
			customBinaryWriter.WriteByte((byte)(IsPasswordProtected ? 1u : 0u));
			customBinaryWriter.WriteByte((byte)(IsSecure ? 1u : 0u));
			customBinaryWriter.WriteString(Version);
			if (string.IsNullOrEmpty(Tags))
			{
				customBinaryWriter.WriteByte(145);
				customBinaryWriter.WriteShort((short)ServerPort);
				customBinaryWriter.WriteLong(0L);
				customBinaryWriter.WriteLong(AppId);
			}
			else
			{
				customBinaryWriter.WriteByte(177);
				customBinaryWriter.WriteShort((short)ServerPort);
				customBinaryWriter.WriteLong(0L);
				customBinaryWriter.WriteString(Tags);
				customBinaryWriter.WriteLong(AppId);
			}
			return customBinaryWriter.ToArray();
		}
	}
}
