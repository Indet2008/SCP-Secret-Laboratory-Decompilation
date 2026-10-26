namespace Mirror
{
	public static class LagCompensation
	{
		public static void Insert<T>(global::System.Collections.Generic.Queue<global::System.Collections.Generic.KeyValuePair<double, T>> history, int historyLimit, double timestamp, T capture) where T : global::Mirror.Capture
		{
			if (history.Count >= historyLimit)
			{
				history.Dequeue();
			}
			history.Enqueue(new global::System.Collections.Generic.KeyValuePair<double, T>(timestamp, capture));
		}

		public static bool Sample<T>(global::System.Collections.Generic.Queue<global::System.Collections.Generic.KeyValuePair<double, T>> history, double timestamp, double interval, out T before, out T after, out double t) where T : global::Mirror.Capture
		{
			before = default;
			after = default;
			t = 0.0;
			if (history.Count < 2)
			{
				return false;
			}
			if (timestamp < history.Peek().Key)
			{
				return false;
			}
			global::System.Collections.Generic.KeyValuePair<double, T> keyValuePair = default;
			global::System.Collections.Generic.KeyValuePair<double, T> keyValuePair2 = default;
			foreach (global::System.Collections.Generic.KeyValuePair<double, T> item in history)
			{
				if (timestamp == item.Key)
				{
					before = item.Value;
					after = item.Value;
					t = global::Mirror.Mathd.InverseLerp(before.timestamp, after.timestamp, timestamp);
					return true;
				}
				if (item.Key > timestamp)
				{
					before = keyValuePair.Value;
					after = item.Value;
					t = global::Mirror.Mathd.InverseLerp(before.timestamp, after.timestamp, timestamp);
					return true;
				}
				keyValuePair2 = keyValuePair;
				keyValuePair = item;
			}
			if (keyValuePair.Key < timestamp && timestamp <= keyValuePair.Key + interval)
			{
				before = keyValuePair2.Value;
				after = keyValuePair.Value;
				t = 1.0 + global::Mirror.Mathd.InverseLerp(after.timestamp, after.timestamp + interval, timestamp);
				return true;
			}
			return false;
		}

		public static double EstimateTime(double serverTime, double rtt, double bufferTime)
		{
			double num = rtt / 2.0;
			return serverTime - num - bufferTime;
		}

		public static void DrawGizmos<T>(global::System.Collections.Generic.Queue<global::System.Collections.Generic.KeyValuePair<double, T>> history) where T : global::Mirror.Capture
		{
			foreach (global::System.Collections.Generic.KeyValuePair<double, T> item in history)
			{
				item.Value.DrawGizmo();
			}
		}
	}
}
