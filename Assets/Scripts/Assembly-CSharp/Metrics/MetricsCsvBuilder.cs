using System.Text;

namespace Metrics
{
	public readonly struct MetricsCsvBuilder
	{
		public readonly string Filename;

		public readonly StringBuilder StrBuilder;

		public static string TimestampNow => TimeBehaviour.FormatTime("yyyy-MM-dd HH.mm.ss");

		public MetricsCsvBuilder(MetricsCollectorBase source, string filename = null)
		{
			if (filename == null)
			{
				filename = "Export {0}";
			}
			if (source != null)
			{
				filename = source.GetType().Name.Replace("Collector", string.Empty) + "/" + filename;
			}
			Filename = string.Format(filename.TrimEnd('.') + ".csv", TimestampNow);
			StrBuilder = new StringBuilder();
		}

		public void Append(string str)
		{
			StrBuilder.Append(str);
		}

		public void Append(object obj)
		{
			StrBuilder.Append(obj);
		}

		public void Append(char ch)
		{
			StrBuilder.Append(ch);
		}

		public void AppendLine()
		{
			StrBuilder.AppendLine();
		}

		public void AppendColumn(string str)
		{
			StrBuilder.Append(str);
			StrBuilder.Append(',');
		}

		public void AppendColumn(object obj)
		{
			StrBuilder.Append(obj);
			StrBuilder.Append(',');
		}

		public MetricsCsvBuilder[] ToArray()
		{
			return new MetricsCsvBuilder[1] { this };
		}
	}
}
