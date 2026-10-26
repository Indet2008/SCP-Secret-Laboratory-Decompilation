using System;
using System.Collections.Generic;
using System.Linq;
using Mirror;
using PlayerStatsSystem;

namespace Metrics
{
	public class DeathsCollector : MetricsCollectorBase
	{
		private enum ExportPreset
		{
			DeathReasons = 0
		}

		public int VictimLifeId;

		public string HandlerType;

		public string ExtraData;

		public override string ExportDocumentation
		{
			get
			{
				string text = "Available options:";
				string[] names = EnumUtils<ExportPreset>.Names;
				foreach (string text2 in names)
				{
					text = text + "\n- " + text2;
				}
				return text;
			}
		}

		public override void Init()
		{
			base.Init();
			PlayerStats.OnAnyPlayerDied += OnAnyPlayerDied;
		}

		public override MetricsCsvBuilder[] ExportToCSV(List<RoundMetricsCollection> toExport, ArraySegment<string> args, out string errorMessage)
		{
			if (args.Count == 0 || !Enum.TryParse<ExportPreset>(args.At(0), out var result))
			{
				result = ExportPreset.DeathReasons;
			}
			if (result == ExportPreset.DeathReasons)
			{
				errorMessage = null;
				return PrintDeathReasons(toExport).ToArray();
			}
			errorMessage = $"Undefined preset: {result}.";
			return null;
		}

		private void OnAnyPlayerDied(ReferenceHub deadPlayer, DamageHandlerBase damageHandler)
		{
			if (NetworkServer.active)
			{
				MetricsCollectorBase.RecordData(new DeathsCollector
				{
					VictimLifeId = deadPlayer.roleManager.CurrentRole.UniqueLifeIdentifier,
					HandlerType = damageHandler.GetType().Name,
					ExtraData = damageHandler.ServerMetricsText
				});
			}
		}

		private MetricsCsvBuilder PrintDeathReasons(List<RoundMetricsCollection> toExport)
		{
			MetricsCsvBuilder result = new MetricsCsvBuilder(this);
			result.Append("Handler type,Extra data");
			result.AppendLine();
			foreach (DeathsCollector item in toExport.SelectMany((RoundMetricsCollection x) => x.GetOfType<DeathsCollector>()))
			{
				result.Append(item.HandlerType);
				result.Append(',');
				result.Append(item.ExtraData);
				result.AppendLine();
			}
			return result;
		}
	}
}
