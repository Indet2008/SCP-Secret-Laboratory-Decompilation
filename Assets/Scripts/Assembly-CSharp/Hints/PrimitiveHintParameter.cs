using System;
using Mirror;

namespace Hints
{
	public abstract class PrimitiveHintParameter<TValue> : HintParameter
	{
		private readonly Func<NetworkReader, TValue> _deserializer;

		private readonly Action<NetworkWriter, TValue> _serializer;

		private bool _stopFormatting;

		protected TValue Value { get; private set; }

		protected PrimitiveHintParameter(Func<NetworkReader, TValue> deserializer, Action<NetworkWriter, TValue> serializer)
		{
			_deserializer = deserializer;
			_serializer = serializer;
		}

		protected PrimitiveHintParameter(TValue value, Func<NetworkReader, TValue> deserializer, Action<NetworkWriter, TValue> serializer)
			: this(deserializer, serializer)
		{
			Value = value;
		}

		public override void Deserialize(NetworkReader reader)
		{
			Value = _deserializer(reader);
		}

		public override void Serialize(NetworkWriter writer)
		{
			_serializer(writer, Value);
		}

		protected override string UpdateState(float progress)
		{
			if (!_stopFormatting)
			{
				return FormatValue(progress, out _stopFormatting);
			}
			return null;
		}

		protected virtual string FormatValue(float progress, out bool stopFormatting)
		{
			stopFormatting = true;
			return Value.ToString();
		}
	}
}
