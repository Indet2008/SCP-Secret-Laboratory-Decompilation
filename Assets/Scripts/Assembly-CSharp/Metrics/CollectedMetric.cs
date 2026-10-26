using System;
using GameCore;

namespace Metrics
{
	public struct CollectedMetric : IJsonSerializable
	{
		public string Type;

		public string Data;

		public float RoundTime;

		public CollectedMetric(Type type, string jsonData)
		{
			Type = type.Name;
			Data = jsonData;
			RoundTime = (float)RoundStart.RoundLength.TotalSeconds;
		}
	}
}
