using System;
using System.Collections.Generic;
using System.Diagnostics;
using System.Text;
using Footprinting;
using Mirror;
using NorthwoodLib.Pools;
using PlayerRoles.Ragdolls;
using PlayerRoles.Subroutines;
using RoundRestarting;

namespace PlayerRoles.PlayableScps.Scp3114
{
	public class Scp3114History : StandardSubroutine<Scp3114Role>
	{
		private record RoundInstance(Footprint OwnerFootprint, List<LoggedIdentity> History)
		{
			public string PrintInstanceHistory(int selfId)
			{
				StringBuilder stringBuilder = StringBuilderPool.Shared.Rent();
				stringBuilder.Append("\nIdentity history of ");
				stringBuilder.Append(OwnerFootprint.Nickname);
				stringBuilder.Append(", spawned as SCP-3114 [ID: ");
				stringBuilder.Append(selfId.ToString());
				stringBuilder.Append("], ");
				AppendTime(stringBuilder, OwnerFootprint.Stopwatch.Elapsed);
				stringBuilder.Append(" ago:");
				foreach (LoggedIdentity item in History)
				{
					item.AppendSelf(stringBuilder);
				}
				return StringBuilderPool.Shared.ToStringReturn(stringBuilder);
			}
		}

		private record LoggedIdentity(string Nickname, RoleTypeId Role, Stopwatch Time)
		{
			public void AppendSelf(StringBuilder sb)
			{
				sb.Append("\n(");
				AppendTime(sb, Time.Elapsed);
				sb.Append(" ago) ");
				if (Role == RoleTypeId.None || string.IsNullOrEmpty(Nickname))
				{
					sb.Append("<color=red>No disguise</color>");
					return;
				}
				sb.Append(Nickname);
				sb.Append(" (");
				if (Role.TryGetRoleTemplate<PlayerRoleBase>(out var result))
				{
					sb.Append(result.GetColoredName());
				}
				else
				{
					sb.Append("<color=red>Unknown role</color>");
				}
				sb.Append(')');
			}
		}

		private static readonly List<RoundInstance> RoundOverallHistory = new List<RoundInstance>();

		private static int _prevRoundId = -1;

		private int _historyIndex;

		private List<LoggedIdentity> History => RoundOverallHistory[_historyIndex].History;

		private void OnStatusChanged()
		{
			if (!NetworkServer.active)
			{
				return;
			}
			switch (base.CastRole.CurIdentity.Status)
			{
			case Scp3114Identity.DisguiseStatus.Active:
			{
				BasicRagdoll ragdoll = base.CastRole.CurIdentity.Ragdoll;
				if (!(ragdoll == null) && ragdoll.Info.RoleType.TryGetRoleTemplate<PlayerRoleBase>(out var result))
				{
					History.Add(new LoggedIdentity(ragdoll.Info.Nickname, result.RoleTypeId, Stopwatch.StartNew()));
					ServerLogIdentity("is now impersonating " + ragdoll.Info.Nickname + ", playing as " + result.RoleName + ".");
				}
				break;
			}
			case Scp3114Identity.DisguiseStatus.None:
				History.Add(new LoggedIdentity(null, RoleTypeId.None, Stopwatch.StartNew()));
				ServerLogIdentity("is no longer disguised.");
				break;
			}
		}

		private void ServerLogIdentity(string msg)
		{
			StringBuilder stringBuilder = StringBuilderPool.Shared.Rent();
			stringBuilder.Append(base.Owner.LoggedNameFromRefHub());
			stringBuilder.Append(", playing as ");
			stringBuilder.Append(base.CastRole.RoleName);
			stringBuilder.Append(", ");
			stringBuilder.Append(msg);
			stringBuilder.Append(' ');
			ServerLogs.AddLog(ServerLogs.Modules.ClassChange, msg, ServerLogs.ServerLogType.GameEvent);
		}

		private static void AppendTime(StringBuilder sb, TimeSpan elapsed)
		{
			sb.Append((int)elapsed.TotalMinutes);
			sb.Append("m ");
			sb.Append(elapsed.Seconds);
			sb.Append("s");
		}

		private static string PrintAllInstances()
		{
			StringBuilder stringBuilder = StringBuilderPool.Shared.Rent();
			stringBuilder.Append("Multiple instances of SCP-3114 have been recorded during this round, please run this command again with a specified ID argument.");
			stringBuilder.AppendLine();
			stringBuilder.Append("List of instances, indexed by their ID:");
			for (int i = 0; i < RoundOverallHistory.Count; i++)
			{
				Footprint ownerFootprint = RoundOverallHistory[i].OwnerFootprint;
				stringBuilder.AppendLine();
				stringBuilder.Append('[');
				stringBuilder.Append(i.ToString());
				stringBuilder.Append("] -> ");
				stringBuilder.Append(ownerFootprint.Nickname);
				stringBuilder.Append(", spawned ");
				AppendTime(stringBuilder, ownerFootprint.Stopwatch.Elapsed);
				stringBuilder.Append(" ago.");
			}
			return StringBuilderPool.Shared.ToStringReturn(stringBuilder);
		}

		public static string PrintHistory(int? specificInstance)
		{
			if (RoundOverallHistory.Count == 0)
			{
				return "There are no recorded SCP-3114 instances this round.";
			}
			if (!specificInstance.HasValue)
			{
				if (RoundOverallHistory.Count != 1)
				{
					return PrintAllInstances();
				}
				specificInstance = 0;
			}
			if (!RoundOverallHistory.TryGet(specificInstance.Value, out var element))
			{
				return "Argument out of range: Invalid instance ID.";
			}
			return element.PrintInstanceHistory(specificInstance.Value);
		}

		public override void SpawnObject()
		{
			base.SpawnObject();
			if (_prevRoundId != RoundRestart.UptimeRounds)
			{
				RoundOverallHistory.Clear();
				_prevRoundId = RoundRestart.UptimeRounds;
			}
			_historyIndex = RoundOverallHistory.Count;
			RoundOverallHistory.Add(new RoundInstance(new Footprint(base.Owner), new List<LoggedIdentity>
			{
				new LoggedIdentity(null, RoleTypeId.None, Stopwatch.StartNew())
			}));
			base.CastRole.CurIdentity.OnStatusChanged += OnStatusChanged;
		}

		public override void ResetObject()
		{
			base.ResetObject();
			History.Clear();
			base.CastRole.CurIdentity.OnStatusChanged -= OnStatusChanged;
		}
	}
}
