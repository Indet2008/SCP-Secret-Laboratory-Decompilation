using System;
using System.Collections.Generic;
using System.Linq;
using PlayerRoles;
using PlayerRoles.RoleAssign;

namespace Metrics
{
	public class ScpPreferencesCollector : MetricsCollectorBase
	{
		[Serializable]
		public struct PrefPair
		{
			public RoleTypeId Role;

			public int Weight;

			public PrefPair(KeyValuePair<RoleTypeId, int> kvp)
			{
				Role = kvp.Key;
				Weight = kvp.Value;
			}
		}

		private enum OptOutExportBehavior
		{
			Include = 0,
			Exclude = 1,
			TreatAsZero = 2
		}

		public PrefPair[] UserPreferences;

		public bool OptOutOfScp;

		public override string ExportDocumentation => "Exports users' SCP spawn preferences, including per-round opt-out rates and the spawn preference weights for individual SCPs.\n- First argument: set to [TRUE] or [FALSE] (default). Set to TRUE to skip entries where all spawn preferences are zero.\n- Second argument: determines how opted-out players are handled. " + $"Use [{OptOutExportBehavior.Include}] to include them (default), " + $"[{OptOutExportBehavior.Exclude}] to skip them entirely, " + $"or [{OptOutExportBehavior.TreatAsZero}] to treat their spawn preferences as if all were set to 0.";

		public override void OnRoundStarted()
		{
			base.OnRoundStarted();
			foreach (ReferenceHub allHub in ReferenceHub.AllHubs)
			{
				if (ScpSpawnPreferences.Preferences.TryGetValue(allHub.connectionToClient.connectionId, out var value))
				{
					RecordSpawnPreferences(value);
				}
			}
		}

		private static void RecordSpawnPreferences(ScpSpawnPreferences.SpawnPreferences sp)
		{
			PrefPair[] array = new PrefPair[sp.Preferences.Count];
			int num = 0;
			foreach (KeyValuePair<RoleTypeId, int> preference in sp.Preferences)
			{
				array[num++] = new PrefPair(preference);
			}
			MetricsCollectorBase.RecordData(new ScpPreferencesCollector
			{
				UserPreferences = array,
				OptOutOfScp = sp.OptOutOfScp
			});
		}

		public override MetricsCsvBuilder[] ExportToCSV(List<RoundMetricsCollection> toExport, ArraySegment<string> args, out string errorMessage)
		{
			string value = ((args.Count > 0) ? args.At(0) : string.Empty);
			string value2 = ((args.Count > 1) ? args.At(1) : string.Empty);
			bool flag = bool.TryParse(value, out var result) & result;
			Enum.TryParse<OptOutExportBehavior>(value2, ignoreCase: true, out var result2);
			Dictionary<RoleTypeId, List<int>> dictionary = new Dictionary<RoleTypeId, List<int>>();
			int num = 0;
			int num2 = 0;
			foreach (ScpPreferencesCollector item2 in toExport.SelectMany((RoundMetricsCollection x) => x.GetOfType<ScpPreferencesCollector>()))
			{
				num++;
				if (item2.OptOutOfScp)
				{
					num2++;
					if (result2 == OptOutExportBehavior.Exclude)
					{
						continue;
					}
				}
				if (!flag || !item2.UserPreferences.All((PrefPair x) => x.Weight == 0))
				{
					PrefPair[] userPreferences = item2.UserPreferences;
					for (int num3 = 0; num3 < userPreferences.Length; num3++)
					{
						PrefPair prefPair = userPreferences[num3];
						int item = ((!item2.OptOutOfScp || result2 != OptOutExportBehavior.TreatAsZero) ? prefPair.Weight : 0);
						dictionary.GetOrAddNew(prefPair.Role).Add(item);
					}
				}
			}
			MetricsCsvBuilder metricsCsvBuilder = new MetricsCsvBuilder(this);
			metricsCsvBuilder.Append($"Opt-out rate,{num2}/{num}");
			foreach (KeyValuePair<RoleTypeId, List<int>> item3 in dictionary)
			{
				metricsCsvBuilder.Append(item3.Key);
				foreach (int item4 in item3.Value)
				{
					metricsCsvBuilder.Append(',');
					metricsCsvBuilder.Append(item4);
				}
				metricsCsvBuilder.AppendLine();
			}
			errorMessage = null;
			return metricsCsvBuilder.ToArray();
		}
	}
}
