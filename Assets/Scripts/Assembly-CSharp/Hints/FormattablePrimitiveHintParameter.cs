using System;
using Mirror;

namespace Hints
{
	public abstract class FormattablePrimitiveHintParameter<TValue> : PrimitiveHintParameter<TValue>
	{
		private readonly Func<TValue, string, string> _formatter;

		protected string Format { get; private set; }

		protected FormattablePrimitiveHintParameter(TValue value, string format, Func<TValue, string, string> formatter, Func<NetworkReader, TValue> deserializer, Action<NetworkWriter, TValue> serializer)
			: base(value, deserializer, serializer)
		{
			_formatter = formatter;
			Format = format;
		}

		protected FormattablePrimitiveHintParameter(Func<TValue, string, string> formatter, Func<NetworkReader, TValue> deserializer, Action<NetworkWriter, TValue> serializer)
			: this(default(TValue), string.Empty, formatter, deserializer, serializer)
		{
		}

		public override void Deserialize(NetworkReader reader)
		{
			base.Deserialize(reader);
			Format = reader.ReadString();
		}

		public override void Serialize(NetworkWriter writer)
		{
			base.Serialize(writer);
			writer.WriteString(Format);
		}

		protected override string FormatValue(float progress, out bool stopFormatting)
		{
			stopFormatting = true;
			return _formatter(base.Value, Format);
		}
	}
}
