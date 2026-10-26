using System;
using Mirror;

namespace Hints
{
	public class TimespanHintParameter : DoubleHintParameter
	{
		protected bool Negate { get; private set; }

		protected TimeSpan OffsetTime
		{
			get
			{
				TimeSpan result = TimeSpan.FromSeconds(base.Value - NetworkTime.time);
				if (!Negate)
				{
					return result;
				}
				return result.Negate();
			}
		}

		public new static TimespanHintParameter FromNetwork(NetworkReader reader)
		{
			TimespanHintParameter timespanHintParameter = new TimespanHintParameter();
			timespanHintParameter.Deserialize(reader);
			return timespanHintParameter;
		}

		public static TimespanHintParameter FromOffset(double offset, string format, bool negate)
		{
			return new TimespanHintParameter(NetworkTime.time + offset, format, negate);
		}

		public static TimespanHintParameter FromOffset(TimeSpan offset, string format, bool negate)
		{
			return FromOffset(offset.TotalSeconds, format, negate);
		}

		protected TimespanHintParameter()
		{
		}

		public TimespanHintParameter(double sourceTime, string format, bool negate)
			: base(sourceTime, format)
		{
			Negate = negate;
		}

		public TimespanHintParameter(DateTimeOffset sourceTime, string format, bool negate)
			: this((sourceTime - DateTimeOffset.UtcNow).TotalSeconds, format, negate)
		{
		}

		public override void Deserialize(NetworkReader reader)
		{
			base.Deserialize(reader);
			Negate = reader.ReadBool();
		}

		public override void Serialize(NetworkWriter writer)
		{
			base.Serialize(writer);
			writer.WriteBool(Negate);
		}

		protected override string UpdateState(float progress)
		{
			return OffsetTime.ToString(base.Format);
		}
	}
}
