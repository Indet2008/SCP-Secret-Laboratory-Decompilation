using System;
using System.Collections.Generic;

namespace Metrics
{
	public class RoundSummaryCollector : MetricsCollectorBase
	{
		public RoundSummary.LeadingTeam WonTeam;

		public override string ExportDocumentation => "Saves round duration (in seconds) and winning team.";

		public override void OnRoundEnded(RoundSummary.LeadingTeam winningTeam)
		{
			base.OnRoundEnded(winningTeam);
			MetricsCollectorBase.RecordData(new RoundSummaryCollector
			{
				WonTeam = winningTeam
			}, checkIfRoundActive: false);
		}

		public override MetricsCsvBuilder[] ExportToCSV(List<RoundMetricsCollection> toExport, ArraySegment<string> args, out string errorMessage)
		{
			MetricsCsvBuilder metricsCsvBuilder = new MetricsCsvBuilder(this);
			foreach (RoundMetricsCollection item in toExport)
			{
				KeyValuePair<float, RoundSummaryCollector>[] ofTypeWithTimestamp = item.GetOfTypeWithTimestamp<RoundSummaryCollector>();
				for (int i = 0; i < ofTypeWithTimestamp.Length; i++)
				{
					KeyValuePair<float, RoundSummaryCollector> keyValuePair = ofTypeWithTimestamp[i];
					metricsCsvBuilder.Append(MathF.Round(keyValuePair.Key, 1));
					metricsCsvBuilder.Append(',');
					metricsCsvBuilder.Append(keyValuePair.Value.WonTeam);
					metricsCsvBuilder.AppendLine();
				}
			}
			errorMessage = null;
			return metricsCsvBuilder.ToArray();
		}
	}
}
