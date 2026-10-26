using Mirror;

namespace Utils.Networking
{
	public static class NullableBoolReaderWriter
	{
		private enum NullableBoolValue : byte
		{
			Null = 0,
			True = 1,
			False = 2
		}

		public static void WriteNullableBool(this NetworkWriter writer, bool? val)
		{
			NullableBoolValue value = NullableBoolValue.Null;
			if (val.HasValue)
			{
				value = (val.Value ? NullableBoolValue.True : NullableBoolValue.False);
			}
			writer.WriteByte((byte)value);
		}

		public static bool? ReadNullableBool(this NetworkReader reader)
		{
			NullableBoolValue nullableBoolValue = (NullableBoolValue)reader.ReadByte();
			if (nullableBoolValue != NullableBoolValue.Null)
			{
				return nullableBoolValue == NullableBoolValue.True;
			}
			return null;
		}
	}
}
