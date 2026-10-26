using System;
using Mirror;
using PlayerRoles;
using UnityEngine;

namespace Respawning.NamingRules
{
	public static class UnitNameMessageHandler
	{
		private static readonly NetworkWriter SendHistory = new NetworkWriter();

		[RuntimeInitializeOnLoadMethod]
		private static void Init()
		{
			ReferenceHub.OnPlayerAdded += (ReferenceHub hub) =>
			{
				if (NetworkServer.active && !hub.isLocalPlayer)
				{
					NetworkReaderPooled networkReaderPooled = NetworkReaderPool.Get(new ArraySegment<byte>(SendHistory.buffer, 0, SendHistory.Position));
					while (networkReaderPooled.Remaining > 0)
					{
						Team team = (Team)networkReaderPooled.ReadByte();
						if (!NamingRulesManager.TryGetNamingRule(team, out var rule))
						{
							break;
						}
						hub.connectionToClient.Send(new UnitNameMessage
						{
							Data = networkReaderPooled,
							NamingRule = rule,
							Team = team
						});
					}
					networkReaderPooled.Dispose();
				}
			};
		}

		public static UnitNameMessage ReadUnitName(this NetworkReader reader)
		{
			Team team = (Team)reader.ReadByte();
			if (!NamingRulesManager.TryGetNamingRule(team, out var rule))
			{
				throw new InvalidOperationException($"No compatible decoder detected to read the name of spawnable team: {team}.");
			}
			return new UnitNameMessage
			{
				Team = team,
				NamingRule = rule,
				UnitName = rule.ReadName(reader)
			};
		}

		public static void WriteUnitName(this NetworkWriter writer, UnitNameMessage msg)
		{
			byte team = (byte)msg.Team;
			writer.WriteByte(team);
			if (msg.Data == null)
			{
				int position = writer.Position;
				msg.NamingRule.WriteName(writer);
				SendHistory.WriteByte(team);
				SendHistory.WriteBytes(writer.buffer, position, writer.Position - position);
			}
			else
			{
				int position2 = msg.Data.Position;
				msg.NamingRule.ReadName(msg.Data);
				writer.WriteBytes(msg.Data.buffer.Array, position2, msg.Data.Position - position2);
			}
		}

		public static void ResetHistory()
		{
			SendHistory.Reset();
		}
	}
}
