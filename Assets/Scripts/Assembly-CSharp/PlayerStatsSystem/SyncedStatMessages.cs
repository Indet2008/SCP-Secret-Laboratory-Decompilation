using Mirror;
using PlayerRoles;
using PlayerRoles.Spectating;
using UnityEngine;

namespace PlayerStatsSystem
{
	public static class SyncedStatMessages
	{
		public struct StatMessage : NetworkMessage
		{
			public SyncedStatBase Stat;

			public StatMessageType Type;

			public float SyncedValue;
		}

		public enum StatMessageType : byte
		{
			CurrentValue = 0,
			MaxValue = 1
		}

		[RuntimeInitializeOnLoadMethod]
		private static void Init()
		{
			CustomNetworkManager.OnClientReady += RegisterHandler;
			PlayerRoleManager.OnRoleChanged += OnRoleChanged;
		}

		private static void OnRoleChanged(ReferenceHub userHub, PlayerRoleBase prevClass, PlayerRoleBase newClass)
		{
			if (!NetworkServer.active || !(newClass is SpectatorRole) || userHub.isLocalPlayer)
			{
				return;
			}
			foreach (ReferenceHub allHub in ReferenceHub.AllHubs)
			{
				if (allHub.IsAlive() && !(allHub == userHub))
				{
					SendAllStats(userHub.networkIdentity.connectionToClient, allHub.playerStats);
				}
			}
		}

		private static void SendAllStats(NetworkConnectionToClient conn, PlayerStats ply)
		{
			StatBase[] statModules = ply.StatModules;
			for (int i = 0; i < statModules.Length; i++)
			{
				if (statModules[i] is SyncedStatBase { Mode: not SyncedStatBase.SyncMode.Private } syncedStatBase)
				{
					conn.Send(new StatMessage
					{
						Stat = syncedStatBase,
						Type = StatMessageType.CurrentValue,
						SyncedValue = syncedStatBase.CurValue
					});
					conn.Send(new StatMessage
					{
						Stat = syncedStatBase,
						Type = StatMessageType.MaxValue,
						SyncedValue = syncedStatBase.MaxValue
					});
				}
			}
		}

		public static void Serialize(this NetworkWriter writer, StatMessage value)
		{
			writer.WriteUInt(value.Stat.Hub.netId);
			writer.WriteByte(value.Stat.SyncId);
			writer.WriteByte((byte)value.Type);
			value.Stat.WriteValue(value.Type, writer);
		}

		public static StatMessage Deserialize(this NetworkReader reader)
		{
			uint netId = reader.ReadUInt();
			byte syncId = reader.ReadByte();
			StatMessageType type = (StatMessageType)reader.ReadByte();
			SyncedStatBase statOfUser = SyncedStatBase.GetStatOfUser(netId, syncId);
			return new StatMessage
			{
				Stat = statOfUser,
				Type = type,
				SyncedValue = statOfUser.ReadValue(type, reader)
			};
		}

		private static void RegisterHandler()
		{
			NetworkClient.ReplaceHandler((StatMessage msg) =>
			{
				if (msg.Type == StatMessageType.CurrentValue)
				{
					msg.Stat.CurValue = msg.SyncedValue;
				}
				else
				{
					msg.Stat.MaxValue = msg.SyncedValue;
				}
			});
		}
	}
}
