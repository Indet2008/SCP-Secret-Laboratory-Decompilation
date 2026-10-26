using System;
using System.Collections.Generic;

namespace Metrics
{
	public abstract class MetricsCollectorBase : IJsonSerializable
	{
		public virtual string ExportDocumentation => null;

		public virtual void OnRoundStarted()
		{
		}

		public virtual void OnRoundEnded(RoundSummary.LeadingTeam winningTeam)
		{
		}

		public virtual void Init()
		{
		}

		public abstract MetricsCsvBuilder[] ExportToCSV(List<RoundMetricsCollection> toExport, ArraySegment<string> args, out string errorMessage);

		protected static void RecordData<T>(T data, bool checkIfRoundActive = true) where T : MetricsCollectorBase
		{
			MetricsAggregator.RecordData(data, checkIfRoundActive);
		}
	}
}
