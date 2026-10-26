using System;
using System.Collections.Generic;
using Mirror;
using PlayerRoles;

namespace Metrics
{
	public class RoleChangeCollector : MetricsCollectorBase
	{
		public int PrevLifeId;

		public int NewLifeId;

		public RoleTypeId NewRole;

		public RoleChangeReason ChangeReason;

		public override void Init()
		{
			base.Init();
			PlayerRoleManager.OnRoleChanged += OnRoleChanged;
		}

		public override MetricsCsvBuilder[] ExportToCSV(List<RoundMetricsCollection> toExport, ArraySegment<string> args, out string errorMessage)
		{
			errorMessage = null;
			List<MetricsCsvBuilder> list = new List<MetricsCsvBuilder>();
			foreach (RoundMetricsCollection item2 in toExport)
			{
				MetricsCsvBuilder item = new MetricsCsvBuilder(this, $"Export {0}/Round {list.Count}");
				item.Append("RoundTime,PrevLifeId,NewLifeId,NewRole,ChangeReason");
				KeyValuePair<float, RoleChangeCollector>[] ofTypeWithTimestamp = item2.GetOfTypeWithTimestamp<RoleChangeCollector>();
				for (int i = 0; i < ofTypeWithTimestamp.Length; i++)
				{
					KeyValuePair<float, RoleChangeCollector> keyValuePair = ofTypeWithTimestamp[i];
					item.AppendLine();
					item.AppendColumn(keyValuePair.Key);
					item.AppendColumn(keyValuePair.Value.PrevLifeId);
					item.AppendColumn(keyValuePair.Value.NewLifeId);
					item.AppendColumn(keyValuePair.Value.NewRole);
					item.AppendColumn(keyValuePair.Value.ChangeReason);
				}
				list.Add(item);
			}
			errorMessage = null;
			return list.ToArray();
		}

		private void OnRoleChanged(ReferenceHub userHub, PlayerRoleBase prevRole, PlayerRoleBase newRole)
		{
			if (NetworkServer.active)
			{
				MetricsCollectorBase.RecordData(new RoleChangeCollector
				{
					PrevLifeId = prevRole.UniqueLifeIdentifier,
					NewLifeId = newRole.UniqueLifeIdentifier,
					NewRole = newRole.RoleTypeId,
					ChangeReason = newRole.ServerSpawnReason
				});
			}
		}
	}
}
