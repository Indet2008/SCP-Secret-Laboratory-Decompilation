using System;
using System.Collections.Generic;
using System.IO;
using GameCore;
using Mirror;
using Mirror.LiteNetLib4Mirror;
using UnityEngine;
using Utf8Json;
using Utils.NonAllocLINQ;

namespace Metrics
{
	public static class MetricsAggregator
	{
		public static readonly HashSet<MetricsCollectorBase> Collectors = new HashSet<MetricsCollectorBase>
		{
			new DeathsCollector(),
			new RoleChangeCollector(),
			new RoundSummaryCollector(),
			new ScpPreferencesCollector()
		};

		private const string SaveConfigKey = "save_metrics";

		private const bool SaveConfigDefault = true;

		private static bool _roundActive;

		private static bool _metricsSavingEnabled;

		private static readonly List<CollectedMetric> CollectedMetrics = new List<CollectedMetric>();

		[RuntimeInitializeOnLoadMethod]
		private static void Init()
		{
			Collectors.ForEach((MetricsCollectorBase x) =>
			{
				x.Init();
			});
			RoundSummary.OnRoundEnded += OnRoundEnded;
			CharacterClassManager.ServerOnRoundStartTriggered += OnRoundStarted;
			ReloadConfig();
			ConfigFile.OnConfigReloaded = (Action)Delegate.Combine(ConfigFile.OnConfigReloaded, new Action(ReloadConfig));
		}

		private static void ReloadConfig()
		{
			_metricsSavingEnabled = ConfigFile.ServerConfig.GetBool("save_metrics", def: true);
		}

		private static void OnRoundStarted()
		{
			if (NetworkServer.active)
			{
				_roundActive = true;
				Collectors.ForEach((MetricsCollectorBase x) =>
				{
					x.OnRoundStarted();
				});
			}
		}

		private static void OnRoundEnded(RoundSummary.LeadingTeam winner, RoundSummary.SumInfo_ClassList sumInfo)
		{
			if (!NetworkServer.active)
			{
				return;
			}
			_roundActive = false;
			foreach (MetricsCollectorBase collector in Collectors)
			{
				collector.OnRoundEnded(winner);
			}
			if (_metricsSavingEnabled)
			{
				try
				{
					ushort port = LiteNetLib4MirrorTransport.Singleton.port;
					string text = $"{FileManager.GetAppFolder()}Metrics/{port}";
					Directory.CreateDirectory(text);
					string text2 = TimeBehaviour.FormatTime("yyyy-MM-dd HH.mm.ss");
					using StreamWriter streamWriter = new StreamWriter(text + "/Round " + text2 + ".json");
					RoundMetricsCollection value = new RoundMetricsCollection(CollectedMetrics);
					streamWriter.Write(JsonSerializer.ToJsonString(value));
				}
				catch (Exception exception)
				{
					Debug.LogException(exception);
				}
			}
			CollectedMetrics.Clear();
		}

		public static void RecordData<T>(T data, bool checkIfRoundActive) where T : MetricsCollectorBase
		{
			if (NetworkServer.active && (!checkIfRoundActive || _roundActive))
			{
				if (data == null)
				{
					throw new ArgumentNullException("data", "Attempting to record a null metric.");
				}
				if (Collectors.Contains(data))
				{
					throw new ArgumentException("Cannot record the static collector definition. Create a new instance to record data.");
				}
				string jsonData = JsonSerializer.ToJsonString(data);
				CollectedMetrics.Add(new CollectedMetric(typeof(T), jsonData));
			}
		}
	}
}
